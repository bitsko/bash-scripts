sudo apt update
declare -a deb_pkg_array=( build-essential git cmake pkg-config \
        libtool autoconf autogen automake libboost-chrono-dev wget \
        libminiupnpc-dev libssl-dev libzmq3-dev help2man ninja-build libdb-dev \
        libdb++-dev libqrencode-dev libcurl4-openssl-dev libncurses-dev python3 \
        libboost-filesystem-dev libboost-test-dev libboost-thread-dev libevent-dev )
while read -r line; do
        if ! dpkg -s "$line" &> /dev/null
                then sudo apt install "$line"
        fi
done <<<$(printf '%s\n' "${deb_pkg_array[@]}")
