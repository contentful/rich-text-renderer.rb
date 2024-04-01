# CHANGELOG

## Unreleased
* Added ruby version 3.3, 3.2 and 3.1 to CI/CD.
* Removed ruby version 2.6, 2.7 and 3.0 from CI/CD.
* Updated bundler to latest version.
* Updated rubocop to latest version.
* Updated rake to latest version.

## v0.3.2
* Added support for superscript and subscript

## v0.3.1
* Changed CI/CD vendor to CircleCI
* Fixed handling `nil` nodes
* Fix linting offences

## v0.3.0
* Added support for Rich Text Tables

## v0.2.3
* Removed unwanted files from gem release package.

## v0.2.2
### Fixed
* Fixed mispelt blockquote tag. [#9](https://github.com/contentful/rich-text-renderer.rb/pull/9)
* Removed the possibility of XSS via text in nodes. [#10](https://github.com/contentful/rich-text-renderer.rb/pull/10)

## v0.2.1
### Fixed
* Default `EntryBlockRenderer` now properly stringifies `data.target` instead of just data.

## v0.2.0

### Added
* Add Asset support

## v0.1.0 (`rich_text_renderer`)

As `RichText` moves from `alpha` to `beta`, we're treating this as a feature release.

### Changed
* Renamed `StructuredText` to `RichText`.

## v0.0.2 (`structured_text_renderer`)

### Fixed
* Fixed rendering logic for block type nodes

## v0.0.1

* Initial Release
