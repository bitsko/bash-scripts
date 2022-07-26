wget https://github.com/akheron/jansson/archive/refs/tags/v2.14.tar.gz
tar -zxvf v2.14.tar.gz
cd jansson-2.14
autoreconf -i
./configure 
make
sudo make install
