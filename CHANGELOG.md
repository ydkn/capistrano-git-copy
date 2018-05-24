# Change Log

## 1.5.0 (2018-05-24)
### Feature
  - add option to switch off running git clean (#25)
### Changes
  - updated _git-archive-all_ to 1.17.1
  - add support for .gitattributes and export-ignore (#23)

## 1.4.0 (2017-05-31)
### Feature
  - deploy subdirectory

## 1.3.2 (2017-04-30)
### Changes
  - updated _git-archive-all_ to 1.16.4

## 1.3.1 (2017-03-18)
### Fixed
  - missing require of tmpdir (see #22)

## 1.3.0 (2016-12-11)
### Changes
  - capistrano 3.7.x compatibility - see updated README.md

## 1.2.1 (2016-12-11)
### Changes
  - updated _git-archive-all_ to HEAD
  - require _capistrano_ < 3.7.0 due to breaking changes

## 1.2.0 (2016-01-25)
### Changes
  - Check if local repository mirror is working and reinitialize if necessary
  - Added config option `git_excludes` to exclude files and directories
  - updated _git-archive-all_ to v1.13

## 1.1.0 (2015-08-10)
### Changes
  - Deprecated: require 'capistrano/git/copy'
  - Allow to skip submodules (uses _git archive_ instead of _git-archive-all_)
### Fixed
  - updated _git-archive-all_ to v1.11
  - prevent tasks from being executed multiple times

## 1.0.2 (2015-05-26)
### Fixed
  - use commit hash to fetch revision for log

## 1.0.1 (2015-05-20)
### Fixed
  - fixed usage of frozen string as branch (e.g. if using ENV values)
  - use working copy of cloned repository to fetch revision

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
