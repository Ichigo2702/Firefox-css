#!/usr/bin/env bash
# ==============================================================================
# install.sh — Automated Firefox CSS Theme Installer
# ==============================================================================
# Automatically detects your active Firefox profile, creates the chrome symlink,
# and enables custom stylesheets in user.js.
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Firefox CSS Theme Installer"

# 1. Search for Firefox profile directory
CANDIDATE_DIRS=(
  "$HOME/.config/mozilla/firefox"
  "$HOME/.mozilla/firefox"
  "$HOME/.var/app/org.mozilla.firefox/.mozilla/firefox"
  "$HOME/snap/firefox/common/.mozilla/firefox"
  "$HOME/Library/Application Support/Firefox/Profiles"
)

PROFILE_DIR=""
for dir in "${CANDIDATE_DIRS[@]}"; do
  if [ -d "$dir" ]; then
    # Look for profiles.ini or default-release directory
    if [ -f "$dir/profiles.ini" ]; then
      DEFAULT_PATH=$(grep -E "^Default=" "$dir/profiles.ini" 2>/dev/null | cut -d= -f2 | head -n 1 || true)
      if [ -n "$DEFAULT_PATH" ] && [ -d "$dir/$DEFAULT_PATH" ]; then
        PROFILE_DIR="$dir/$DEFAULT_PATH"
        break
      fi
    fi
    # Fallback: check directly for *.default-release
    MATCH=$(find "$dir" -maxdepth 1 -type d -name "*.default-release" 2>/dev/null | head -n 1 || true)
    if [ -n "$MATCH" ]; then
      PROFILE_DIR="$MATCH"
      break
    fi
  fi
done

if [ -z "$PROFILE_DIR" ]; then
  echo "Error: Could not automatically locate your Firefox profile folder."
  echo "Please specify your profile path manually as an argument:"
  echo "  ./install.sh /path/to/profile.default-release"
  exit 1
fi

if [ "${1:-}" != "" ] && [ -d "$1" ]; then
  PROFILE_DIR="$1"
fi

echo "==> Target Profile: $PROFILE_DIR"

# 2. Setup user.js for stylesheets
USER_JS="$PROFILE_DIR/user.js"
PREF_LINE='user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);'

if [ ! -f "$USER_JS" ]; then
  echo "$PREF_LINE" > "$USER_JS"
  echo "==> Created user.js and enabled stylesheets preference."
elif ! grep -q "toolkit.legacyUserProfileCustomizations.stylesheets" "$USER_JS"; then
  echo "" >> "$USER_JS"
  echo "$PREF_LINE" >> "$USER_JS"
  echo "==> Appended stylesheet preference to existing user.js."
else
  echo "==> Stylesheet preference already present in user.js."
fi

# 3. Create or update chrome symlink
CHROME_LINK="$PROFILE_DIR/chrome"

if [ -L "$CHROME_LINK" ]; then
  ln -sfn "$SCRIPT_DIR" "$CHROME_LINK"
  echo "==> Updated existing chrome symlink -> $SCRIPT_DIR"
elif [ -d "$CHROME_LINK" ]; then
  BACKUP="$PROFILE_DIR/chrome_backup_$(date +%s)"
  echo "==> Existing chrome directory found. Backing up to $BACKUP..."
  mv "$CHROME_LINK" "$BACKUP"
  ln -sfn "$SCRIPT_DIR" "$CHROME_LINK"
  echo "==> Created chrome symlink -> $SCRIPT_DIR"
else
  ln -sfn "$SCRIPT_DIR" "$CHROME_LINK"
  echo "==> Created chrome symlink -> $SCRIPT_DIR"
fi

echo ""
echo "=============================================================================="
echo " Installation Complete!"
echo " Restart Firefox to load the custom theme."
echo "=============================================================================="
