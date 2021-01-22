#!/bin/bash
# 02614 - High-Performance Computing, January 2018
# 
# batch script to run collect on a decidated server in the hpcintro
# queue
#
# Author: Bernd Dammann <bd@cc.dtu.dk>
#
#BSUB -J collectorgpu2
#BSUB -o compare.out
#BSUB -q hpcintrogpu
#BSUB -R "rusage[mem=2048]"
#BSUB -W 30
#BSUB -gpu "num=1"

for ((c=25; c<=1000; c=c+25))
do
    echo $c
    echo "Baseline"
    jacobi_bsln $c 100 0 0
    echo "gpu2"
    jacobi_gpu2 $c 100 0 0
done 

