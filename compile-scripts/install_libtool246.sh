wget https://ftpmirror.gnu.org/libtool/libtool-2.4.6.tar.gz
tar -zxvf libtool-2.4.6.tar.gz
cd libtool-2.4.6
./configure
make
# linux
sudo make install
libtool --version
# amzn
sudo ln -s /usr/local/bin/libtool /usr/bin/libtool
