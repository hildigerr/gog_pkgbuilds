#!/bin/sh

cd "/opt/ziggurat/"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:./Ziggurat_Data/Plugins/
./Ziggurat $@
