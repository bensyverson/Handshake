#!/bin/sh

brew install gnutls msgpack git cmake automake autoconf libtool
git clone https://github.com/savoirfairelinux/opendht.git
cd opendht
# the below needs to be tweaked
cmake -DOPENDHT_PYTHON=OFF -DOPENDHT_BUILD_TOOLS=OFF -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_LIBRARY_PATH=/usr/local/lib -DCMAKE_INCLUDE_PATH=/usr/local/include -G Xcode
