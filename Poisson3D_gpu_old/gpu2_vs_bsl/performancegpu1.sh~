#!/bin/bash
# 02614 - High-Performance Computing, January 2018
# 
# batch script to run collect on a decidated server in the hpcintro
# queue
#
# Author: Bernd Dammann <bd@cc.dtu.dk>
#
#BSUB -J collector
#BSUB -o compare.out
#BSUB -q hpcintrogpu
#BSUB -R "rusage[mem=2048]"
#BSUB -W 30
#BSUB -gpu "num=1"

for ((c=15; c<=150; c=c+10))
do
    echo $c
    jacobi_gpu1 $c 100 0 0
done 

