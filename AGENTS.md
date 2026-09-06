# Personal Codex workflow

## GitHub project publishing

- When a chat creates a reusable project or a meaningful set of project files, check whether the working directory is already connected to a GitHub remote.
- If it is not connected, ask the user once near completion whether they want the project published to GitHub.
- If the user agrees, use the connected GitHub account and default to a private repository unless the user explicitly requests public visibility.
- Before publishing, inspect for secrets, `.env` files, credentials, private keys, dependency folders, build output, and oversized generated files. Never upload secrets.
- Create or update an appropriate `.gitignore`, a concise `README.md`, and project-level `AGENTS.md` when useful.
- After publishing a new repository, add it to the `projects.json` manifest in the `codex-workspace` repository so a new computer can retrieve it through the common sync command.
- For an existing repository, ask whether to commit and push meaningful completed changes when they are not yet synchronized.
- Do not ask about GitHub for ordinary question-answering chats that did not create a reusable project.


