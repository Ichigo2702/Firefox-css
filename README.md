# Firefox 152+ — Polished UI Redesign

A modular, lightweight CSS customization system that makes Firefox look and feel significantly more polished and modern while maintaining its identity and blazing-fast performance.

## Folder Structure

```text
Firefox-css/
├── install.sh                  <- Automated zero-config installer
├── userChrome.css              <- Main browser chrome entry (imports only)
├── userContent.css             <- Content styles entry (about: pages, websites)
├── docs/                       <- Documentation & guides
└── modules/
    ├── 01-variables.css        <- All design tokens, animations & accessibility
    ├── 02-toolbar.css          <- Toolbar, compact mode, buttons
    ├── 03-tabs-urlbar.css      <- Tabs, audio pulse, containers, URL bar
    ├── 04-bookmarks-sidebar.css <- Bookmarks, native vertical tabs & sidebar
    ├── 05-menus.css            <- Panels, popups, downloads, tooltips, findbar
    ├── 06-contextmenu.css      <- Context menu cleanup & styling
    ├── 07-internal-pages.css   <- about: pages + PDF viewer
    ├── 08-websites.css         <- ChatGPT, GitHub, Reddit, Gmail
    ├── 09-extras.css           <- Fullscreen, scrollbars, PiP, Ctrl+Tab
    └── 10-foxone-features.css  <- Dynamic hover-reveal icons, floating find bar
```

## Features

### UI & Layout
- **Automated Installer**: 1-click zero-config `install.sh` script for Linux and macOS.
- **Cross-Platform Hardened**: Native styling on Linux (Wayland/X11) and Windows 11 with zero square window border artifacts on popups.
- **Compact & Ultra-Compact Modes**: Single-variable switch (32px or 28px).
- **Smooth Bookmarks Reveal**: Auto-hides bookmarks toolbar and slides down gracefully on hover.
- **Firefox 130+ Native Vertical Tabs**: Full styling for the revamped sidebar and native vertical tabs.
- **Modern Container Tabs**: Clean centered bottom pill indicators replacing harsh full-width top lines.
- **Spotlight Search Focus**: Inactive tabs subtly dim when the URL bar is focused.
- **Floating Find Bar**: Compact, elevated top-right find bar with rounded input and match count badges.
- **Acrylic & Rounded Menus**: 10px rounded menus with GPU-blended semi-transparency.
- **Clean Context Menus**: Clutter-free right-click menus with refined hover highlights.

### Animations & Performance (Near-Zero CPU/RAM)
- **100% GPU Composited**: Only `transform` and `opacity` are animated to eliminate layout reflows and stutter.
- **Condition-Gated Animations**: Animations run only when active (e.g. audio pulse only runs while sound is actively playing).
- **No Unaccelerated Blur**: Avoids heavy full-screen filters, ensuring 60+ FPS on Wayland and X11 compositors.
- **Tab Audio Equalizer**: Animated 3-bar pulse on `.tab-icon-overlay[soundplaying]`.
- **Linear Tab Loading Sweep**: Sleek gradient progress sweep on loading tabs.
- **Accessibility & Reduced Motion**: Automatically disables all animations when `prefers-reduced-motion: reduce` is detected.

### Internal Pages & Websites
- **about:config**: Rounded search box, cleaner table layout.
- **about:preferences**: Refined category sidebar and inputs.
- **about:support**: Cleaner tables and copy buttons.
- **about:downloads**: Rounded download cards and modern progress bars.
- **PDF Viewer**: Rounded toolbar action buttons.
- **Websites**: Dark mode and layout refinements for ChatGPT, GitHub, Reddit, and Gmail.

---

## Installation & Setup

### Method 1: Automated 1-Click Install (Recommended for Linux/macOS)

Open a terminal in this repository and run:
```bash
./install.sh
```
The script automatically:
1. Detects your active Firefox profile directory.
2. Creates the `chrome` symlink pointing to this repository.
3. Automatically enables `toolkit.legacyUserProfileCustomizations.stylesheets` in `user.js`.
4. Backs up any existing `chrome` folder.

Once complete, simply restart Firefox!

---

### Method 2: Manual Installation

#### Step 1: Locate your Firefox Profile Folder
1. Open Firefox.
2. In the address bar, type `about:support` and press **Enter**.
3. Under **Application Basics**, find **Profile Folder** (or **Profile Directory**) and click **Open Folder** / **Open Directory**.

#### Step 2: Place the Files
1. Inside your profile directory, create a folder named `chrome` (in lowercase) if it doesn't exist.
2. Symlink or copy `userChrome.css`, `userContent.css`, and the `modules/` folder directly into that `chrome/` directory.

#### Step 3: Enable Custom Stylesheets in Firefox
1. In Firefox, open **`about:config`**.
2. Click **Accept the Risk and Continue**.
3. Search for:
   ```text
   toolkit.legacyUserProfileCustomizations.stylesheets
   ```
4. Set it to **`true`**.

#### Step 4: Restart Firefox
Close all Firefox windows and relaunch Firefox.

---

## How to Customize

Open [`modules/01-variables.css`](file:///home/pvg/Documents/Projects/Firefox-css/modules/01-variables.css) to adjust any design tokens:

```css
:root {
  --uc-tab-height: 28px;        /* Ultra compact */
  --uc-animation-multiplier: 0; /* Turn off all animations */
  --uc-accent-color: #0078d4;   /* Custom accent color */
}
```

To enable or disable individual modules, open [`userChrome.css`](file:///home/pvg/Documents/Projects/Firefox-css/userChrome.css) or [`userContent.css`](file:///home/pvg/Documents/Projects/Firefox-css/userContent.css) and toggle the `@import` comments:

```css
/* Enable Toolbar customizations */
@import url("modules/02-toolbar.css");

/* Disable context menu styling */
/* @import url("modules/06-contextmenu.css"); */
```

---

## Troubleshooting

| Problem | Solution |
|---|---|
| No changes visible | Ensure `toolkit.legacyUserProfileCustomizations.stylesheets` is `true` in `about:config` (or run `./install.sh`), then restart Firefox |
| Bookmarks bar not showing on hover | Right-click the toolbar and set **Bookmarks Toolbar -> Always Show** (Module 04 will handle auto-hiding) |
| Square shadow behind popups | Use the updated `04-bookmarks-sidebar.css` and `06-contextmenu.css` which separate `menupopup` from `.menupopup-arrowscrollbox` |
| Animations feel slow or disabled | Check system reduced-motion settings or adjust `--uc-animation-multiplier` in `01-variables.css` |
| Context menu items still showing | Clear Firefox startup cache: **Help** -> **More Troubleshooting** -> **Clear Startup Cache** |

---

## Compatibility

| Version | Status |
|---|---|
| Firefox 130 – 156+ (current) | Fully tested (includes native vertical tabs and sidebar revamp) |
| Linux (GNOME / KDE / Wayland / X11) | Fully tested and hardened |
| Windows 11 / 10 | Fully supported |
| macOS | Supported |
