#!/bin/bash
mkdir -p .shortest
printf '\n\n=== Run started at %s ===\n' "$(date)" >> .shortest/debug.log
FORCE_COLOR=1 npx shortest $@ 2>&1 | while IFS= read -r line; do
  # Strip color codes for log file but keep them in terminal
  clean_line=$(echo "$line" | perl -pe 's/\e\[[0-9;]*[mGK]//g')
  printf '%s %s\n' "$(date '+%H:%M:%S')" "$clean_line" | tee -a .shortest/debug.log
done
