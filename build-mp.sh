#! /bin/bash

wd=$(pwd)

export BUILD_TYPE=RelWithDebInfo
cmake_opt=""

export PATH="/opt/local/bin:$PATH"
export LD_LIBRARY_PATH="/opt/local/lib:$LD_LIBRARY_PATH"
export PKG_CONFIG_PATH="/opt/local/lib/pkgconfig:$PKG_CONFIG_PATH"

export PATH="$wd/inst/bin:/Applications/CMake.app/Contents/bin:$PATH"
export LD_LIBRARY_PATH="$wd/inst/lib:$LD_LIBRARY_PATH"
export PKG_CONFIG_PATH="$wd/inst/lib/pkgconfig:$PKG_CONFIG_PATH"

# needs: 
# gtk3 +quartz
# gtkmm3 fftw-3-single libiptcdata lensfun lcms2 expat libtiff libjpeg libpng zlib gtk-osx-application-gtk3


which cmake

if [ ! -e RawTherapee ]; then
git clone https://github.com/Beep6581/RawTherapee.git --branch dev --single-branch --depth=1
fi

mkdir -p build
cd build
rm -f CMakeCache.txt
cmake $cmake_opt -DCMAKE_BUILD_TYPE=${BUILD_TYPE}  ../RawTherapee
#make VERBOSE=1
make -j 3

cd ..

