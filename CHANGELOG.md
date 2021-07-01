# Changelog

## Unreleased

## v0.5.0

### Added
* Better documentation for form helpers

### Changes
* Multiple errors on ones field are now rendered as a list 

### Breaking/Bugfix
* Do not forward options from form helpers to each `label` anymore, but instead pass options through `label_opts`.
* Drop `hidden` and `reset` input types for `ui_input`.

### Deprecations
* deprecated `ui_error/2` in favour of the new `ui_errors/2`

## v0.4.0

### Added 
* `BitstylesPhoenix.UseSVG.ui_svg/2` to display inline svg references with `<use>` tags and support for external SVGs.
* Make `BitstylesPhoenix.Icon.ui_icon/2` use `ui_svg` internally to support the `external` option.

### Fixes
* Fix icons in docs for `BitstylesPhoenix.Icon.ui_icon/2`.

## v0.3.0

### Changes
* Examples and showcases are now inlined and doctested, to assure they won't break and to be more scalable for more components.
* Restructured top level module doc

### Added

* Badge component
* Flash component
* New option to specify pixel width & height for SVG icons
* Added a CHANGELOG.md, this file

### Breaking

* Moved components from `BitstylesPhoenix.Components.*` to `BitstylesPhoenix.*`. Not actionable if you use `use BitstylesPhoenix.Components`
