# jqs - jq stripper 

for easy output stripping such as with arrays

#example: woc_height 700000 | jqs .tx | sed 's/null//g' | sed '/^$/d'
#ncli getblockbyheight 1 | jqs .tx
