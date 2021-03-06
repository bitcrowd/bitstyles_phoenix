# Changelog

## v0.8.0

### Changed

- Updated `phoenix_html` dependency to `~> 3`. See [its changelog](https://github.com/phoenixframework/phoenix_html/blob/master/CHANGELOG.md) for backwards incompatible changes.

## v0.7.0

- Added `link_fn` option in `ui_button` to support LiveView's `live_patch`/`live_redirect`

## v0.6.0

### Changed

- Updated dependencies

### Breaking

- Update to bitstyles 1.5.0 (Update flash component padding)

## v0.5.1

### Fixed

- Fix `use BitstylesPhoenix.Components` (see https://github.com/bitcrowd/bitstyles_phoenix/pull/34)

## v0.5.0

### Added

- Better documentation for form helpers

### Changes

- Multiple errors on ones field are now rendered as a list

### Breaking/Bugfix

- Do not forward options from form helpers to each `label` anymore, but instead pass options through `label_opts`.
- Drop `hidden` and `reset` input types for `ui_input`.

### Deprecations

- deprecated `ui_error/2` in favour of the new `ui_errors/2`

## v0.4.0

### Added

- `BitstylesPhoenix.UseSVG.ui_svg/2` to display inline svg references with `<use>` tags and support for external SVGs.
- Make `BitstylesPhoenix.Icon.ui_icon/2` use `ui_svg` internally to support the `external` option.

### Fixes

- Fix icons in docs for `BitstylesPhoenix.Icon.ui_icon/2`.

## v0.3.0

### Changes

- Examples and showcases are now inlined and doctested, to assure they won't break and to be more scalable for more components.
- Restructured top level module doc

### Added

- Badge component
- Flash component
- New option to specify pixel width & height for SVG icons
- Added a CHANGELOG.md, this file

### Breaking

- Moved components from `BitstylesPhoenix.Components.*` to `BitstylesPhoenix.*`. Not actionable if you use `use BitstylesPhoenix.Components`
