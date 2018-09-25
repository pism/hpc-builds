#!/bin/bash


prefix=${HOME}/local/
N=4

branch=${1}
dbg=$2

PISM_DIR=${HOME}/local/pism-${branch}-${dgb}

build_pism() {
    set -e
    set -x
    mkdir -p $PISM_DIR/sources
    cd $PISM_DIR/sources

    git clone --depth 1 -b ${branch} https://github.com/pism/pism.git . || git pull

    rm -rf build
    mkdir -p build
    cd build

    export PETSC_DIR=~/local/petsc/petsc-3.10.0/
    
    export PETSC_ARCH=${dbg}-32bit

    CC=mpicc CXX=mpicxx cmake \
        -DCMAKE_BUILD_TYPE=$1 \
        -DCMAKE_INSTALL_PREFIX=${PISM_DIR} \
        -DPism_LOOK_FOR_LIBRARIES=YES \
        -DPism_BUILD_DOCS=YES \
        -DPism_PYTHON_BINDINGS=YES \
        -DPism_USE_PROJ4=YES \
        ${PISM_DIR}/sources

    make -j $N install    
    set +x
    set +e
    
}

build_pism $1 $2
