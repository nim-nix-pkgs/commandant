# Change Log
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/), but
because it is pre 1.0.0, it has a *lot* of leeway :).

## [0.15.0] - 2021-08-14

### Changed
- renamed program from `commandeer` to `commandant` to distinguish the fork
- removed the old test suite and replaced it
  - no longer uses a .json file
  - uses the standard library `unittest` module
- reworked the `readme.md`, to provide more clear examples.

### Added 
- example directory with two examples: a trivial case and a more intermediate implementation


## [0.14.0] - 2021-08-14
### Added
- `flag` argument type, which is just a simplified `option` where the user only needs to provide a variable and name(s)

## [0.13.0] - 2021-08-12
### Changed 
- Removed the `parseopt2` import, replacing it with `parseopt`
  - Used find and replace and changed any mentions of `parseopt2` to `parseopt`
  - Added the `getoptResult` type definition to `commandeer.nim`
  - These steps removed all errors, and the program ran as expected, so far...
- Moved `runTests.nim` into `tests` folder. Updated the `commandeer.nimble` file
- Updated README to project planned improvements

### Removed
- Removed circleci, to simplify the library

## [0.11.0] - 2017-03-04
### Changed
- Complete rewrite but it should be completely backwards compatible
- Error message when failed conversion is clearer
### Added
- The space option syntax is now possible: `--option value`
