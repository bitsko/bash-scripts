#!/bin/bash
wget_version=$(wget --version | head -n 1 | cut -d ' ' -f 3)
if (( $(echo "$wget_version >= 1.16" | bc -l) )); then
	echo "wget works with --show-progress"
else
	echo "wget does not work with --show-progress"
fi
cmake_version=$(cmake -version | cut -d ' ' -f 3 | sed 's/\.//g' | cut -c -3)
if (( $(echo "$cmake_version < 313" | bc -l) )); then
	echo "CMake 3.13 or higher is required. You are running version $(cmake -version | cut -d ' ' -f 3)"
else 
	echo "CMake version $(cmake -version | cut -d ' ' -f 3) installed"
fi
