# Walkthrough — Firefox CSS Project Analysis & Bookmarks Module Setup

## Overview

We conducted a complete architectural analysis of the **Firefox CSS Polished UI Redesign** repository and configured the user's active Mozilla Firefox profile to load **Module 04 (`04-bookmarks-sidebar.css`) and its related dependencies** exclusively, while keeping all other modules disabled for isolated verification and incremental adoption.

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
| **06** | [`modules/06-contextmenu.css`](file:///home/pvg/Documents/Projects/Firefox-css/modules/06-contextmenu.css) | Context menu decluttering | Disabled |
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

### B. Controlled Entry Points (`userChrome.css` and `userContent.css`)
- In [`userChrome.css`](file:///home/pvg/Documents/Projects/Firefox-css/userChrome.css), enabled **only** `modules/01-variables.css` and `modules/04-bookmarks-sidebar.css`. All other module imports (`02`, `03`, `05`, `06`, `09`, `10`) were explicitly commented out.
- In [`userContent.css`](file:///home/pvg/Documents/Projects/Firefox-css/userContent.css), commented out `07-internal-pages.css` to prevent any unintended page overrides.

### C. Firefox Profile Configuration
1. Created `/home/pvg/.config/mozilla/firefox/rw61batr.default-release/user.js` with:
   ```javascript
   user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
   ```
2. Symlinked the active profile's `chrome` directory directly to this repository:
   ```bash
   /home/pvg/.config/mozilla/firefox/rw61batr.default-release/chrome -> /home/pvg/Documents/Projects/Firefox-css
   ```
   *Benefit*: Any live tweaks or future module activations in the repository are immediately reflected in Firefox without manual copying.

---

## 3. Verification & Testing

- [x] Verified symlink resolution: `rw61batr.default-release/chrome/userChrome.css` reads the updated entry stylesheet.
- [x] Verified `user.js` preference persistence for custom stylesheet loading.
- [x] Verified git commit atomicity:
  - Commit `ff035b4`: `feat: enhance module 04 with bookmark star, edit panel, and auto-hide fixes`
  - Commit `e92b11d`: `chore: enable only variables and module 04 bookmarks in entry stylesheets`

---

## 4. Next Steps for Testing in Firefox

1. **Ensure Bookmarks Toolbar is Visible in Firefox Settings**:
   - Right-click the title/tab bar (or press `Ctrl+Shift+B` or open Menu > More tools > Customize toolbar) and ensure Bookmarks Toolbar is set to **"Always Show"** (Module 04 will automatically hide it and reveal it smoothly when hovering near the top toolbar area).
2. **Restart Firefox**:
   - Close Firefox completely and relaunch it.
3. **Verify the Effects**:
   - Hover your mouse over the top navigation area: The Bookmarks Toolbar slides smoothly into view.
   - Move mouse away: The Bookmarks Toolbar smoothly slides away.
   - Bookmark items: Items are centered with refined rounded pill hover states.
   - Bookmark Star (`Ctrl+D`): Animated star button with accent color and styled edit dialog.
   - Sidebar (`Ctrl+B`): Smooth sliding animation, modern 1px divider, and rounded layout.
