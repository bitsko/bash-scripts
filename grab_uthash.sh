#!/usr/bin/env bash

# wget -q --show-progress https://raw.githubusercontent.com/troydhanson/uthash/master/src/{utarray.h,uthash.h,utlist.h,utringbuffer.h,utstack.h,utstring.h}
# sudo cp {utarray.h,uthash.h,utlist.h,utringbuffer.h,utstack.h,utstring.h} /usr/local/include

uthashurl="https://raw.githubusercontent.com/troydhanson/uthash/master/src/"
wget_version=$(wget --version | head -n 1 | cut -d ' ' -f 3 | cut -c -4)
if (( $(echo "$wget_version >= 1.16" | bc -l) )); then
	wget -q --show-progress \
	${uthashurl}{utarray.h,uthash.h,utlist.h,utringbuffer.h,utstack.h,utstring.h}
else
  	wget ${uthashurl}{utarray.h,uthash.h,utlist.h,utringbuffer.h,utstack.h,utstring.h}
fi
sudo cp {utarray.h,uthash.h,utlist.h,utringbuffer.h,utstack.h,utstring.h} /usr/local/include
