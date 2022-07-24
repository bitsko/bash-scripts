git clone https://github.com/stedolan/jq.git
cd jq
git submodule update --init
autoreconf -fi
./configure --with-oniguruma=builtin
make LDFLAGS=-all-static
make check
sudo make install
