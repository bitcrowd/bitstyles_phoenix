# Changelog

## v2.5.1 - 2025-08-11

- Changed `ui_tabs` and `ui_tab_button` to follow accessibility guidelines: replaced the `<ul>` with a `<div role="tablist">` and instead of nesting the buttons inside `<li>`s they are now the direct children of the `div` and have a `role="tab"` set. As a side effect the gap between the tabs is now a little smaller.
- Fix compiler warnings for elixir 17+ and upgrade dependencies.

## v2.5.0 - 2024-09-25

- Switched bitstyles version comparisons from string comparisons to tuple comparisons, which will ensure correct output if bitstyles version ever contains a number above 9.
- Modified the process of downgrading classnames to the target bitstyles version by chaining renames. This is necessary preparation work to support bitstyles `v6.0.0`.
- Added support for bitstyles `v6.0.0`. You can continue using bitstyles_phoenix with a lower bitstyles version, or migrate your codebase to bitstyles `v6.0.0`.

### How to migrate to bitstyles `v6.0.0`

Follow the [bitstyles changelog](https://github.com/bitcrowd/bitstyles/blob/main/CHANGELOG.md#600---2023-06-08) for version 6.0.0.

There are no changes to bitstyles_phoenix component APIs.

## v2.4.0 - 2024-07-18

- Added support for phoenix_html `v4`. You can also continue using phoenix_html `v3`. To replace `Phoenix.HTML.Form` input helpers removed in phoenix_html `v4`, new components `ui_raw_input` and `ui_raw_label` were added.
- Added support for bitstyles `v5.0.0`. You can continue using bitstyles_phoenix with a lower bitstyles version, or migrate your codebase to bitstyles `v5.0.0`.

### How to migrate to bitstyles `v5.0.0`

Follow the [bitstyles changelog](https://github.com/bitcrowd/bitstyles/blob/main/CHANGELOG.md#500---2023-01-03) for versions 5.0.0 and 5.0.0-alpha-1. Even if you're using the `BitstylesPhoenix.Helper.Classnames.classnames/1` helper to apply bitstyles classes in your own codebase, you will still need to migrate some of them yourself. For example, the class `u-gap-m` could not have been migrated via the helper because it exists in both bitstyles versions with different meanings (`u-gap-m` and `u-gap-l` in bitstyles 4.3.0 are equivalent to `u-gap-l` and `u-gap-xl` in bitstyles `v5.0.0`).

The `variant` attribute of the `Button` component is deprecated in bitstyles `v5.0.0`. Use the attributes `shape` and `color` instead.

## v2.3.1 - 2023-10-23

- Bump LiveView.

## v2.3.0 - 2023-05-15

- Add `Modal` component.

## v2.2.0 - 2023-03-20

- Updated to LiveView 0.18.18.
- Add `Card` and `Avatar` components.

## v2.1.1 - 2022-12-02

- Fixed version backwards compatibility.

## v2.1.0 - 2022-12-02

### Changed

- Add `heading_class` option to `ui_section_title` to set classes on the heading
- `ui_dl_items` now aligns the items to the baseline (following the Bitstyles examples)
- Updated to bitstyles `v4.3.0`.

### Added

- Inputs now render a required label *. This can be configured via `required_label` config. If you do not want this new behaviour, define an empty component as required label.

### Breaking

- When `ui_button` is disabled it always renders a button now instead of a link with a disabled property. In most cases this should be fine, but it could break e2e tests that check for links or similar things.

## v2.0.0 - 2022-11-12

Since there is quite some changes in liveview 0.18.0 mainly about link helpers this breaks with the existing API for the `ui_button` and
`ui_icon_button` components quite a lot. Since the underlying phoenix helper for generating links is now available as component as well,
the support for the `ui_button` as helper is dropped completely in favor of components.

### Breaking

- Updated to LiveView 0.18.X
- Removed BitstylesPhoenix.Helpers.Button
  - Removed `ui_button/2` helper
    -> Use the `ui_button` component
  - Removed `ui_icon_button/3` helper
    -> Use the `ui_icon_button` component
- `ui_button` component now acts as a wrapper for Phoenix.Component.link
  - Removed `link_fn` on `ui_button` component, since it's main use-case is now deprecated.

### How to update:

- Upgrade to LiveView > 0.18
`<%= ui_button("some label", to: some_path) %>` => `<.ui_button href={some_path}>some label</.ui_button>`
`<.ui_button to={some_path} %>some label</.ui_button>` => `<.ui_button href={some_path}>some label</.ui_button>`
`<.ui_button to={some_path} link_fn={&live_redirect/2}%>some label</.ui_button>` => `<.ui_button navigate={some_path}>some label</.ui_button>`
`<.ui_button to={some_path} link_fn={&live_patch/2}%>some label</.ui_button>` => `<.ui_button patch={some_path}>some label</.ui_button>`
`<%= ui_icon_button("some label", to: some_path) %>` => `<.ui_icon_button href={some_path}>some label</.ui_button>`
...

## v1.0.0 - 2022-01-04

This version breaks with the existing API quite a lot 🔥, since we changed the library to take advantage of the recent developments in Phoenix and LiveView.

### Breaking

All `ui_*` component helpers are now instead [HEEx function components](https://hexdocs.pm/phoenix/views.html#html-components). They will expect the options and arguments
now through component attributes. The only exception is `ui_button`, which still delegate to the link_helper given via `link_fn`, but is also available as component.
In order to migrate to the new components update to Phoenix 1.6.0 and LiveView 1.17.0 and change all templates from
`*.html.eex` to `*.html.heex` to be able to use the new component syntax. After that you can change your previous `ui_*` helpers to use the new syntax:

`<%= ui_badge("foo", variant: "warning") %>` => `<.ui_badge variant: "warning">foo</.ui_badge>`

If you have contexts, where you do not want to use `heex` templates yet, you can call the functions via `Phoenix.LiveView.Helpers.component/2`.

Below is a list of changes that happened besides the componentization:

- Renamed `ui_error_tag` to `ui_error`
- `ui_input` dropped `datetime` input type (was not working anyways)
- `ui_input` dropped `radio` input type (use `ui_unwrapped_input` with `radio_button` instead)
- `ui_input` dropped `textarea` input type (use `ui_textarea` instead)
- Removed `ui_time/2` without replacement for now
- Removed `xclassnames/1`. Use `classnames/1` from the same module instead.
- `classnames/1` now returns `false` instead of empty string when there is no class set.
- Removed `BitstylesPhoenix.Components` module. Instead of `use BitstylesPhoenix.Components` do `use BitstylesPhoenix`.
- Removed all `e2e_classname` options. Use `class` instead, which will trim the e2e classes by default (like before).
- Changed `trim_e2e_classes` config. In order to migrate change the following
  ```
  config :bitstyles_phoenix, :trim_e2e_classes, false
  ```
  =>
  ```
  config :bitstyles_phoenix, :trim_e2e_classes, [enabled: false]
  ```

### Added

- All components now accept extra attributes that are passed on to the outermost parent attribute.
- Config option to configure `classnames/1` prefixes to remove other prefixes than `e2e-` instead (e.g. `test-`).
- Backwards compatibility option for different versions of `bitstyles` (see `bitstyles_version` config option)
- The `BitstylesPhoenix.Icon` components `file` attribute can now get a default value via `icon_file` application config.
- `ui_dropdown` and `ui_js_dropdown` (Live/Alpine3) components
- `BitstylesPhoenix.Live` and `BitstylesPhoenix.Alpine3` for quick imports of the live and alpine3 components
- Integration tests and example configuration with the `demo` app
- Added `ui_icon_button/2` & `ui_icon_button/3` as helpers.
- Added various new components: `Button`, `Tabs`, `Breadcrumbs`, `Sidebar`, `Dropdown`, `Content` ...
- Added `icon` option to `ui_button`.
- Added support for `:datetime` type in `ui_input`, rendered as Browser-native datetime input element

### Changed

- Added dependency to `phoenix_live_view` >= 1.17.0 (for using `sigil_H/1` and new component syntax)
- Doctest now use `floki` to prettify the output HTML, so docs will be a nicer read.
- `classnames/1` is now imported by default with `use BitstylesPhoenix`
- Updated to bitstyles `v3.0.0`
- `ui_errors` now uses larger padding

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
