#!/bin/bash

#BSUB -q hpcintro 
#BSUB -W 30
#BSUB -n 24
#BSUM -o big_mlth.out 

for((j=100; j<=1500; j=j+100))
    do
	echo "Size" $j
	echo "Threads" $i
	time OMP_NUM_THREADS=16 ./poisson_j $j 100 0 0 
    done
done
