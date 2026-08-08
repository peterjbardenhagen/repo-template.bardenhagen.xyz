# Kanban Board Integration

This repository uses a local Kanban board (`.kanban/board.json`) for task management.

## Usage

### Add a task via CLI

```bash
# Add a new task
./.kanban/add-task.sh "Implement feature X" "In Progress" "High"

# Or use PowerShell on Windows
powershell -File .kanban/add-task.ps1 -Task "Implement feature X" -Status "In Progress" -Priority "High"
```

### Board Structure

- **Backlog**: Tasks waiting to be started
- **In Progress**: Active tasks being worked on
- **Review**: Completed tasks awaiting review
- **Done**: Finished tasks

### Integration with Project Management

Tasks can be synced to:
- GitHub Projects (via custom scripts)
- Linear
- Jira
- Notion
- Cline/Hermes (local task files)
