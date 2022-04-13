#!/usr/bin/env bash
flip=$((RANDOM % 2))
[[ $flip == 0 ]] && echo "heads"
[[ $flip == 1 ]] && echo "tails"
