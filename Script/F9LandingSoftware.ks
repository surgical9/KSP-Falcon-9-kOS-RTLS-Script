clearscreen.

Print "FALCON 9 LANDING SOFTWARE v5.1" at ( 2, 1).
Print "-------------------------------------" at ( 2, 2).
Print "____________________________________" at ( 3, 7).

TOGGLE AG10.																						//Switches to 3 engines (action group 10)

clearscreen.

parameter landingsite is latlng(28.6084183803222,-80.5974771409043).								//input the landing latlng() here
set radarOffset to 45.2.																			//input the height of the vehicle when legs extended				
lock trueRadar to alt:radar - radarOffset.															//this is all the suicide burn calculation					
lock g to constant:g * body:mass / body:radius^2.			
lock maxDecel to (ship:availablethrust / ship:mass) - g.	
lock stopDist to ship:verticalspeed^2 / (2 * maxDecel).		
lock idealThrottle to stopDist / trueRadar.					
lock impactTime to trueRadar / abs(ship:verticalspeed).	
lock aoa to 10. 																					//the mazimum angle you want your ship to angle itself at to move the impact position towards the landingsite
lock errorScaling to 1.

function getImpact {																				//all the functions are here
    if addons:tr:hasimpact { return addons:tr:impactpos. }       									//looks for the impact position given by Trajectories      
        return ship:geoposition.
}
function lngError {                                    												//giving the lat and lng error values a vector so the ship can correct it for this
    return getImpact():lng - landingsite:lng.
}
function latError {
    return getImpact():lat - landingsite:lat.
}

function errorVector {
    return getImpact():position - landingSite:position.
}

function getSteering {            																	//the function for steering is here, the functions and vectors are calculated here and used elsewhere
    
    local errorVector is errorVector().
        local velVector is -ship:velocity:surface.
        local result is velVector + errorVector*errorScaling.
        if vang(result, velVector) > aoa
        {
            set result to velVector:normalized
                          + tan(aoa)*errorVector:normalized.
        }

        return lookdirup(result, facing:topvector).
    }

RCS on.																								//entry burn starts here, change the verticalspeed to your desired values
lock steering to srfretrograde. 
wait until SHIP:ALTITUDE < 65000.
    lock throttle to 1.
	print ">>Booster entry burn startup".
	RCS off.

wait until ship:verticalspeed > -310.
    lock throttle to 0.
	print ">>Booster entry burn shutdown".
    print ">>Performing aerodescent".
    lock steering to getSteering().

wait until alt:radar < 12000.																		//reduces angle of attack to change with the increasing ambient air pressure to prevent overcorrecting
    lock aoa to 7.5.

wait until alt:radar < 7000. 																		//again, reduces AOA for accuracy for the changine ambient air pressure
    lock aoa to 5.

WAIT UNTIL ship:verticalspeed < -10. 
	rcs on.
	
WAIT UNTIL alt:radar < 5650. 																		//suicide burn starts here
    lock throttle to idealThrottle.
	print ">>Performing suicide burn".
    lock aoa to -3. 																				//Negative AOA means the vessel will make the small correction maneuvers on the opposite hemisphere of the navball rather than when the engine isn't burning due to the thrust from the engine pushing it upwards and horizontally depending on the horizontal speed
    lock steering to getSteering().																	//lock steering to the required correction maneuvers
    when impactTime <3.5 then lock steering to lookDirUp(up:forevector, ship:facing:topvector).		//locks steering to surface retrograde to stop correcting for impact potition when very close to surface

wait until alt:radar < 350.																			//gear deployment variable, change it to whatever you'd like
    gear on.
	legs on.
   
WAIT UNTIL ship:verticalspeed > -0.1. 																//there you go, The falcon has landed
    print "FALCON 9 TOUCHDOWN".
	set ship:control:pilotmainthrottle to 0.
	RCS off.