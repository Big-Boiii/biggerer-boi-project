#!/bin/bash

#BSUB -q hpcintro 
#BSUB -W 30
#BSUB -n 24 

for((j=25; j<=425; j=j+25))
    do
	echo "Size" $j
	echo "Threads" $i
	time OMP_NUM_THREADS=16 ./poisson_j $j 100 0 0 
    done
done
