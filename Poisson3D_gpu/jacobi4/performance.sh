#!/bin/bash
# 02614 - High-Performance Computing, January 2018
# 
# batch script to run collect on a decidated server in the hpcintro
# queue
#
# Author: Bernd Dammann <bd@cc.dtu.dk>
#
#BSUB -J collector
#BSUB -o compare_tolerance2.out
#BSUB -q hpcintrogpu
#BSUB -R "rusage[mem=2048]"
#BSUB -W 30
#BSUB -gpu "num=1"

for ((c=50; c<=1000; c=c+50))
do
    echo $c
    echo "Second Version"
    jacobi_gpu43 $c 100 0 5 0
    echo "Third Version"
    jacobi_gpu44 $c 100 0 5 0
done 

