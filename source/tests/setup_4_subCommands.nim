import ../commandant
import strformat

proc usage(): string =
  result = "Usage: testSubCommands [--noop | --version] <COMMAND> [<OPTIONS>]"

commandline:
  subcommand add, "add", "a":
    arguments filenames, string
    option force, bool, "force", "f"
    option interactive, bool, "interactive", "i"
    exitoption "help", "h", "add help"
  subcommand clone, "clone":
    argument gitUrl, string
    exitoption "help", "h", "clone help"
  subcommand push, ["push", "p","theoppositeofpull"]:
    exitoption "help", "h", "push help"
  exitoption "help", "h", "general help"
  errormsg usage()

if add or clone:
  echo fmt"{filenames} {force} {interactive} {clone}"
  # @["clone", "bar", "baz"] true false false
if push: 
  echo push
  