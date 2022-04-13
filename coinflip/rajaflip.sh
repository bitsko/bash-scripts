#!/usr/bin/env bash
#https://sudeepraja.github.io/Hello-World/
if [[ -z $(command -v bc) ]]; then echo "install bc"; exit 1; fi
echo ""
if [[ -z "$1" ]]; then
        read -r -p "how many fair coins to flip?"$'\n>' coinCount
else
        coinCount="$1"
fi
heads=0
tails=0
flipcount=0
while true; do
        flip=$((RANDOM % 2))
        if [[ "$flip" == 0 ]];then
                heads=$((heads+1))
        elif [[ "$flip" == 1 ]]; then
                tails=$((tails+1))
        fi
        flipcount=$((flipcount+1))
        echo -e "\e[1A\e[Kheads/tails: $heads/$tails"
        if [[ "$flipcount" == "$coinCount" ]]; then break; fi
done
totalHeads="$heads"
totalTails="$tails"
totalRounds=1
while true; do
        echo "heads/tails $heads/$tails"
                coinCount="$tails"
        flipcount=0
        heads=0
        tails=0
        while true; do
                flip=$((RANDOM % 2))
                if [[ "$flip" == 0 ]];then
                        heads=$((heads+1))
                elif [[ "$flip" == 1 ]]; then
                        tails=$((tails+1))
                fi
                flipcount=$((flipcount+1))
                echo -e "\e[1A\e[Kheads/tails: $heads/$tails"
                if [[ "$flipcount" == "$coinCount" ]]; then break; fi
        done
        totalHeads=$((totalHeads+heads))
        totalTails=$((totalTails+tails))
        totalRounds=$((totalRounds+1))
        if [[ "$tails" == "0" ]]; then break; fi
done
echo "Total rounds: $totalRounds"
echo "Total Heads: $totalHeads"
echo "Total Tails: $totalTails"
headsratio=$(bc -l<<<"$totalHeads / $totalTails")
tailsratio=$(bc -l<<<"$totalTails / $totalHeads")
echo "ratio of $headsratio to $tailsratio"
score=$(bc -l<<<"$headsratio - $tailsratio")
echo "score $score"
