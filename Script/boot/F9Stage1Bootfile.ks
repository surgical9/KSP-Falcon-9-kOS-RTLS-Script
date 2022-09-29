cd("0:/").

clearscreen.

Print "FALCON 9 BOOSTBACK SOFTWARE v5.1" at ( 2, 1).
Print "-------------------------------------" at ( 2, 2).
Print "____________________________________" at ( 3, 7).
print "After MECO press Action Group 8 to initiate RTLS".
WAIT UNTIL AG8.
	run F9BoostbackSoftware.