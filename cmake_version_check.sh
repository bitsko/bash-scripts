cmake_version=$(cmake -version | cut -d ' ' -f 3 | sed 's/\.//g' | cut -c -3)
if (( $(echo "$cmake_version < 313" | bc -l) )); then
	echo "CMake 3.13 or higher is required. You are running version $(cmake -version | cut -d ' ' -f 3)"
else 
	echo "CMake version $(cmake -version | cut -d ' ' -f 3) installed"
fi
