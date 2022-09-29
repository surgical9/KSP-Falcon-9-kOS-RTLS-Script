clearscreen.

BRAKES ON.																	//extends grid fins

if ADDONS:TR:AVAILABLE {
    			if ADDONS:TR:HASIMPACT {
       			 PRINT ADDONS:TR:IMPACTPOS.
    			} else {
       			 PRINT "Impact position is not available".
   			 }
			} else {
   			 PRINT "Trajectories is not available.".
			}
SET runMode to 0.

when throttle = 0 then { 
      set STEERINGMANAGER:MAXSTOPPINGTIME to 15.
      set STEERINGMANAGER:PITCHPID:KD to 2.
      set STEERINGMANAGER:YAWPID:KD to 2.
preserve.	
} 

when throttle > 0 then {
      set STEERINGMANAGER:MAXSTOPPINGTIME to 15.
      set STEERINGMANAGER:PITCHPID:KD to 1.
      set STEERINGMANAGER:YAWPID:KD to 1.
preserve.
}
RCS on.
SAS off.
SET landingpad TO latlng(28.6084183803222,-80.5974771409043). 				//input the landing latlng() here
SET targetDistOld TO 0.
SET landingpoint TO ADDONS:TR:IMPACTPOS.
set lngoff to (landingpad:LNG - ADDONS:TR:IMPACTPOS:LNG)*10472.
set latoff to (landingpad:LAT - ADDONS:TR:IMPACTPOS:LAT)*10472.
RCS on.
lock steering to heading ((landingpad:heading-180), 40).     				//all this is used to get around the problem of kOS' slow and inefficient steering problem
wait 0.5.
lock steering to heading ((landingpad:heading-180), 50).
wait 0.5.
lock steering to heading ((landingpad:heading-180), 60).
wait 0.5.
lock steering to heading ((landingpad:heading-180), 70).
wait 0.5.
lock steering to heading ((landingpad:heading-180), 80).
wait 0.5.
lock steering to lookDirUp( up:forevector, ship:facing:topvector).
lock steering to heading (landingpad:heading, 80).
wait 0.5.
lock steering to heading (landingpad:heading, 70).
wait 0.5.
lock steering to heading (landingpad:heading, 60).
wait 0.5.
lock steering to heading (landingpad:heading, 50).
wait 0.5.
lock steering to heading (landingpad:heading, 40).
wait 0.5.
lock steering to heading (landingpad:heading, 30).
wait 0.5.
lock steering to heading (landingpad:heading, 20).
wait 0.5.
lock steering to heading (landingpad:heading, 10).
wait 0.5.
lock steering to heading (landingpad:heading, 0).
wait 0.5.
lock throttle to 1.
RCS off.
when altitude > 4000 then {
		set lngoff to (landingpad:LNG - ADDONS:TR:IMPACTPOS:LNG)*10472.
		set latoff to (landingpad:LAT - ADDONS:TR:IMPACTPOS:LAT)*10472.
		wait 0.1.
		preserve.
		}

when lngoff > 1000 then {
		
		lock throttle to 0.4.
		}
				
when lngoff > 500 then {  													//how far past the landing pad your impact position should be so that after the entry burn the impact position will be roughly near the landing pad. Experiment with this until you get what you desire
		SET throttle TO 0.
		unlock throttle.
        lock steering to (-1) * SHIP:VELOCITY:SURFACE.						//Keeps the ship engines pointed towards the ground
        wait until ship:verticalspeed < -300.
        run F9LandingSoftware. 												//landing guidance start
		}
																			//fine tuning values for latitude
When throttle > 0 then {
when latoff < -20 then {
lock steering to heading (landingpad:Heading - 2,0).
preserve.
}

when latoff > 20 then {
lock steering to heading (landingpad:heading + 2,0).
preserve.
}

}

wait until ship:verticalspeed < -5.
print ">>Boostback burn succesful". 										//I reccommend turning on Mechjeb's SVEL- for this coast phase
unlock steering.
wait until ship:verticalspeed < 300.
    run F9LandingSoftware.