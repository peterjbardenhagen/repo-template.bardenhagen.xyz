# Add a task to the Kanban board
param(
    [Parameter(Mandatory=$true)]
    [string]$Task,
    
    [string]$Status = "Backlog",
    [string]$Priority = "Medium"
)

$ErrorActionPreference = 'Stop'

$BOARD_FILE = ".kanban/board.json"

if (-not (Test-Path ".kanban")) {
    New-Item -ItemType Directory -Path ".kanban" -Force | Out-Null
}

if (-not (Test-Path $BOARD_FILE)) {
    @'
{
  "columns": ["Backlog", "In Progress", "Review", "Done"],
  "cards": [],
  "status": "default"
}
'@ | Set-Content -Path $BOARD_FILE -Encoding UTF8
}

$ID = [long]([DateTimeOffset]::Now.ToUnixTimeSeconds())
$TIMESTAMP = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")

$card = @{
    id = $ID
    title = $Task
    status = $Status
    priority = $Priority
    created = $TIMESTAMP
} | ConvertTo-Json -Compress

$board = Get-Content $BOARD_FILE -Raw | ConvertFrom-Json
$board.cards = @($board.cards) + ($card | ConvertFrom-Json)
$board | ConvertTo-Json -Depth 6 | Set-Content -Path $BOARD_FILE -Encoding UTF8

Write-Host "Added task: $Task (Status: $Status, Priority: $Priority)"