#!/bin/bash

MPIEXEC="/home/guido/libs/openmpi-install/bin/mpiexec" 
EXECUTABLE="/home/guido/codes/sputnik/macro/macro"

if [ -d "direct/force_x" ]; then
  rm -rf direct/force_x/*
else
  mkdir direct/force_x
fi

$MPIEXEC -np 1 $EXECUTABLE  \
    -boundary "X0 11 0 0","X1 11 1 0" \
    -material "MATRIX MAT_ELASTIC 1.0e7 1.0e6 0.3","FIBER MAT_ELASTIC 1.0e7 1.0e7 0.3"\
    -function "0 2 0.0 0.0 1.0 0.0","1 2 0.0 0.0 1.0 0.01" \
    -mesh direct/direct_10_10_replaced.msh \
    -dim 2 \
    -normal \
    -tf 1.0 \
    -dt 0.2 \
    -pc_type lu \
    -nnz_factor 3 \
    -print_pvtu

mv macro_* direct/force_x/.

if [ -d "direct/force_y" ]; then
  rm -rf direct/force_y/*
else
  mkdir direct/force_y
fi

$MPIEXEC -np 1 $EXECUTABLE  \
    -boundary "X0 11 0 0","X1 11 0 1" \
    -material "MATRIX MAT_ELASTIC 1.0e7 1.0e6 0.3","FIBER MAT_ELASTIC 1.0e7 1.0e7 0.3"\
    -function "0 2 0.0 0.0 1.0 0.0","1 2 0.0 0.0 1.0 -0.01" \
    -mesh direct/direct_10_10_replaced.msh \
    -dim 2 \
    -normal 1 \
    -tf 1.0 \
    -dt 0.2 \
    -pc_type lu \
    -print_pvtu

mv macro_* direct/force_y/.

em=(1.0e5 2.0e5 3.0e5 4.0e5 5.0e5 6.0e5 7.0e5 8.0e5 9.0e5 1.0e6 1.5e6 2.0e6 2.5e6 3.0e6)

rm -rf em_values.dat
for i in `seq 0 $((${#em[@]} - 1))`; do 

echo "${em[$i]} " >> em_values.dat

if [ -d "direct/eigen_$i" ]; then
  rm -rf direct/eigen_$i/*
else
  mkdir direct/eigen_$i
fi

echo ${em[$i]}

$MPIEXEC -np 1 $EXECUTABLE  \
    -boundary "X0 11 0 0","X1 11 0 1" \
    -material "MATRIX MAT_ELASTIC 1.0e7 1.0e6 0.3","FIBER MAT_ELASTIC 1.0e7 ${em[$i]} 0.3"\
    -function "0 2 0.0 0.0 1.0 0.0","1 2 0.0 0.0 1.0 -0.01" \
    -mesh direct/direct_10_10_replaced.msh \
    -dim 2 \
    -eigen \
    -eps_nev 2 \
    -pc_type lu \
    -print_pvtu > direct/eigen_$i/eigen_$i.dat

mv macro_* direct/eigen_$i/.

done
