#!/bin/bash

/home/shady/host/install/bin/qt-cmake -B ddHostBuild .
cd ddHostBuild
cmake --build . --parallel $(nproc)
cmake install .
