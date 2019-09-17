#! /bin/bash

wd=$(pwd)

export BUILD_TYPE=Release
cmake_opt=""

export PATH="/opt/local/bin:$PATH"
export LD_LIBRARY_PATH="/opt/local/lib:$LD_LIBRARY_PATH"
export PKG_CONFIG_PATH="/opt/local/lib/pkgconfig:$PKG_CONFIG_PATH"

export PATH="$wd/inst/bin:/Applications/CMake.app/Contents/bin:$PATH"
export LD_LIBRARY_PATH="$wd/inst/lib:$LD_LIBRARY_PATH"
export PKG_CONFIG_PATH="$wd/inst/lib/pkgconfig:$PKG_CONFIG_PATH"

sudo /opt/local/bin/port install librsvg || exit 1
which cmake

if [ ! -e RawTherapee ]; then
git clone https://github.com/Beep6581/RawTherapee.git --branch dev --single-branch --depth=1 || exit 1
fi

mkdir -p build || exit 1
cd build
rm -f CMakeCache.txt
cmake $cmake_opt -DCMAKE_BUILD_TYPE=${BUILD_TYPE}  ../RawTherapee || exit 1
#make VERBOSE=1
make -j 3 || exit 1
make macosx_bundle || exit 1

