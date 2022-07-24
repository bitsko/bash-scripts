#!/usr/bin/env bash

debug_location(){ if [[ "$?" != 0 ]]; then
		echo $'\n\n'"$debug_step has failed!"$'\n\n'
		script_exit
                unset -f script_exit
                exit 1; fi; }

script_exit(){ unset \
        debug_location debug_step cpu_type uname_OS system_OS pkg_to_install pkg_array_ \
        deb_os_array suse___array archos_array redhat_array bsdpkg_array armcpu_array \
        x86cpu_array; }

declare -a suse___array=( opensuse-tumbleweed )
declare -a bsdpkg_array=( freebsd OpenBSD NetBSD dragonfly )
declare -a redhat_array=( fedora centos rocky amzn rhel )
declare -a deb_os_array=( debian ubuntu raspbian linuxmint pop )
declare -a archos_array=( manjaro-arm manjaro endeavouros arch )
declare -a armcpu_array=( aarch64 aarch64_be armv8b armv8l armv7l )
declare -a x86cpu_array=( i686 x86_64 i386 ) # amd64     

debug_step="find the operating system type"
cpu_type="$(uname -m)"; debug_location
uname_OS="$(uname -s)"
system_OS=$(if [[ -f /etc/os-release ]]; then source /etc/os-release; echo "$ID"; fi; )
if [[ -z "$system_OS" ]]; then system_OS="$uname_OS"; fi
if [[ "$system_OS" == "Linux" ]]; then echo "Linux distribution type unknown; cannot check for dependencies"; fi
echo "building for: $system_OS $cpu_type"

debug_step="dependencies installation"
if [[ "${deb_os_array[*]}" =~ "$system_OS" ]]; then
	sudo apt update
	sudo apt -y upgrade
	declare -a pkg_array_=( )
				
	while read -r line; do
        	if ! dpkg -s "$line" &> /dev/null; then
			pkg_to_install+=( "$line" )
		fi
       	done <<<$(printf '%s\n' "${pkg_array_[@]}")
	if [[ -n "${pkg_to_install[*]}" ]]; then
                sudo apt -y install ${pkg_to_install[*]}
                debug_location
        fi
	if [[ "${armcpu_array[*]}" =~ "$cpu_type" ]]; then
		if ! dpkg -s g++ &> /dev/null; then
			sudo apt -y install g++-arm-linux-gnueabihf
			debug_location
		fi
	fi
elif [[ "${suse___array[*]}" =~ "$system_OS" ]]; then
	if [[ $"system_OS" == opensuse-tumbleweed ]]; then
		sudo zypper dup
	fi
	declare -a pkg_array_=(  )
		
	while read -r line; do
               if ! which "$line" &>/dev/null; then
			pkg_to_install+=( "$line" )
			debug_location
		fi
	done <<<$(printf '%s\n' "${pkg_array_[@]}")
	if [[ -n "${pkg_to_install[*]}" ]]; then
       	        sudo zypper install -y ${pkg_to_install[*]}
       		debug_location
	fi
elif [[ "${archos_array[*]}" =~ "$system_OS" ]]; then
	sudo pacman -Syu
	declare -a pkg_array_=(  )
	while read -r line; do
        	if ! pacman -Qi "$line" &> /dev/null; then
			pkg_to_install+=( "$line" )
			debug_location
		fi
	done <<<$(printf '%s\n' "${pkg_array_[@]}")
	if [[ -n "${pkg_to_install[*]}" ]]; then
       	        sudo pacman --noconfirm -Sy ${pkg_to_install[*]}
       		debug_location
	fi
elif [[ "${redhat_array[*]}" =~ "$system_OS" ]]; then
        if [[ -n $(command -v dnf) ]]; then
			sudo dnf install -y ${pkg_to_install[*]}
        else
			sudo yum install -y ${pkg_to_install[*]}
	fi
        if [[ "$system_OS" == fedora ]]; then
		declare -a pkg_array_=( )
        elif [[ "$system_OS" == centos || "$system_OS" == rocky ]] ||  \
                [[ "$system_OS" == rhel || "$system_OS" == amzn ]]; then
	        declare -a pkg_array_=(  )             
	else
		echo "$uname_OS unsupported"
		exit 1
	fi
	while read -r line; do
                if ! rpm -qi "$line" &> /dev/null; then
                        pkg_to_install+=( "$line" )
                        debug_location
                fi
        done <<<$(printf '%s\n' "${pkg_array_[@]}")
        if [[ -n "${pkg_to_install[*]}" ]]; then
               	if [[ -n $(command -v dnf) ]]; then
			sudo dnf install -y ${pkg_to_install[*]}
                else
			sudo yum install -y ${pkg_to_install[*]}
		fi
		debug_location
	fi
elif [[ "${bsdpkg_array[*]}" =~ "$system_OS" ]]; then
	if [[ "$uname_OS" == OpenBSD ]]; then
	declare -a pkg_array_=(  )
			
	elif [[ "$uname_OS" == NetBSD ]]; then
		if [[ -z $(command -v pkgin) ]]; then
			pkg_add pkgin
		fi
		declare -a pkg_array_=(  )
			
	elif [[ "$system_OS" == freebsd || "$system_OS" == dragonfly ]]; then
		pkg upgrade -y
		declare -a pkg_array_=(  )
	else
		echo "$system_OS bsd distro not supported"
	fi
	while read -r line; do 
		if ! command -v "$line" >/dev/null; then
			pkg_to_install+=( "$line" )
		fi
	done <<<$(printf '%s\n' "${pkg_array_[@]}")
	
	if [[ -n "${pkg_to_install[*]}" ]]; then
		if [[ "$system_OS" == freebsd ]]; then
			pkg install -y ${pkg_to_install[*]}
			debug_location
		elif [[ "$uname_OS" == "OpenBSD" ]] || [[ "$uname_OS" == "NetBSD" ]]; then
			if [[ -n $(command -v pkgin) ]]; then
				pkgin install ${pkg_to_install[*]}
			else
				pkg_add ${pkg_to_install[*]}
			fi
			debug_location
		fi
	fi
elif [[ "$system_OS" == "Linux" ]]; then
	echo "attempting to compile without checking dependencies"
else
	echo "$system_OS unsupported"
	script_exit
	unset -f script_exit
	exit 1
fi
# end dependency installation script
