# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.0] - 2026-07-16

### Added

- Documentation on how to use veraPDF for PDF validation (#11).
- The `nohyperref` option for disabling hyperlinks (#10).
- The `bibstyle` keyword option for choosing the bibliography style (#9).
- A `.latexmkrc` file (#8).
- Continuous integration testing for UA-2 and WCAG 2.2 via veraPDF (#8).

### Changed

- `biblatex` is loaded with the class, and the default style is `phys`.
  Use the `bibstyle` keyword option to choose the style and
  `\ExecuteBibliographyOptions` to change other options (#9).
- LaTeX sans-serif font is used by default instead of Arial; enable other fonts
  with `fontsetup` (#8).
- The main document is called `main.tex` instead of `thesis.tex` (#8).

### Fixed

- Committee members are centered even when spanning multiple lines (#12).
- Hyperlinks are colored blue with 3:1 visual contrast to black and 6.9:1 visual
  contrast to white (#10).
- Table of contents, list of tables, and list of figures are included in the
  table of contents (#3).
- Single-space text within a bibliography entry (#9).

## [1.0.0] - 2026-06-03

### Added

- Initial release of `authesis.cls` with example.

[1.1.0]: https://github.com/mphowardlab/authesis/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/mphowardlab/authesis/releases/tag/v1.0.0
