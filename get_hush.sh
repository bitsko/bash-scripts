#!/usr/bin/env bash
# https://github.com/hush-shell/hush

hshVer="v0.1.2-alpha"
hshDir="hush-0.1.2-x86_64"
hshFil="$hshDir".tar.gz
hsh_Dl="hush-shell/hush/releases/download"

printf '%s\n' "getting hush"

wget https://github.com/"$hsh_Dl"/"$hshVer"/"$hshFil" &>/dev/null

tar -zxvf "$hshFil" &>/dev/null

./hush --version
./hush<<<'std.print("Hello World!")'
