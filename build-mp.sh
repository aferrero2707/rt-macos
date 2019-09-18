#! /bin/bash

wd=$(pwd)

export BUILD_TYPE=Release
#cmake_opt='-DPROC_TARGET_NUMBER="1" -DPROC_LABEL="generic processor"       -DCACHE_NAME_SUFFIX="5-dev"       -DCMAKE_C_COMPILER="clang"       -DCMAKE_CXX_COMPILER="clang++"       -DWITH_LTO="ON"    -DCMAKE_OSX_SYSROOT="/" -DCMAKE_OSX_DEPLOYMENT_TARGET="10.9"  -DLENSFUNDBDIR="./share/lensfun" -DCMAKE_CXX_FLAGS="-std=c++11"'
cmake_opt='-DPROC_TARGET_NUMBER="1" -DPROC_LABEL="generic_processor" -DCACHE_NAME_SUFFIX="5-dev" -DCMAKE_C_COMPILER=clang-mp-8.0 -DCMAKE_CXX_COMPILER=clang++-mp-8.0 -DWITH_LTO="ON" -DCMAKE_OSX_DEPLOYMENT_TARGET="10.9"  -DLENSFUNDBDIR=./share/lensfun -DCMAKE_CXX_FLAGS="-Wno-deprecated-register -std=c++11"'

export PATH="/opt/local/bin:$PATH"
export LD_LIBRARY_PATH="/opt/local/lib:$LD_LIBRARY_PATH"
export PKG_CONFIG_PATH="/opt/local/lib/pkgconfig:$PKG_CONFIG_PATH"

export PATH="$wd/inst/bin:/Applications/CMake.app/Contents/bin:$PATH"
export LD_LIBRARY_PATH="$wd/inst/lib:$LD_LIBRARY_PATH"
export PKG_CONFIG_PATH="$wd/inst/lib/pkgconfig:$PKG_CONFIG_PATH"

sudo /opt/local/bin/port install librsvg clang-8.0 || exit 1
ls /opt/local/bin/clang*
#exit 0
which cmake

if [ ! -e RawTherapee ]; then
git clone https://github.com/Beep6581/RawTherapee.git --branch dev --single-branch --depth=1 || exit 1
fi

mkdir -p build || exit 1
cd build
rm -f CMakeCache.txt
cmake -DPROC_TARGET_NUMBER="1" -DPROC_LABEL="generic_processor" -DCACHE_NAME_SUFFIX="5-dev" \
  -DCMAKE_C_COMPILER=clang-mp-8.0 -DCMAKE_CXX_COMPILER=clang++-mp-8.0 \
  -DCMAKE_OSX_DEPLOYMENT_TARGET="10.9"  -DLENSFUNDBDIR=./share/lensfun \
  -DCMAKE_CXX_FLAGS="-Wno-deprecated-register -std=c++11" -DCMAKE_BUILD_TYPE=${BUILD_TYPE}  ../RawTherapee || exit 1
#make VERBOSE=1 
make VERBOSE=1 -j 3 || exit 1
make macosx_bundle || exit 1

