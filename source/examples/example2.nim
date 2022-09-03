## Commandant - Example 2 - Nearly all features shown

import ../commandant, strformat

const myProgramVersion = "0.5.4"

proc helpMessage(): string =
  result = """
  pico-nim project template builder
  Usage: example2 <subcommand> <subcommand options> <sillyArg>
  Available subcommands: 
    init : initialize the project
      arguments:
        name [string] - name of the project directory and program
      flags:
        overrideTemplate - overwrite an existing directory
      options:
        sdk [string] ("sdk", "s") - define a pre-installed pico-sdk
        nimbase [string] ("nimbase", "h") - give path to nimbase.h file
    
    build : create a .uf2 file for the pico
      arguments:
        mainProgram [string] - give the name of the main *.nim file in src/ folder
      options:
        output [string] ("output", "o") - define an output path for .uf2 file
  
  sillyArg [float]: demo argument
  """

commandline:
  argument(sillyArg, float) 
  exitoption("help", "h", helpMessage())
  exitoption("version", "v", myProgramVersion)
  errormsg("you have made some kind of mistake")
  subcommand init, "init", "i":
    argument(name, string)
    flag(override, "override", "O")
    option(sdk, string, "sdk", "s")
    option(nimbase, string, "nimbase", "h")
    exitoption("help", "h", "I wish i could help you, but I can't")
  subcommand build, "build", "b":
    argument(mainProgram, string)
    option(output, string,"output", "o", "source/build")
  
if init:
  echo fmt"creating a new project directory, {name}. One second..."
elif build:
  echo fmt"writing {name}.uf2 to {output}..."
else:
  echo "please use either the 'init' or 'build' subcommand..."
  echo helpMessage()
  
