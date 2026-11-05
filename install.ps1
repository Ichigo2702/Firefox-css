# ==============================================================================
# install.ps1 — Automated Firefox CSS Theme Installer for Windows
# ==============================================================================
# Automatically detects your active Firefox profile, creates the chrome junction,
# and configures user.js with custom stylesheet and bookmarks preferences.
# ==============================================================================

[CmdletBinding()]
param(
    [string]$ProfilePath
)

$ErrorActionPreference = "Stop"
$ScriptDir = $PSScriptRoot

Write-Host "==> Firefox CSS Theme Installer (Windows)" -ForegroundColor Cyan

# 1. Search for Firefox profile directory
$AppDataFirefox = Join-Path $env:APPDATA "Mozilla\Firefox"
$TargetProfile = ""

if ($ProfilePath -and (Test-Path $ProfilePath)) {
    $TargetProfile = (Resolve-Path $ProfilePath).Path
} else {
    $ProfilesIni = Join-Path $AppDataFirefox "profiles.ini"
    if (Test-Path $ProfilesIni) {
        $iniLines = Get-Content $ProfilesIni
        # Check for default install profile
        $match = $iniLines | Select-String -Pattern "^Default=(.+)" | Select-Object -First 1
        if ($match) {
            $relPath = $match.Matches[0].Groups[1].Value.Trim().Replace('/', '\')
            $candidate = Join-Path $AppDataFirefox $relPath
            if (Test-Path $candidate) {
                $TargetProfile = $candidate
            }
        }
    }

    if (-not $TargetProfile) {
        $ProfilesFolder = Join-Path $AppDataFirefox "Profiles"
        if (Test-Path $ProfilesFolder) {
            $candidate = Get-ChildItem -Path $ProfilesFolder -Directory -Filter "*.default-release" | Select-Object -First 1
            if ($candidate) {
                $TargetProfile = $candidate.FullName
            }
        }
    }
}

if (-not $TargetProfile -or -not (Test-Path $TargetProfile)) {
    Write-Error "Could not automatically locate your Firefox profile folder. Please pass it as an argument: .\install.ps1 -ProfilePath 'C:\path\to\profile'"
    exit 1
}

Write-Host "==> Target Profile: $TargetProfile" -ForegroundColor Green

# 2. Setup user.js
$UserJs = Join-Path $TargetProfile "user.js"
$Preferences = @(
    'user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);',
    'user_pref("browser.toolbars.bookmarks.visibility", "always");',
    'user_pref("gfx.webrender.all", true);'
)

if (-not (Test-Path $UserJs)) {
    $Preferences | Set-Content $UserJs -Encoding UTF8
    Write-Host "==> Created user.js with required preferences." -ForegroundColor Green
} else {
    $existing = Get-Content $UserJs -Raw
    $added = 0
    foreach ($pref in $Preferences) {
        $key = ($pref -split '"')[1]
        if ($existing -notmatch [regex]::Escape($key)) {
            Add-Content -Path $UserJs -Value $pref -Encoding UTF8
            $added++
        }
    }
    if ($added -gt 0) {
        Write-Host "==> Appended $added missing preferences to existing user.js." -ForegroundColor Green
    } else {
        Write-Host "==> All required preferences already present in user.js." -ForegroundColor Green
    }
}

# 3. Create or update chrome junction
$ChromeDir = Join-Path $TargetProfile "chrome"

if (Test-Path $ChromeDir) {
    $item = Get-Item $ChromeDir -Force
    if ($item.Attributes -band [System.IO.FileAttributes]::ReparsePoint) {
        Write-Host "==> Existing chrome junction verified: $($item.Target)" -ForegroundColor Green
    } else {
        $backup = Join-Path $TargetProfile ("chrome_backup_" + (Get-Date -Format "yyyyMMddHHmmss"))
        Write-Host "==> Existing chrome folder found. Backing up to $backup..." -ForegroundColor Yellow
        Rename-Item -Path $ChromeDir -NewName (Split-Path $backup -Leaf)
        New-Item -ItemType Junction -Path $ChromeDir -Target $ScriptDir | Out-Null
        Write-Host "==> Created chrome junction -> $ScriptDir" -ForegroundColor Green
    }
} else {
    New-Item -ItemType Junction -Path $ChromeDir -Target $ScriptDir | Out-Null
    Write-Host "==> Created chrome junction -> $ScriptDir" -ForegroundColor Green
}

Write-Host ""
Write-Host "==============================================================================" -ForegroundColor Cyan
Write-Host " Installation Complete!" -ForegroundColor Green
Write-Host " Restart Firefox to load the custom theme." -ForegroundColor Cyan
Write-Host "==============================================================================" -ForegroundColor Cyan

