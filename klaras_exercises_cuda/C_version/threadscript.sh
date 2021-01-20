#!/bin/bash

time OMP_NUM_THREADS=1 ./mandelbrot 5000
time OMP_NUM_THREADS=2 ./mandelbrot 5000
time OMP_NUM_THREADS=4 ./mandelbrot 5000

