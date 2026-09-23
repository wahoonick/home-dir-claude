#!/usr/bin/env bash
# Launch Claude Code agents, one per new Terminal window.
#
# Usage:
#   ./agent-startup.sh              # launch every agent in the list
#   ./agent-startup.sh fw-delegator # launch only the named agents
#
# Add a line to AGENTS to add an agent. Format: "<agent-name>|<working-dir>".
# <agent-name> must match a file in ~/.claude/agents/ or <repo>/.claude/agents/.

set -euo pipefail

AGENTS=(
  "fw-delegator|$HOME/wahoo"
  "esp32-developer|$HOME/wahoo/fw_trainer_wifi"
)

launch() {
  local agent="$1" dir="$2"
  local cmd="cd '$dir' && claude --agent '$agent' -n '$agent' --model fable"
  osascript -e "tell application \"Terminal\" to do script \"$cmd\"" >/dev/null
  echo "launched $agent in $dir"
}

for entry in "${AGENTS[@]}"; do
  IFS='|' read -r agent dir <<<"$entry"
  if [ "$#" -gt 0 ]; then
    case " $* " in *" $agent "*) ;; *) continue ;; esac
  fi
  launch "$agent" "$dir"
done
