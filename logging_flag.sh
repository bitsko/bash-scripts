#!/usr/bin/env bash
logging=1
debug_message="pop"
echo "echo $debug_message" | \
  if [[ $logging == 0 ]]; then
    cut -c 6-<<<$(cat)
  else
    cut -c 6-<<<$(cat) | \
      tee -a pop.log
  fi
