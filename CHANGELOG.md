# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

[Unreleased]: https://github.com/envato/unwrappr/compare/v0.4.0...HEAD

## [0.4.0] 2020-04-14
### Changed
- `bundler-audit` limited to `>= 0.6.0` ([#71])

### Removed
- Support for Ruby 2.3 and 2.4 ([#73])

### Added
- Rake vulnerability CVE-2020-8130 fixes ([#72])
- Support for Ruby 2.6 and 2.7 ([#73])
- Support for version numbers including a fourth segment (_e.g._ "6.0.2.2") ([#74])
- Support for GitHub URIs including anchors ([#75])

[0.4.0]: https://github.com/envato/unwrappr/compare/v0.3.5..v0.4.0
[#71]: https://github.com/envato/unwrappr/pull/71
[#72]: https://github.com/envato/unwrappr/pull/72
[#73]: https://github.com/envato/unwrappr/pull/73
[#74]: https://github.com/envato/unwrappr/pull/74
[#75]: https://github.com/envato/unwrappr/pull/75

## [0.3.5] 2019-11-28
### Changed
- ISO 8601 Date and time format for branch name ([#68])
### Fixed
- Changelog and source links in PR annotation are specific to the version
  used in the project, not just the latest available on Rubygems.org ([#69]).

[0.3.5]: https://github.com/envato/unwrappr/compare/v0.3.4...v0.3.5
[#68]: https://github.com/envato/unwrappr/pull/68
[#69]: https://github.com/envato/unwrappr/pull/69

## [0.3.4] 2019-10-24
### Fixed
- Fix failure to annotate gem change with '.' in its name ([#65]).

[0.3.4]: https://github.com/envato/unwrappr/compare/v0.3.3...v0.3.4
[#65]: https://github.com/envato/unwrappr/pull/65

## [0.3.3] 2019-06-07
### Fixed
- Fix issue where gem install will now work on RubyGems v3 ([#61]).

[0.3.3]: https://github.com/envato/unwrappr/compare/v0.3.2...v0.3.3
[#61]: https://github.com/envato/unwrappr/pull/61

## [0.3.2] 2018-11-13
### Added
 - Specify Ruby and RubyGems requirements in gemspec ([#56]).
 - Clone one git repository or more and create an annotated bundle update PR for each ([#52]).

[0.3.2]: https://github.com/envato/unwrappr/compare/v0.3.1...v0.3.2
[#56]: https://github.com/envato/unwrappr/pull/56
[#52]: https://github.com/envato/unwrappr/pull/52

## [0.3.1] 2018-11-12
### Changed
 - Travis CI enabled ([#55]).
 - Ensure we are protected against CVE-2017-8418 ([#54]).
 - RubyGems metadata includes a description ([#49]).

[0.3.1]: https://github.com/envato/unwrappr/compare/v0.3.0...v0.3.1
[#55]: https://github.com/envato/unwrappr/pull/55
[#54]: https://github.com/envato/unwrappr/pull/54
[#49]: https://github.com/envato/unwrappr/pull/49

## [0.3.0] 2018-11-12
### Initial Release

[0.3.0]: https://github.com/envato/unwrappr/releases/tag/v0.3.0
