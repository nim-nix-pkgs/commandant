import osproc, strutils, strformat, unittest

suite "Trivial test":
  test "1 = 1":
    check 1 == 1

suite "Test with three basic argument types":
  setup: 
    const providedOpts = "15 -f -o:23.4"
    const expectedValue = "15 true 23.4"
    let (output, _ ) = execCmdEx(fmt"nim c -r --stdout:off --hints:off -w:off tests/setup_1_basic.nim {providedOpts}")

  test """ "15 -f -o:23.4" = "15 true 23.4" """:
    check output.strip() == expectedValue

suite "Test with all argument types":
  setup: 
    const providedOpts = "-i:36 15 24.3 --flag k true one two three"
    const expectedValue = """15 24.3 k true @["one", "two", "three"] 36 true"""
    let (output, _ ) = execCmdEx(fmt"nim c -r --stdout:off --hints:off -w:off tests/setup_2_moreArgs.nim {providedOpts}")
  
  test """ "-i:36 15 24.3 --flag k true one two three" = "15 24.3 k true @["one", "two", "three"] 36 true" """:
    check output.strip() == expectedValue

suite "Test exit options":
  setup: 
    const providedOpts1 = "--help"
    const expectedValue1 = "Usage: program <int> <float> <char> <bool> <string>..."
    let (output1, _ ) = execCmdEx(fmt"nim c -r --stdout:off --hints:off -w:off tests/setup_2_moreArgs.nim {providedOpts1}")

    const providedOpts2 = "-v"
    const expectedValue2 = "1.0.0"
    let (output2, _ ) = execCmdEx(fmt"nim c -r --stdout:off --hints:off -w:off tests/setup_2_moreArgs.nim {providedOpts2}")
  
    const providedOpts3 = "-hv"
    const expectedValue3 = "Usage: program <int> <float> <char> <bool> <string>..."
    let (output3, _ ) = execCmdEx(fmt"nim c -r --stdout:off --hints:off -w:off tests/setup_2_moreArgs.nim {providedOpts3}")
  
  test """ "-h" = "{help message}" """:
    check output1.strip() == expectedValue1
  test """ "-v" = "1.0.0" """:
    check output2.strip() == expectedValue2
  
  test """ "-hv" = "{help message}" """:
    check output3.strip() == expectedValue3

suite "Test subcommands":
  setup:
    const providedOpts1 = "clone --help"
    const expectedValue1 = "clone help"
    let (output1, _ ) = execCmdEx(fmt"nim c -r --stdout:off --hints:off -w:off tests/setup_4_subCommands.nim {providedOpts1}")
    
    const providedOpts2 = "add -f clone bar baz"
    const expectedValue2 = """@["clone", "bar", "baz"] true false false"""
    let (output2, _ ) = execCmdEx(fmt"nim c -r --stdout:off --hints:off -w:off tests/setup_4_subCommands.nim {providedOpts2}")
    
    const providedOpts3 = "a -f clone bar baz"
    const expectedValue3 = """@["clone", "bar", "baz"] true false false"""
    let (output3, _ ) = execCmdEx(fmt"nim c -r --stdout:off --hints:off -w:off tests/setup_4_subCommands.nim {providedOpts3}")
  
    const providedOpts4 = "p"
    const expectedValue4 = "true"
    let (output4, _ ) = execCmdEx(fmt"nim c -r --stdout:off --hints:off -w:off tests/setup_4_subCommands.nim {providedOpts4}")
    

  test "subcommand specfic exit options work correctly":
    check output1.strip() == expectedValue1
  
  test "subcommand arguments are mapped correctly":
    check output2.strip() == expectedValue2
  
  test "subcommand names and aliases map correctly":
    check output3.strip() == expectedValue3
  
  test "subcommand with array of aliases map correctly":
    check output4.strip() == expectedValue4

suite "Default values work":
  setup:
    const expectedValue = "foo.txt true r 1 3.6"
    let (output, _ ) = execCmdEx(fmt"nim c -r --stdout:off --hints:off -w:off tests/setup_3_defaultValues.nim")


  test """ "" = "foo.txt true r 1 3.6" """:
    check output.strip() == expectedValue

suite "Test error messages":
  setup:
    const providedOpts1 = "1 2.0 '?' -i:10 false"
    const expectedValue1 = 1
    let ( _ , errorCode1 ) = execCmdEx(fmt"nim c -r --stdout:off --hints:off -w:off tests/setup_2_moreArgs.nim {providedOpts1}")
    
    const providedOpts2 = "1.0"
    const expectedValue2 = 1
    let ( _ , errorCode2 ) = execCmdEx(fmt"nim c -r --stdout:off --hints:off -w:off tests/setup_5_testErrors.nim {providedOpts2}")
    
    const providedOpts3 = "1 --fraction"
    const expectedValue3 = 1
    let ( _ , errorCode3 ) = execCmdEx(fmt"nim c -r --stdout:off --hints:off -w:off tests/setup_5_testErrors.nim {providedOpts3}")
    
    const providedOpts4 = "1 --fraction abc"
    const expectedValue4 = 1
    let ( _ , errorCode4 ) = execCmdEx(fmt"nim c -r --stdout:off --hints:off -w:off tests/setup_5_testErrors.nim {providedOpts4}")
    
    const providedOpts5 = ""
    const expectedValue5 = "0"
    let ( output5 , _ ) = execCmdEx(fmt"nim c -r --stdout:off --hints:off -w:off tests/setup_8_optionalMultiple.nim {providedOpts5}")
    
    const providedOpts6 = ""
    const expectedValue6 = 1
    let ( _ , errorCode6 ) = execCmdEx(fmt"nim c -r --stdout:off --hints:off -w:off tests/setup_7_multiple.nim {providedOpts6}")
    

  test "Missing arguments echoes a message":
    check errorCode1 == expectedValue1

  test "Incorrect argument type echoes a message":
    check errorCode2 == expectedValue2
  
  test "Missing option echoes a message":
    check errorCode3 == expectedValue3
  
  test "Incorrect option type echoes a message":
    check errorCode4 == expectedValue4
  
  test "Missing arguments for arguments template without atLeast1 DOES NOT echo a message":
    check output5.strip() == expectedValue5

  test "Missing required argument after optional arguments echoes a message":
    check errorCode6 == expectedValue6

suite "Whitespace check":
  setup:
    const providedOpts = "--optional1 2 1"
    const expectedValue = "1 2"
    let (output, _ ) = execCmdEx(fmt"nim c -r --stdout:off --hints:off -w:off tests/setup_6_spaces.nim {providedOpts}")

  test """ "--optional1 2 1" = "1 2" """:
    check output.strip() == expectedValue