#!/bin/bash
# 02614 - High-Performance Computing, January 2018
# 
# batch script to run matmult on a decidated server in the hpcintro
# queue
#
# Author: Bernd Dammann <bd@cc.dtu.dk>
#
#BSUB -J mm_batch
#BSUB -o mm_batch_%J.out
#BSUB -q hpcintro
#BSUB -n 1
#BSUB -R "rusage[mem=2048]"
#BSUB -W 15

# define the driver name to use
# valid values: matmult_c.studio, matmult_f.studio, matmult_c.gcc or
# matmult_f.gcc
#

EXECUTABLE="matmult_f.nvcc"

# define the mkn values in the MKN variable
#
SIZES="100 150 200 250 500 750 1000 1500 2000"

# define the permutation type in PERM
#
PERM="gpu1"

# uncomment and set a reasonable BLKSIZE for the blk version
#
# BLKSIZE=1

# enable(1)/disable(0) result checking
export MATMULT_COMPARE=0
export MFLOPS_MAX_IT=1
export MKL_NUM_THREADS=1

rm -f ./$PERM.out

# start the collect command with the above settings
for S in $SIZES
do
    ./$EXECUTABLE $PERM $S $S $S $BLKSIZE >> ./$PERM.out
done
