#!/usr/bin/env zsh
set -e

libdir=~/git/lib

cmake . \
	-DCMAKE_INSTALL_PREFIX="$1" \
	-DRUN_IN_PLACE=1 \
	-DBUILD_CLIENT=0 -DBUILD_SERVER=1 \
	-DENABLE_CURL=1 \
	-DENABLE_LEVELDB=1 \
	-DENABLE_GETTEXT=0 \
	-DENABLE_FREETYPE=0 \
	-DENABLE_SOUND=0 \
	-DLEVELDB_INCLUDE_DIR=$libdir/leveldb/include \
	-DLEVELDB_LIBRARY=$libdir/leveldb/libleveldb.so \
	-DCMAKE_BUILD_TYPE=Debug
	#-DCMAKE_CXX_FLAGS='-O3 -g' -DCMAKE_C_FLAGS='-O3' \

make -j3

