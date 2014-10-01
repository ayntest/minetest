#!/usr/bin/env zsh
set -e

libdir=~/git/lib

irrlicht_version=1.8.1
luajit_version=2.0.1
leveldb_version=1.15


# Get minetest
git_hash=`git show | head -c14 | tail -c7`

[[ ! -e $libdir ]] && mkdir $libdir
if [[ ! -d $libdir/luajit ]]; then
	git clone http://luajit.org/git/luajit-2.0.git $libdir/luajit
fi

cmake . \
	-DRUN_IN_PLACE=1 \
	-DCMAKE_CXX_FLAGS='-O3 -g' \
	-DBUILD_CLIENT=0 -DBUILD_SERVER=1 \
	\
	-DENABLE_SOUND=0 \
	-DENABLE_CURL=1 \
	-DENABLE_GETTEXT=0 \
	-DENABLE_FREETYPE=0 \
	-DENABLE_LEVELDB=1 \
	\
	-DLEVELDB_INCLUDE_DIR=$libdir/leveldb/include \
	-DLEVELDB_LIBRARY=$libdir/leveldb/libleveldb.so

make -j2

# EOF
