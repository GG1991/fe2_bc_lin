#!/bin/bash

python extract_data.py

num_files=$( wc -l em_values.dat | awk '{print $1}' )

rm -rf omega.dat omega_direct_0.dat
for i in $(seq 0 $((num_files - 1))); do
awk '/omega 0/{print $4} ' direct/eigen_$i/eigen_$i.dat >> omega.dat
done
paste em_values.dat omega.dat > omega_direct_0.dat

rm -rf omega.dat omega_direct_1.dat
for i in $(seq 0 $((num_files - 1))); do
awk '/omega 1/{print $4} ' direct/eigen_$i/eigen_$i.dat >> omega.dat
done
paste em_values.dat omega.dat > omega_direct_1.dat

rm -rf omega.dat omega_us_0.dat
for i in $(seq 0 $((num_files - 1))); do
awk '/omega 0/{print $4} ' homog/us/eigen_$i/eigen_$i.dat >> omega.dat
done
paste em_values.dat omega.dat > omega_us_0.dat

rm -rf omega.dat omega_us_1.dat
for i in $(seq 0 $((num_files - 1))); do
awk '/omega 1/{print $4} ' homog/us/eigen_$i/eigen_$i.dat >> omega.dat
done
paste em_values.dat omega.dat > omega_us_1.dat

rm -rf omega.dat omega_tp_0.dat
for i in $(seq 0 $((num_files - 1))); do
awk '/omega 0/{print $4} ' homog/tp/eigen_$i/eigen_$i.dat >> omega.dat
done
paste em_values.dat omega.dat > omega_tp_0.dat

rm -rf omega.dat omega_tp_1.dat
for i in $(seq 0 $((num_files - 1))); do
awk '/omega 1/{print $4} ' homog/tp/eigen_$i/eigen_$i.dat >> omega.dat
done
paste em_values.dat omega.dat > omega_tp_1.dat

rm -rf omega.dat omega_ts_0.dat
for i in $(seq 0 $((num_files - 1))); do
awk '/omega 0/{print $4} ' homog/ts/eigen_$i/eigen_$i.dat >> omega.dat
done
paste em_values.dat omega.dat > omega_ts_0.dat

rm -rf omega.dat omega_ts_1.dat
for i in $(seq 0 $((num_files - 1))); do
awk '/omega 1/{print $4} ' homog/ts/eigen_$i/eigen_$i.dat >> omega.dat
done
paste em_values.dat omega.dat > omega_ts_1.dat
