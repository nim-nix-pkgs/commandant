import ../commandant

commandline:
  argument first_required, string
  option first_optional, string, "optional1", "o1"

echo first_required , " " , first_optional