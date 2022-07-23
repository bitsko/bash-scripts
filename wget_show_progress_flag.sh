#!/bin/bash
wget_version=$(wget --version | head -n 1 | cut -d ' ' -f 3)
if (( $(echo "$wget_version >= 1.16" | bc -l) )); then
	echo "wget works with --show-progress"
else
	echo "wget does not work with --show-progress"
fi
