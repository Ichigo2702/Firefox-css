# about:config Guide

Recommended `about:config` tweaks for the best experience with this theme.

## Required Settings

| Setting | Default | Recommended | Why | Side Effects |
|---|---|---|---|---|
| `toolkit.legacyUserProfileCustomizations.stylesheets` | `false` | `true` | Enables `userChrome.css` and `userContent.css` loading | None |

## Mica / Acrylic Transparency (Windows 11)

| Setting | Default | Recommended | Why | Side Effects |
|---|---|---|---|---|
| `widget.windows.mica` | `false` | `true` | Enables Mica material on the title bar | Minor GPU usage |
| `widget.windows.mica.toplevel-backdrop` | `0` | `2` | Enables Acrylic blur on the window frame. `1`=Mica, `2`=Acrylic | Slightly higher GPU usage than Mica |
| `widget.windows.mica.popups` | `0` | `2` | Enables Acrylic blur on popup panels and menus. `1`=Mica, `2`=Acrylic | Popup rendering may be slightly slower |
| `browser.tabs.allow_transparent_browser` | `false` | `true` | Allows transparent backgrounds on browser areas | None |

## UI Density & Layout

| Setting | Default | Recommended | Why | Side Effects |
|---|---|---|---|---|
| `browser.compactmode.show` | `false` | `true` | Shows "Compact" option in Customize → Density | None |
| `browser.uidensity` | `0` | `0` (normal) or `1` (compact) | Sets UI density. Our CSS handles compactness via variables instead | May conflict with our `--uc-tab-height` if set to compact |

## Context Menu Cleanup (Optional)

| Setting | Default | Recommended | Why | Side Effects |
|---|---|---|---|---|
| `privacy.query_stripping.strip_on_share.enabled` | `true` | `false` | Removes "Copy Clean Link" from context menu (already hidden by CSS) | Disables the actual feature too |
| `browser.search.visualSearch.featureGate` | `true` | `false` | Removes "Search Image with Google Lens" from context menu | Disables visual search entirely |

## Tab Behavior

| Setting | Default | Recommended | Why | Side Effects |
|---|---|---|---|---|
| `browser.tabs.tabmanager.enabled` | `true` | `true` | Enables the "List all tabs" dropdown button | None |
| `browser.tabs.hoverPreview.enabled` | `true` | `true` | Shows tab preview on hover (styled by our theme) | Minor memory usage |
| `browser.tabs.hoverPreview.showThumbnails` | `true` | `true` | Shows page thumbnails in tab preview | More memory for thumbnails |

## Performance

| Setting | Default | Recommended | Why | Side Effects |
|---|---|---|---|---|
| `gfx.webrender.all` | `true` | `true` | Hardware-accelerated rendering (needed for blur/animations) | May cause issues on very old GPUs |
| `layers.acceleration.force-enabled` | `false` | `true` | Forces GPU acceleration for smoother animations | May cause issues on some systems |

## Privacy (Optional)

| Setting | Default | Recommended | Why | Side Effects |
|---|---|---|---|---|
| `browser.tabs.firefox-view` | `true` | `false` | Hides Firefox View button (saves toolbar space) | Removes Firefox View feature |
| `extensions.pocket.enabled` | `true` | `false` | Removes Pocket from toolbar and context menus | Disables Pocket entirely |

## Theme

| Setting | Default | Recommended | Why | Side Effects |
|---|---|---|---|---|
| Use System theme | - | **Yes** | System theme works best with Mica/Acrylic transparency | Custom themes may override colors |

To set: Go to `about:addons` → Themes → Enable "System theme — auto"
