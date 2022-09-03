import ../commandant
import strformat

proc helper(): string = 
  result = "Usage: program <int> <float> <char> <bool> <string>..."

proc error(): string = 
  result = "An error has occured..."

commandline:
  argument integer, int
  argument floatingPoint, float
  argument character, char
  argument boolean, bool           
  arguments strings, string
  option optionalInteger, int, "int", "i"
  flag optionalFlag, "flag", "f"
  exitoption "help", "h", helper()
  exitoption "version", "v", "1.0.0"
  errormsg error()

let message = fmt"{integer} {floatingPoint} {character} {boolean} {strings} {optionalInteger} {optionalFlag}"

echo message