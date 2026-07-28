#!/usr/bin/env bash
# kanban-add.sh - Add a task to the Kanban board
# Usage: ./kanban-add.sh "Task description" [status] [priority]

set -e

TASK="${1:-}"
STATUS="${2:-Backlog}"
PRIORITY="${3:-Medium}"

if [ -z "$TASK" ]; then
    echo "Usage: $0 \"Task description\" [status] [priority]"
    exit 1
fi

BOARD_FILE=".kanban/board.json"

if [ ! -f "$BOARD_FILE" ]; then
    mkdir -p .kanban
    echo '{"columns": ["Backlog", "In Progress", "Review", "Done"], "cards": [], "status": "default"}' > "$BOARD_FILE"
fi

ID=$(date +%s)
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# Create the new card
NEW_CARD=$(cat <<EOF
{
  "id": "$ID",
  "title": "$TASK",
  "status": "$STATUS",
  "priority": "$PRIORITY",
  "created": "$TIMESTAMP"
}
EOF
)

# Use jq if available, otherwise use node
if command -v jq &> /dev/null; then
    jq ".cards += [$NEW_CARD]" "$BOARD_FILE" > "${BOARD_FILE}.tmp" && mv "${BOARD_FILE}.tmp" "$BOARD_FILE"
else
    node -e "
const fs = require('fs');
const board = JSON.parse(fs.readFileSync('$BOARD_FILE', 'utf8'));
const newCard = $NEW_CARD;
board.cards.push(newCard);
fs.writeFileSync('$BOARD_FILE', JSON.stringify(board, null, 2));
"
fi

echo "Added task: $TASK (Status: $STATUS, Priority: $PRIORITY)"