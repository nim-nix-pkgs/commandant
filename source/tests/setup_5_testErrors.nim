import ../commandant
import strformat

commandline:
  arguments numbers, int
  option fraction, float, "fraction", "f"
  option testing, bool, "testing", "t"
  errormsg "Usage: <numbers: int...> [--fraction|-f: float] [--testing]"