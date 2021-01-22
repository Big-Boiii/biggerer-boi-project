#!/bin/gnuplot

set terminal png enhanced size 1600,900
set output 'matmult_gpu2.png'

# set multiplot layout 1,2 #title "Beautiful plots"

set xlabel "Memory footprint (Kbyte)"
set logscale x
set logscale y
set for [i=3:9] xtics(0,2**(2*i))
set ylabel "Mflop/s"
set title "Performance comparison"
plot "lib2.out" using 1:2 title "CPU" with lp, "gpu1.out" using 1:2 title "GPU1" with lp, "gpu2.out" using 1:2 title "GPU2" with lp


# set ylabel"Secs"
# set title "Runtime comparison"
# plot "aos_output" using 1:5 title "Array of structures" with lp, "soa_output" using 1:5 title "Structure of arrays" with lp

# unset multiplot

#pause mouse close
# This last line is to avoid the terminal to close 
# when you are not outputting to a file
