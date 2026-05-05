<#
.SYNOPSIS
Offline Keycloak realm exporter.

.DESCRIPTION
Exports a Keycloak realm to a JSON file by running the official Keycloak
offline export command (`kc.sh export`) inside a temporary Keycloak container.
Users are also included in the realm export.

This works because Keycloak’s export command must run **offline**, not while
the server is running. The official Keycloak guide confirms that export is
designed to run with the server stopped and may conflict with a running
instance. [1](https://www.keycloak.org/server/importExport)

The script:
  - Detects your running Keycloak container (dev mode).
  - Copies its `/opt/keycloak/data` directory to a temp folder.
  - Launches a separate Keycloak container using the same image.
  - Performs an offline `kc.sh export` for the specified realm.
  - Writes the exported JSON file into the same folder as the script,
    unless a custom `-OutFile` path is provided.

Requires: PowerShell 7+, and Keycloak running in Docker.

.EXAMPLE
.\export_realm.ps1 -Realm local-dev

Creates:
  .\realm-export.json

#>

param(
    [Parameter(Mandatory = $true)]
    [string]$Realm,

    [string]$OutFile = $(Join-Path (Get-Location) ("realm-export.json")),

    [string]$ContainerId = $null,

    [switch]$KeepTemp,

    # If your Docker backend requires WSL-style mounts, toggle this.
    [switch]$UseWslPaths
)

function Fail($msg) { throw $msg }

function To-WSLPath([string]$p) {
    if ($p -match '^[A-Za-z]:\\') {
        $drive = $p.Substring(0,1).ToLower()
        $rest  = $p.Substring(2).Replace('\','/')
        return "/mnt/$drive/$rest"
    }
    return $p
}

# -----------------------------
# Detect Keycloak container
# -----------------------------
if (-not $ContainerId) {
    $ps = & docker ps --format "{{.ID}} {{.Image}} {{.Ports}}"
    if ($LASTEXITCODE -ne 0) { Fail "Failed to list containers." }

    # Prefer something that looks like Keycloak on 8080, otherwise any keycloak image
    $kcLine = ($ps -split "`n" | Where-Object { $_ -match "keycloak" -and $_ -match "8080->" } | Select-Object -First 1)
    if (-not $kcLine) {
        $kcLine = ($ps -split "`n" | Where-Object { $_ -match "keycloak" } | Select-Object -First 1)
    }
    if (-not $kcLine) { Fail "No Keycloak container found. Specify -ContainerId." }

    $ContainerId = $kcLine.Split()[0]
}

Write-Host "Using container: $ContainerId" -ForegroundColor Cyan

# -----------------------------
# Determine exact image used
# -----------------------------
$image = (& docker ps --filter "id=$ContainerId" --format "{{.Image}}")
if (-not $image) { Fail "Could not determine the image for container $ContainerId." }

Write-Host "Using image: $image" -ForegroundColor Cyan

# -----------------------------
# Prepare temp folder and copy data
# -----------------------------
$ts       = Get-Date -Format "yyyyMMdd-HHmmss"
$tempRoot = Join-Path $env:TEMP ("kc-offline-" + $ts)
$tempData = Join-Path $tempRoot "data"

New-Item -ItemType Directory -Force -Path $tempRoot | Out-Null

# Build "container:/path" **without** interpolation
$src = $ContainerId + ":/opt/keycloak/data"

Write-Host "Copying $src -> $tempRoot" -ForegroundColor Cyan
& docker cp $src $tempRoot
if ($LASTEXITCODE -ne 0) { Fail "Failed to copy /opt/keycloak/data from container." }

# docker cp "container:/dir" <dest> typically creates <dest>\dir
# Some hosts create <dest>\data or <dest>\data\data; handle both
$path1 = Join-Path $tempRoot "data"
$path2 = Join-Path $path1  "data"

if (Test-Path $path2) {
    $dataPath = $path2
} elseif (Test-Path $path1) {
    $dataPath = $path1
} else {
    Fail "Could not find copied data at '$path1' or '$path2'."
}

Write-Host "Temp folder: $tempRoot" -ForegroundColor DarkCyan
Write-Host "Using data path: $dataPath" -ForegroundColor DarkCyan

# -----------------------------
# Ensure output path
# -----------------------------
$outDir  = Split-Path $OutFile -Parent
$outName = Split-Path $OutFile -Leaf
if (-not (Test-Path $outDir)) { New-Item -ItemType Directory -Force -Path $outDir | Out-Null }

# If requested, convert to WSL paths for mounts
$mountDataDir = $UseWslPaths ? (To-WSLPath $dataPath) : $dataPath
$mountOutDir  = $UseWslPaths ? (To-WSLPath $outDir)   : $outDir

# Build the "-v" arguments **without** "$var:/path" in strings
$mountDataArg = $mountDataDir + ":/opt/keycloak/data"
$mountOutArg  = $mountOutDir  + ":/out"
$outJson      = "/out/" + $outName

# -----------------------------
# Run offline export
# -----------------------------

# Build the "-v" arguments without "$var:/path" in strings
$mountDataArg = $mountDataDir + ":/opt/keycloak/data"
$mountOutArg  = $mountOutDir  + ":/out"
$outJson      = "/out/" + $outName

Write-Host "Running offline Keycloak export..." -ForegroundColor Cyan

$runArgs = @(
    "run","--rm",
    "-v",$mountDataArg,
    "-v",$mountOutArg,
    $image,"export",
    "--realm",$Realm,
    "--file",$outJson,
    "--users","same_file"
)

Write-Host "[docker $($runArgs -join ' ')]" -ForegroundColor DarkGray
& docker @runArgs
if ($LASTEXITCODE -ne 0) { throw "Offline export failed. Check that the image supports 'export' and the realm exists." }

# -----------------------------
# File cleanup
# -----------------------------

Write-Host ""
Write-Host "======================================" -ForegroundColor Green
Write-Host " Realm export complete (OFFLINE)!" -ForegroundColor Green
Write-Host " File saved to:" -ForegroundColor Green
Write-Host " $OutFile" -ForegroundColor Yellow
Write-Host "======================================" -ForegroundColor Green
Write-Host ""

if ($KeepTemp) {
    Write-Host "Temp kept at: $tempRoot" -ForegroundColor Yellow
} else {
    try {
        Remove-Item -Recurse -Force -Path $tempRoot
    } catch {
        Write-Host "Warning: Failed to clean up temp directory: $tempRoot" -ForegroundColor Yellow
    }
}

# -----------------------------