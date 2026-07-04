# Future Improvements

Features that are planned, skipped, waiting on Firefox changes, or intentionally omitted.

## Features Waiting on Firefox Changes

| Feature | Reason | Firefox Bug / Status | Expected |
|---|---|---|---|
| Native CSS nesting in userChrome | Firefox supports it in web content but behavior in chrome CSS is inconsistent | Gecko engine limitation | Future releases |
| `backdrop-filter` in chrome context | Works inconsistently for browser UI elements; we use native Mica/Acrylic instead | Performance concerns | May improve with WebRender updates |
| Container tab indicator styling | Container tab colors use internal APIs that CSS can't fully override | Missing CSS hooks | Unknown |

## Features Intentionally Omitted

| Feature | Reason |
|---|---|
| Tree-style vertical tabs | Requires extension (Sidebery/TST); our sidebar module works alongside them |
| Custom new tab page | Separate project scope; use extensions like Tabliss or Nighttab |
| Custom start page | Same as above |
| Arc-style vertical sidebar tabs | Conflicts with Firefox identity design goal |
| Edge-style rounded window frame | OS-level window management, not CSS-controllable |
| Custom icon replacements | SVG icon overrides are fragile across updates |
| Tab grouping visual redesign | Firefox's tab groups UI changes frequently; our styling is minimal to avoid breakage |

## Planned Enhancements

| Feature | Priority | Module | Notes |
|---|---|---|---|
| Better DevTools styling | Medium | New module | DevTools have their own CSS; separate `userChrome.css` section needed |
| Better about:addons page | Low | 07-internal-pages | Addons page has complex React-based UI |
| Better about:newtab | Low | 07-internal-pages | New tab page styling (activity stream) |
| YouTube website styles | Medium | 08-websites | Dark mode, player controls, comments |
| Twitter/X website styles | Low | 08-websites | Dark mode, spacing |
| Animated tab loading gradient | Medium | 03-tabs-urlbar | Gradient sweep instead of spinner |
| Better tab group colors | Medium | 03-tabs-urlbar | Waiting for tab groups to stabilize |
| Sidebar auto-collapse | Medium | 04-bookmarks-sidebar | Auto-hide sidebar to icon-only mode |
| Better reader mode styling | Low | New module | Reader mode has its own content doc |

## Features Skipped (Low Value or High Risk)

| Feature | Reason |
|---|---|
| Custom window title bar buttons | Windows handles these natively; CSS overrides are fragile |
| Auto-hide tab bar (single tab) | Significant UX change; better as a separate opt-in hack |
| Tab bar at bottom of window | Major layout restructuring; breaks easily |
| Menu bar customization | Very few users use the menu bar |
| Multiple toolbar rows | Niche use case; breaks compact mode |
| Status bar at bottom | Removed from Firefox; would require XUL overlay hacks |

## Known Limitations

| Limitation | Workaround |
|---|---|
| Acrylic blur requires Windows 11 + native Mica flags | Falls back to solid backgrounds gracefully |
| Context menu cleanup uses `!important` heavily | Necessary to override Firefox defaults; no clean alternative |
| Website-specific styles may break when sites redesign | Each site section is independent; comment out individual `@-moz-document` blocks |
| Some tooltip styles may not apply to all tooltip types | Firefox uses multiple tooltip implementations; we cover the most common |
| PDF viewer styling is limited | pdf.js has restricted CSS customization; only toolbar buttons are styled |
