# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## Unreleased

Breaking Changes

- None

Added

- None

Fixed

- None

## 0.5.0 (2018-05-08)

Breaking Changes

- None

Added

- Support for PaperTrail 9
- PaperTrail::Sinatra.gem_version

Fixed

- None

## 0.4.0 (2018-02-22)

Breaking Changes

- Drop support for activesupport < 4.2 (EoL)
- Drop support for ruby < 2.2 (EoL, and required by sinatra 2)

Added

- [#5](https://github.com/jaredbeck/paper_trail-sinatra/pull/5) -
  Two methods familiar to rails users
  - info_for_paper_trail
  - paper_trail_enabled_for_request

Fixed

- None

## 0.3.0 (2017-12-10)

Breaking Changes

- None

Added

- Update dependency constraints
  - paper_trail >= 7, < 9
  - sinatra >= 1.0.0, < 3

Fixed

- None

## 0.2.0 (2017-05-25)

Breaking Changes

- None

Added

- Support sinatra 2, activerecord 5

Fixed

- None

## 0.1.0 (2017-03-20)

Initial release
