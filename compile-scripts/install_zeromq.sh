apt-get install git
apt-get install cmake
git clone https://github.com/zeromq/libzmq
cd libzmq 
mkdir cmake-build && cd cmake-build
cmake .. && make 
make test && make install && sudo ldconfig
