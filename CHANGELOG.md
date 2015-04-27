# Change Log

## Unreleased
### Fixed
  - fixed usage of frozen string as branch (e.g. if using ENV values)

## 1.0.0 (2015-04-22)
### Fixed
  - support application names with whitespaces and other non-path-friendly characters
  - executing deploy/scm task twice

## 0.8.1 (2015-04-11)
### Fixed
  - strip branch name only if it is a string

## 0.8.0 (2015-04-07)
### Changes
  - changed namespace from Capistrano::Git::Copy to Capistrano::GitCopy to avoid problems when using it in conjunction with build-in git support from capistrano
  - strip whitespaces from branch for checking revision
