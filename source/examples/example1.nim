## Commandant - example 1 - a trivial case

import ../commandant, strformat

commandline:
  argument(value, int)
  flag(selfDestruct, "destroy", "d")
  option(timer, float, "time", "t", 12.0) # last parameter is a default value

  # if you define an argument, then you are REQUIRED to always provide a value.
  #     commandant will terminate the program if an argument is missing.
  # conversely, flags are optional and the program will run whether they are 
  #     provided or not.
  # options are also optional

if selfDestruct:
  echo fmt"Using {value} volts, the computer will go to sleep in {timer} minutes"  
else:
  echo fmt"I will continue to perform my duties, running at {value} Hz"