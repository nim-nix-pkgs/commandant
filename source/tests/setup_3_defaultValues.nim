import ../commandant
import strformat

commandline:
  option(file, string, "file", "f", default="foo.txt")
  option silly, bool, "silly", "s", true
  option(mode, char, "mode", "m", default='r')
  option(number, int, short="n", long="number", default=1)
  option(rational, float, "rational", "r", default=3.6)
  option testing, bool, "testing", "t"

  let msg = fmt"{file} {silly} {mode} {number} {rational}"

  echo msg