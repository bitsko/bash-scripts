#!/usr/bin/env bash
heads=0
tails=0
if [[ -z "$1" ]]; then
        read -r -p "how many times"$'\n>' count
else
        count="$1"
fi
flipcount=0
echo "flipping the coin"
sleep 1
while true; do
        flip=$((RANDOM % 2))
        if [[ "$flip" == 0 ]];then
                heads=$((heads+1))
        elif [[ "$flip" == 1 ]]; then
                tails=$((tails+1))
        fi
        flipcount=$((flipcount+1))
        echo -e "\e[1A\e[Kheads/tails: $heads/$tails"
        if [[ "$flipcount" == "$count" ]]; then exit 0; fi
done
