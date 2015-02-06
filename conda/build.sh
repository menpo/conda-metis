#!/bin/bash

cp -r "$RECIPE_DIR/../" .

mkdir build

cd build

# Create the static libraries
cmake .. \
-DCMAKE_INSTALL_PREFIX=$PREFIX \
-DGKLIB_PATH="../GKlib" \
-DSHARED=0

make -j$CPU_COUNT
make install

# Create the shared libraries
cmake .. \
-DCMAKE_INSTALL_PREFIX=$PREFIX \
-DGKLIB_PATH="../GKlib" \
-DSHARED=1

make -j$CPU_COUNT
make install
