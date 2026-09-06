# Codex Workspace

One entry point for restoring and updating all personal Codex projects on Windows.

## New computer

```powershell
git clone https://github.com/zd9563731-wq/test-codex.git codex-workspace
cd codex-workspace
powershell -ExecutionPolicy Bypass -File .\setup.ps1
```

This installs the shared Codex workflow into `~/.codex/AGENTS.md` and clones every enabled repository into `Documents\CodexProjects`.

## Update all projects

```powershell
powershell -ExecutionPolicy Bypass -File .\sync.ps1
```

To use another project directory:

```powershell
.\sync.ps1 -ProjectsRoot 'D:\CodexProjects'
```

`sync.ps1` never overwrites local changes. Existing repositories use `git pull --ff-only`; conflicts are reported and skipped.

## Add a repository

Add its name and HTTPS clone URL to `projects.json`. The global Codex workflow instructs Codex to update this manifest after publishing a new project.

