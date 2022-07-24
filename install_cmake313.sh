#!/usr/bin/env bash
cmake_version=cmake-3.13.5
cmake_version2=v3.13
cmake_targz="${cmake_version}.tar.gz"
wget https://cmake.org/files/${cmake_version2}/${cmake_targz}
tar -zxvf  ${cmake_targz}
cd "${cmake_version}"
./configure
make 
# make install
# /usr/local/bin/cmake --version
# ln -s /usr/local/bin/cmake /usr/bin/
# cmake --version
