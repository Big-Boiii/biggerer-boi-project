#!/bin/bash
# 02614 - High-Performance Computing, January 2018
# 
# batch script to run matmult on a decidated server in the hpcintro
# queue
#
# Author: Bernd Dammann <bd@cc.dtu.dk>
#
#BSUB -J yorch_times
#BSUB -o yorch_times_%J.out
#BSUB -q hpcintrogpu
#BSUB -gpu "num=1"
###:mode=exclusive_process"
#BSUB -W 15
#BSUB -R "rusage[mem=2048]"
#BSUB -N

# define the driver name to use
# valid values: matmult_c.studio, matmult_f.studio, matmult_c.gcc or
# matmult_f.gcc
#

EXECUTABLE="matmult_f.nvcc"

# define the mkn values in the MKN variable
#
SIZES="100 150 200 250 500 750 1000" #1500 2000"

# define the function type in FUNC
#
FUNC="lib gpu1"
OUT="times_1.out"

# uncomment and set a reasonable BLKSIZE for the blk version
#
# BLKSIZE=1

# enable(1)/disable(0) result checking
#export CUDA_VISIBLE_DEVICES=1
export MATMULT_COMPARE=1
export MFLOPS_MAX_IT=5
export MKL_NUM_THREADS=1

rm -f ./$OUT

# start the collect command with the above settings
for F in $FUNC
do
    for S in $SIZES
    do
        echo "Library: $F. Size: $S." >> ./$OUT
        ./$EXECUTABLE $F $S $S $S $BLKSIZE >> ./$OUT
        echo "" >> ./$OUT
    done
done

for F in $FUNC
do 
    rm -f ./$F.out
    grep "matmult_$F" $OUT >> ./$F.out
done
