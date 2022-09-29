cd("0:/").

clearscreen.

Print "FALCON 9 LAUNCH SOFTWARE v5.1" at ( 2, 1).
Print "-------------------------------------" at ( 2, 2).
Print "____________________________________" at ( 3, 7).
print "Press Action Group 7 to initiate Startup".
WAIT UNTIL AG7.
	run F9LaunchSoftware.