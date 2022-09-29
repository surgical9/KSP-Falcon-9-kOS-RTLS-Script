# KSP-Falcon-9-kOS-RTLS-Script
A kOS RTLS script for launch vehicles in KSP
For KSP v1.12.3

Configure the .ks files to your ship specs and preferences
You need to change the coordinates in both "F9BoostbackSoftware.ks" and "F9LandingSoftware.ks"

Ingame:
Setup the First Stage to boot "F9Stage1Bootfile.ks"
Setup the Second Stage to boot "F9Stage2Bootfile.ks"

Use the action groups (keys) to initiate the programs
=====================================================================================================================================
To use the premade Falcon 9, place the contents from "Falcon 9 Part File" in "\saves\your save\Ships/VAB"
Note: The ship requires the mods in the "modlist"
=====================================================================================================================================
Place "Merlin1_Config.cfg" in "\GameData\RealismOverhaul\Engine_Configs"

What it does: Changes the Merlin 1D++ To have a shorter spool up time "throttleResponseRate = 2.0" (0.65s) and a min thrust of 10%
=====================================================================================================================================
REQUIRES:
- kOS v1.3.2.0
- Trajectories v2.4.3

Note:
This script is tuned for my Falcon 9, which is as close to the real thing, meaning the mass, height, diameter and other specs are as close as possible.
You may need to config the script in order to tune it to your launch vehicle.
