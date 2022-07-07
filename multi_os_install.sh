#!/bin/bash

pkg_check_fn(){ if [[ "$?" != 0 ]]; then echo "package update failed"; exit 1; fi; }

declare -a debian_array=( debian ubuntu raspbian linuxmint pop )
declare -a archos_array=( manjaro-arm manjaro endeavouros arch )

os_releaseID=$(source /etc/os-release; echo $ID)
if [[ "${deb_os_array[*]}" =~ "$os_releaseID" ]]; then
        sudo apt update
        sudo apt -y upgrade
##
        declare -a dpkg_pkg_array_=( )
##
        while read -r line; do
        if ! dpkg -s "$line" &> /dev/null
                then dpkg_to_install+=( "$line" )
        fi
        done <<<$(printf '%s\n' "${dpkg_pkg_array_[@]}")
        unset dpkg_pkg_array_
        if [[ -n "${dpkg_to_install[*]}" ]]; then
                sudo apt -y install ${dpkg_to_install[*]}
                pkg_check_fn
                unset dpkg_to_install
        fi
elif [[ "${archos_array[*]}" =~ "$os_releaseID" ]]; then
        sudo pacman -Syu
##
        declare -a arch_pkg_array_=( )
##
        while read -r line; do
                if ! pacman -Qi "$line" &> /dev/null
                        then arch_to_install+=( "$line" )
                fi
        done <<<$(printf '%s\n' "${arch_pkg_array_[@]}")
        unset arch_pkg_array_
        if [[ -n "${arch_to_install[*]}" ]]; then
                sudo pacman --noconfirm -Sy ${arch_to_install[*]}
                pkg_check_fn
                unset arch_to_install
        fi
else
        echo "$os_releaseID currently unsupported."
        exit 1
fi
