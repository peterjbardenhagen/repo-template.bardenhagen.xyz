# Kanban Board Integration

This repository uses a local Kanban board (`.kanban/board.json`) for task management.

## Usage

### Add a task via CLI

```bash
# Add a new task
./.kanban/add-task.sh "Implement feature X" "In Progress" "High"

# Or use PowerShell on Windows
powershell -File .kanban\add-task.ps1 -Task "Implement feature X" -Status "In Progress" -Priority "High"
```

### Sync with npx kanban-cli

```bash
# Install kanban-cli (requires bun)
npm install -g bun
npx kanban-cli add --board .kanban/board.json --column "Backlog" --title "Task title"

# List tasks
npx kanban-cli list --board .kanban/board.json
```

## Board Structure

- **Backlog**: Tasks waiting to be started
- **In Progress**: Active tasks being worked on
- **Review**: Completed tasks awaiting review
- **Done**: Finished tasks

## Integration with Project Management

Tasks can be synced to:
- GitHub Projects (via `push_kanban.ps1`)
- Trello
- Azure DevOps
- Cline/Hermes (local task files)

## Adding Tasks to External Boards

Run the unified push script:

```powershell
# Push all tasks from backlog to GitHub Projects
.\scripts\push-kanban.ps1 -Target GitHubProjects

# Push to all platforms
.\scripts\push-kanban.ps1 -Target All
```