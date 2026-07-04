# Firefox 152 — Polished UI Redesign

A modular CSS customization system that makes Firefox look and feel significantly more polished while maintaining its identity.

## Folder Structure

```
chrome/
├── userChrome.css              <- Main entry (imports only)
├── userContent.css             <- Content styles (imports only)
└── modules/
    ├── 01-variables.css        <- All design tokens + animations
    ├── 02-toolbar.css          <- Toolbar, compact mode, buttons
    ├── 03-tabs-urlbar.css      <- Tabs + URL bar + autocomplete (Disabled by default)
    ├── 04-bookmarks-sidebar.css <- Bookmarks + sidebar
    ├── 05-menus.css            <- Panels, popups, downloads, tooltips, findbar
    ├── 06-contextmenu.css      <- Context menu cleanup + styling
    ├── 07-internal-pages.css   <- about: pages + PDF viewer
    ├── 08-websites.css         <- ChatGPT, GitHub, Reddit, Gmail
    ├── 09-extras.css           <- Fullscreen, scrollbars, PiP, Ctrl+Tab
    └── 10-foxone-features.css  <- Dynamic tabs, hover-reveal icons, floating find bar
```

## Features

### UI
- Compact mode (one variable switch)
- Very compact mode (28px height)
- Smooth bookmark toolbar animation
- Dynamic tabs (expand on hover/focus)
- Hover-reveal for pinned extensions
- Hover-reveal for URL bar icons (reader mode, translation, etc.)
- Better hover effects everywhere
- Acrylic menus (blur + transparency)
- Rounded menus (10px radius)
- Better context menus
- Better toolbar spacing
- Better extension popup
- Better download popup
- Better bookmark menus
- Better overflow menu
- Better identity popup
- Better permission dialogs
- Better Ctrl+Tab switcher
- Better bookmark star animation
- Better Picture-in-Picture button
- Better extension badges
- Better tab preview panel

### Animations
- Smooth everywhere (150ms/200ms/300ms)
- Better fullscreen transition
- Sidebar animation
- Hover transitions
- Tab close button fade
- Panel opening animation (scale-in)
- Floating find bar (top right)
- Bookmark toolbar slide-down
- Download indicator pulse

### Internal Pages
- about:config (rounded search, better tables)
- about:preferences (rounded categories, inputs)
- about:support (better tables, copy buttons)
- about:downloads (rounded items, progress bars)
- PDF viewer (rounded toolbar buttons)

### Websites
- ChatGPT (code blocks, inputs, scrollbars)
- GitHub (code font, buttons, avatars)
- Reddit (post cards, inputs, threads)
- Gmail (compose button, email rows, search)

## Installation & Setup

Follow these steps to set up the theme on your system:

### Step 1: Locate your Firefox Profile Folder
1. Open Firefox.
2. In the address bar, type `about:support` and press **Enter**.
3. Under the **Application Basics** section, look for **Profile Folder** and click the **Open Folder** button. This will open your file explorer at your active profile directory (e.g., `C:\Users\<YourUsername>\AppData\Roaming\Mozilla\Firefox\Profiles\<profile-id>.default-release`).

### Step 2: Place the Files
1. Inside your profile directory, look for a folder named **`chrome`**. (If it does not exist, create a new folder named `chrome` in lowercase).
2. Copy or clone this repository's contents (specifically `userChrome.css`, `userContent.css`, and the `modules/` folder) directly into that `chrome/` folder.
3. Your final file layout should look like this:
   ```text
   <profile-folder>/chrome/
   ├── userChrome.css
   ├── userContent.css
   └── modules/
       ├── 01-variables.css
       ├── ...
   ```

### Step 3: Enable Custom Stylesheets in Firefox
1. In Firefox, type **`about:config`** into the address bar and press **Enter**.
2. Click **Accept the Risk and Continue**.
3. Search for:
   ```text
   toolkit.legacyUserProfileCustomizations.stylesheets
   ```
4. Double-click it (or click the toggle button) to change its value from `false` to **`true`**.

### Step 4: Enable Mica/Acrylic Blur (Windows 11 only, Optional)
To enable the premium Windows 11 Mica translucent window effect:
1. In **`about:config`**, search for:
   ```text
   widget.windows.mica
   ```
2. Double-click it to change its value to **`true`**.
3. Go to Firefox menu -> **Add-ons and Themes** -> **Themes** and ensure you are using the **System theme — auto** or the default **Dark** theme. (For more details, check `docs/about-config-guide.md`).

### Step 5: Restart Firefox
1. Close all open Firefox windows.
2. Relaunch Firefox to load the custom theme.

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
| Context menu items still showing | Clear Firefox startup cache: Help -> More Troubleshooting -> Clear Startup Cache |
| Scrollbar too thin/thick | Adjust `--uc-scrollbar-width` in `01-variables.css` |

## Firefox Compatibility

| Version | Status |
|---|---|
| Firefox 152 (current) | Fully tested |
| Firefox 138-151 | Should work, Mica/Acrylic may differ |
| Firefox < 138 | No Mica support, some selectors may differ |

## FAQ

**Q: Will this break my extensions?**
A: No. This only affects browser chrome appearance, not extension functionality.

**Q: Can I use this with a Firefox theme?**
A: Yes, but "System" theme works best for Mica/Acrylic transparency. Custom themes may override some colors.

**Q: Does this affect performance?**
A: Minimal impact. Blur is 8-12px (not excessive), no continuous animations, and we use `transform`/`opacity` for GPU-accelerated transitions.
