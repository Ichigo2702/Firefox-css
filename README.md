# Firefox 152 — Polished UI Redesign

A modular CSS customization system that makes Firefox look and feel significantly more polished while maintaining its identity.

## Folder Structure

```
chrome/
├── userChrome.css              ← Main entry (imports only)
├── userContent.css             ← Content styles (imports only)
└── modules/
    ├── 01-variables.css        ← All design tokens + animations
    ├── 02-toolbar.css          ← Toolbar, compact mode, buttons
    ├── 03-tabs-urlbar.css      ← Tabs + URL bar + autocomplete
    ├── 04-bookmarks-sidebar.css ← Bookmarks + sidebar
    ├── 05-menus.css            ← Panels, popups, downloads, tooltips, findbar
    ├── 06-contextmenu.css      ← Context menu cleanup + styling
    ├── 07-internal-pages.css   ← about: pages + PDF viewer
    ├── 08-websites.css         ← ChatGPT, GitHub, Reddit, Gmail
    └── 09-extras.css           ← Fullscreen, scrollbars, PiP, Ctrl+Tab
```

## Features

### UI
- ✅ Compact mode (one variable switch)
- ✅ Very compact mode (28px height)
- ✅ Centered URL bar
- ✅ Floating URL bar (shadow + rounded)
- ✅ Smooth bookmark toolbar animation
- ✅ Rounded tabs (8px radius)
- ✅ Narrower tabs
- ✅ Better active tab (subtle elevation)
- ✅ Better hover effects everywhere
- ✅ Acrylic menus (blur + transparency)
- ✅ Rounded menus (10px radius)
- ✅ Better context menus
- ✅ Better toolbar spacing
- ✅ Better extension popup
- ✅ Better download popup
- ✅ Better bookmark menus
- ✅ Better overflow menu
- ✅ Better identity popup
- ✅ Better permission dialogs
- ✅ Better Ctrl+Tab switcher
- ✅ Better bookmark star animation
- ✅ Better Picture-in-Picture button
- ✅ Better extension badges
- ✅ Better tab preview panel

### Animations
- ✅ Smooth everywhere (150ms/200ms/300ms)
- ✅ Better fullscreen transition
- ✅ Sidebar animation
- ✅ Hover transitions
- ✅ URL bar focus animation
- ✅ Tab close button fade
- ✅ Panel opening animation (scale-in)
- ✅ Find bar slide-up
- ✅ Bookmark toolbar slide-down
- ✅ Download indicator pulse

### Internal Pages
- ✅ about:config (rounded search, better tables)
- ✅ about:preferences (rounded categories, inputs)
- ✅ about:support (better tables, copy buttons)
- ✅ about:downloads (rounded items, progress bars)
- ✅ PDF viewer (rounded toolbar buttons)

### Websites
- ✅ ChatGPT (code blocks, inputs, scrollbars)
- ✅ GitHub (code font, buttons, avatars)
- ✅ Reddit (post cards, inputs, threads)
- ✅ Gmail (compose button, email rows, search)

## Installation

1. **Enable custom CSS:**
   - Type `about:config` in Firefox address bar
   - Accept the risk
   - Search: `toolkit.legacyUserProfileCustomizations.stylesheets`
   - Set to `true`

2. **Enable Mica/Acrylic (optional, Windows 11):**
   - See `about-config-guide.md` for recommended settings

3. **Place files:**
   - Files are already in your profile's `chrome/` folder
   - Restart Firefox completely (close all windows)

## How to Disable Individual Modules

Open `userChrome.css` and comment out any `@import` line:

```css
/* Disable bookmarks & sidebar customizations */
/* @import url("modules/04-bookmarks-sidebar.css"); */
```

## How to Customize

Open `modules/01-variables.css` and change values at the top:

```css
:root {
  --uc-tab-height: 28px;        /* Very compact */
  --uc-radius-urlbar: 16px;     /* More rounded URL bar */
  --uc-animation-multiplier: 0; /* Disable all animations */
}
```

## Update Process

When Firefox updates:
1. Check if the UI still looks correct
2. If something breaks, use Browser Toolbox (Ctrl+Alt+Shift+I) to find changed selectors
3. Update the affected module file
4. Only `userChrome.css` and `userContent.css` need to stay named exactly right — module files can have any name

## Troubleshooting

| Problem | Solution |
|---|---|
| No changes visible | Ensure `toolkit.legacyUserProfileCustomizations.stylesheets` is `true` in `about:config`, then restart Firefox |
| Blur not working | Enable `widget.windows.mica` settings — see `about-config-guide.md` |
| Tabs look wrong after update | Use Browser Toolbox to check if `.tab-background` selector changed |
| Context menu items still showing | Clear Firefox startup cache: Help → More Troubleshooting → Clear Startup Cache |
| Scrollbar too thin/thick | Adjust `--uc-scrollbar-width` in `01-variables.css` |

## Firefox Compatibility

| Version | Status |
|---|---|
| Firefox 152 (current) | ✅ Fully tested |
| Firefox 138–151 | ⚠️ Should work, Mica/Acrylic may differ |
| Firefox < 138 | ❌ No Mica support, some selectors may differ |

## FAQ

**Q: Will this break my extensions?**
A: No. This only affects browser chrome appearance, not extension functionality.

**Q: Can I use this with a Firefox theme?**
A: Yes, but "System" theme works best for Mica/Acrylic transparency. Custom themes may override some colors.

**Q: Does this affect performance?**
A: Minimal impact. Blur is 8–12px (not excessive), no continuous animations, and we use `transform`/`opacity` for GPU-accelerated transitions.
