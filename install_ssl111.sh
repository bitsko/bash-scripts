# https://gist.github.com/fernandoaleman/5459173e24d59b45ae2cfc618e20fe06
yum -y update
yum install -y make gcc perl-core pcre-devel wget zlib-devel
wget https://ftp.openssl.org/source/openssl-1.1.1k.tar.gz
tar -xzvf openssl-1.1.1k.tar.gz
cd openssl-1.1.1k
./config --prefix=$PWD/ssl111 --openssldir=$PWD/ssl111 --libdir=$PWD/ssl111 no-shared zlib-dynamic
# ./config --prefix=/usr --openssldir=/etc/ssl --libdir=lib no-shared zlib-dynamic
make
make test
make install
# vim /etc/profile.d/openssl.sh
# Add the following content
export LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64
source /etc/profile.d/openssl.sh
openssl version
