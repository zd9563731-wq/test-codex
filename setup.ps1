[CmdletBinding()]
param(
    [string]$ProjectsRoot = (Join-Path ([Environment]::GetFolderPath('MyDocuments')) 'CodexProjects')
)

$ErrorActionPreference = 'Stop'

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    throw 'Git is not installed. Install Git for Windows, then run setup.ps1 again.'
}

$codexHome = Join-Path $env:USERPROFILE '.codex'
$globalAgents = Join-Path $codexHome 'AGENTS.md'
$sourceAgents = Join-Path $PSScriptRoot 'AGENTS.md'
$startMarker = '<!-- codex-workspace:start -->'
$endMarker = '<!-- codex-workspace:end -->'
$policy = Get-Content -Raw -LiteralPath $sourceAgents
$managedBlock = "$startMarker`r`n$policy`r`n$endMarker"

New-Item -ItemType Directory -Force -Path $codexHome | Out-Null
$existing = if (Test-Path -LiteralPath $globalAgents) {
    Get-Content -Raw -LiteralPath $globalAgents
} else {
    ''
}

$pattern = [regex]::Escape($startMarker) + '.*?' + [regex]::Escape($endMarker)
if ($existing -match $pattern) {
    $updated = [regex]::Replace($existing, $pattern, $managedBlock, 'Singleline')
} elseif ([string]::IsNullOrWhiteSpace($existing)) {
    $updated = $managedBlock
} else {
    $updated = $existing.TrimEnd() + "`r`n`r`n" + $managedBlock
}

Set-Content -LiteralPath $globalAgents -Value $updated -Encoding utf8
Write-Host "Installed global Codex workflow: $globalAgents" -ForegroundColor Green

& (Join-Path $PSScriptRoot 'sync.ps1') -ProjectsRoot $ProjectsRoot


