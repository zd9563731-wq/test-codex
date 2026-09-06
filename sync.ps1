[CmdletBinding()]
param(
    [string]$ProjectsRoot = (Join-Path ([Environment]::GetFolderPath('MyDocuments')) 'CodexProjects')
)

$ErrorActionPreference = 'Stop'
$manifestPath = Join-Path $PSScriptRoot 'projects.json'
$manifest = Get-Content -Raw -LiteralPath $manifestPath | ConvertFrom-Json

New-Item -ItemType Directory -Force -Path $ProjectsRoot | Out-Null

foreach ($repo in $manifest.repositories) {
    if (-not $repo.enabled) { continue }

    $target = Join-Path $ProjectsRoot $repo.name
    if (Test-Path -LiteralPath (Join-Path $target '.git')) {
        Write-Host "Updating $($repo.name)..." -ForegroundColor Cyan
        git -C $target pull --ff-only
        if ($LASTEXITCODE -ne 0) {
            Write-Warning "$($repo.name) was not updated. Resolve its local changes, then run sync.ps1 again."
        }
    }
    elseif (Test-Path -LiteralPath $target) {
        Write-Warning "Skipping $($repo.name): $target exists but is not a Git repository."
    }
    else {
        Write-Host "Cloning $($repo.name)..." -ForegroundColor Green
        git clone $repo.url $target
        if ($LASTEXITCODE -ne 0) {
            Write-Warning "$($repo.name) could not be cloned. Check GitHub authentication, then retry."
        }
    }
}

Write-Host "All projects are under: $ProjectsRoot" -ForegroundColor Green


