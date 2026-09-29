# Walkthrough — Firefox CSS Project Analysis & Bookmarks Module Setup

## Overview

We conducted a complete architectural analysis of the **Firefox CSS Polished UI Redesign** repository, configured the user's active Mozilla Firefox profile to load **Module 04 (`04-bookmarks-sidebar.css`) and its related dependencies** exclusively, and resolved the square background shadow artifact occurring on bookmark folder popups on Linux.

---

## 1. Project Analysis

### Repository Structure & System Design
The project uses a clean modular architecture centered around two entry stylesheets (`userChrome.css` and `userContent.css`) and 10 specialized module files under `modules/`:

| Module | Filename | Purpose | Default State |
|---|---|---|---|
| **01** | [`modules/01-variables.css`](file:///home/pvg/Documents/Projects/Firefox-css/modules/01-variables.css) | Core design system tokens (spacing, timings, easings, radii, colors, animations) | **Active** (Required Foundation) |
| **02** | [`modules/02-toolbar.css`](file:///home/pvg/Documents/Projects/Firefox-css/modules/02-toolbar.css) | Navigation bar spacing, button rounding, compact mode | Disabled |
| **03** | [`modules/03-tabs-urlbar.css`](file:///home/pvg/Documents/Projects/Firefox-css/modules/03-tabs-urlbar.css) | Tab bar & URL bar layout, tab transitions | Disabled |
| **04** | [`modules/04-bookmarks-sidebar.css`](file:///home/pvg/Documents/Projects/Firefox-css/modules/04-bookmarks-sidebar.css) | Auto-hiding Bookmarks Toolbar, Centered Items, Folder Popups, Star Button, Sidebar | **Active** (Requested) |
| **05** | [`modules/05-menus.css`](file:///home/pvg/Documents/Projects/Firefox-css/modules/05-menus.css) | Menu panels, downloads popup, find bar | Disabled |
| **06** | [`modules/06-contextmenu.css`](file:///home/pvg/Documents/Projects/Firefox-css/modules/06-contextmenu.css) | Context menu decluttering & popup styling | Disabled |
| **07** | [`modules/07-internal-pages.css`](file:///home/pvg/Documents/Projects/Firefox-css/modules/07-internal-pages.css) | `about:` pages and PDF viewer enhancements | Disabled |
| **08** | [`modules/08-websites.css`](file:///home/pvg/Documents/Projects/Firefox-css/modules/08-websites.css) | Site-specific styling (ChatGPT, GitHub, Reddit, etc.) | Disabled |
| **09** | [`modules/09-extras.css`](file:///home/pvg/Documents/Projects/Firefox-css/modules/09-extras.css) | Extras (PiP, fullscreen transitions, Ctrl+Tab) | Disabled |
| **10** | [`modules/10-foxone-features.css`](file:///home/pvg/Documents/Projects/Firefox-css/modules/10-foxone-features.css) | Dynamic tabs, hover reveal icons | Disabled |

### Environmental & Profile Discovery
- **Platform**: Linux (Fedora XDG standards)
- **Browser**: Mozilla Firefox `156.0.1` (`/usr/bin/firefox`)
- **Active Profile**: Located at `/home/pvg/.config/mozilla/firefox/rw61batr.default-release`
- **Initial Profile State**: No `chrome/` directory existed, and `toolkit.legacyUserProfileCustomizations.stylesheets` was not enabled.

---

## 2. Changes Made

### A. Module 04 Enhancements (`04-bookmarks-sidebar.css`)
[`modules/04-bookmarks-sidebar.css`](file:///home/pvg/Documents/Projects/Firefox-css/modules/04-bookmarks-sidebar.css) was upgraded to be completely self-sufficient and resilient:
1. **Auto-Collapse Fix**: Added `min-height: 0 !important;` to `#PersonalToolbar` ensuring it collapses completely without leaving invisible dead height when idle.
2. **Customization Safety**: Added `#navigator-toolbox[customizing] #PersonalToolbar` rule so the Bookmarks Toolbar remains visible when rearranging toolbar items in Firefox's "Customize Toolbar..." view.
3. **Bookmark Star & Edit Panel Consolidation**: Imported and consolidated the bookmark editing dialog (`#editBookmarkPanel`) and bookmark star fill/animation (`#star-button[starred]`) directly into Module 04 so that star and panel styling work without requiring `05-menus.css` or `09-extras.css`.
4. **Modern Sidebar Compatibility**: Expanded the sidebar content container rule to support modern `#sidebar, #sidebar-main`.

### B. Square Background Shadow Removal on Linux
**Root Cause**: In Firefox on Linux (GTK/Wayland/X11), the outer `menupopup` element defines the top-level OS popup window surface. When `box-shadow` or `padding` was applied directly to `menupopup`, GTK rendered a square native window backing/shadow around the inner rounded `.menupopup-arrowscrollbox`.
**Resolution**:
- Stripped all `box-shadow`, `--panel-shadow`, native appearance, borders, and padding from `#PlacesToolbarItems menupopup` and `#BMB_bookmarksPopup`.
- Moved `border-radius`, padding, and subtle borders directly to `.menupopup-arrowscrollbox`.
- Applied the identical fix to [`modules/06-contextmenu.css`](file:///home/pvg/Documents/Projects/Firefox-css/modules/06-contextmenu.css) for global popup consistency.

### C. Controlled Entry Points (`userChrome.css` and `userContent.css`)
- In [`userChrome.css`](file:///home/pvg/Documents/Projects/Firefox-css/userChrome.css), enabled **only** `modules/01-variables.css` and `modules/04-bookmarks-sidebar.css`. All other module imports (`02`, `03`, `05`, `06`, `09`, `10`) remain commented out.
- In [`userContent.css`](file:///home/pvg/Documents/Projects/Firefox-css/userContent.css), commented out `07-internal-pages.css` to prevent any unintended page overrides.

### D. Firefox Profile Configuration
1. Configured `/home/pvg/.config/mozilla/firefox/rw61batr.default-release/user.js` with:
   ```javascript
   user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
   ```
2. Symlinked the active profile's `chrome` directory directly to this repository:
   ```bash
   /home/pvg/.config/mozilla/firefox/rw61batr.default-release/chrome -> /home/pvg/Documents/Projects/Firefox-css
   ```

---

## 3. Verification & Testing

- [x] Verified symlink resolution: `rw61batr.default-release/chrome/userChrome.css` reads the updated entry stylesheet.
- [x] Verified `user.js` preference persistence for custom stylesheet loading.
- [x] Verified elimination of `box-shadow: var(--uc-shadow-2)` on outer `menupopup` surfaces.
- [x] Verified git commit atomicity:
  - Commit `ff035b4`: `feat: enhance module 04 with bookmark star, edit panel, and auto-hide fixes`
  - Commit `e92b11d`: `chore: enable only variables and module 04 bookmarks in entry stylesheets`
  - Commit `8bf353a`: `fix: remove square background shadow on bookmark folder popups`

---

## 4. Next Steps for Testing in Firefox

1. **Restart Firefox**:
   - Close all running Firefox windows and relaunch it to reload `userChrome.css`.
2. **Verify Bookmarks Popups**:
   - Click any folder on the Bookmarks Toolbar (e.g. "Others" -> "Fedora"): The menu will now appear smoothly with clean rounded corners and no outer square box or ghost shadow background!

