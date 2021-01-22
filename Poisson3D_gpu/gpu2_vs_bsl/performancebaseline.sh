#!/bin/bash
# 02614 - High-Performance Computing, January 2018
# 
# batch script to run collect on a decidated server in the hpcintro
# queue
#
# Author: Bernd Dammann <bd@cc.dtu.dk>
#
#BSUB -J collectorgpu2
#BSUB -o comparewfklweflkjd.out
#BSUB -q hpcintro
#BSUB -R "rusage[mem=2048]"
#BSUB -W 30

for ((c=25; c<=425; c=c+25))
do
    echo $c
    echo "Baseline"
    jacobi_bsln $c 100 0 0

done 

