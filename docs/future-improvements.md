# Future Improvements

Features that are recently implemented, planned, skipped, or intentionally omitted.

---

## Recently Implemented Enhancements

| Feature | Module | Status | Notes |
|---|---|---|---|
| **Automated Installer** | `install.sh` | **Completed** | Auto-detects profile, creates symlinks, enables `user.js` |
| **Linux/Wayland Hardening** | `04-bookmarks-sidebar`, `05-menus`, `06-contextmenu` | **Completed** | Fixed square native window backing/shadow artifacts on popups |
| **Tab Audio Playing Equalizer** | `03-tabs-urlbar` | **Completed** | GPU-composited 3-bar pulse on soundplaying tabs |
| **Container Tab Indicators** | `03-tabs-urlbar` | **Completed** | Centered bottom pill indicator replacing harsh top line |
| **Spotlight Focus Effect** | `03-tabs-urlbar` | **Completed** | Modern CSS `:has()` dimming on inactive tabs when URL bar is focused |
| **Animated Tab Loading Sweep** | `03-tabs-urlbar` | **Completed** | Sleek linear bottom sweep line during page loading |
| **Native Vertical Tabs Styling** | `04-bookmarks-sidebar` | **Completed** | Styled Firefox 130+ revamped sidebar and vertical tabs |
| **Accessibility & Reduced Motion** | `01-variables.css` | **Completed** | `@media (prefers-reduced-motion: reduce)` zero-delay guard |

---

## Planned Enhancements

| Feature | Priority | Module | Notes |
|---|---|---|---|
| Better DevTools styling | Medium | New module | DevTools have their own CSS; separate `userChrome.css` section needed |
| Better about:addons page | Low | 07-internal-pages | Addons page has complex React-based UI |
| Better about:newtab | Low | 07-internal-pages | New tab page styling (activity stream) |
| YouTube website styles | Medium | 08-websites | Dark mode, player controls, comments |
| Twitter/X website styles | Low | 08-websites | Dark mode, spacing |
| Better tab group colors | Medium | 03-tabs-urlbar | Waiting for tab groups to stabilize |
| Better reader mode styling | Low | New module | Reader mode has its own content doc |

---

## Features Waiting on Firefox Changes

| Feature | Reason | Firefox Bug / Status | Expected |
|---|---|---|---|
| Native CSS nesting in userChrome | Firefox supports it in web content but behavior in chrome CSS is inconsistent | Gecko engine limitation | Future releases |
| `backdrop-filter` in chrome context | Works inconsistently for browser UI elements; we use hardware `color-mix()` instead | Performance concerns on Linux | May improve with WebRender updates |

---

## Features Intentionally Omitted

| Feature | Reason |
|---|---|
| Custom new tab page | Separate project scope; use extensions like Tabliss or Nighttab |
| Custom start page | Same as above |
| Arc-style vertical sidebar tabs | Conflicts with Firefox identity design goal |
| Edge-style rounded window frame | OS-level window management, not CSS-controllable |
| Custom icon replacements | SVG icon overrides are fragile across updates |

---

## Features Skipped (Low Value or High Risk)

| Feature | Reason |
|---|---|
| Custom window title bar buttons | OS handles these natively; CSS overrides are fragile |
| Auto-hide tab bar (single tab) | Significant UX change; better as a separate opt-in hack |
| Tab bar at bottom of window | Major layout restructuring; breaks easily |
| Menu bar customization | Very few users use the menu bar |
| Multiple toolbar rows | Niche use case; breaks compact mode |
| Status bar at bottom | Removed from Firefox; would require XUL overlay hacks |

---

## Known Limitations & Solutions

| Limitation | Solution |
|---|---|
| Acrylic blur on Linux | Solved: High-performance `color-mix()` backgrounds provide clean semi-transparency without GPU stutter |
| Square popup shadows on Linux | Solved: Decoupled `menupopup` from `.menupopup-arrowscrollbox` with zero-padding outer window rules |
| Context menu cleanup uses `!important` | Necessary to override Firefox defaults; standard userChrome practice |
| Website-specific styles may break when sites redesign | Each site section is independent; comment out individual `@-moz-document` blocks in `08-websites.css` |
| PDF viewer styling is limited | pdf.js has restricted CSS customization; only toolbar buttons are styled |
