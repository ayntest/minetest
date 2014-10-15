#!/usr/bin/env bash
set -e

cmake . \
	-DCMAKE_CXX_FLAGS='-O3' \
	-DRUN_IN_PLACE=0 \
	-DBUILD_SERVER=0 \
	-DBUILD_CLIENT=1 \
	-DENABLE_FREETYPE=1 \
	-DENABLE_CURL=1 \
	-DENABLE_GETTEXT=0 \
	-DENABLE_SOUND=1 \
	-DENABLE_LEVELDB=1 \
	-DENABLE_REDIS=0 \
	-DIRRLICHT_SOURCE_DIR=~/git/irrlicht/sources \
	-DIRRLICHT_INCLUDE_DIR=~/git/irrlicht/include \
	-DIRRLICHT_LIBRARY=~/git/irrlicht/lib/Linux/libIrrlicht.a \

/usr/bin/time make -j3
sudo checkinstall -y \
	--type debian \
	--fstrans=yes \
	--pkgname minetest \
	--pakdir /tmp \
	--requires libc6 \
	--requires libgcc1 \
	--exclude /home \
	--nodoc \
	--backup=no
