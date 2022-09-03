# Package

version     = "0.15.1"
author      = "Casey McMahon"
description = "Commandant is a simple to use library for parsing command line arguments. Commandant is ideal for writing terminal applications, with  support for flags, options, subcommands, and custom exit options."
license     = "MIT"

installFiles = @["commandant.nim"]

# Dependencies

requires "nim >= 1.0.0"

task test, "Run the commandant tester":
  exec "nim c --run --hints:off tests/tester"

