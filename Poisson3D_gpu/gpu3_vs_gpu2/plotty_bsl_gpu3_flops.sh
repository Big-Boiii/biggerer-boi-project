#!/bin/gnuplot

set terminal png enhanced size 1000,600
set output 'bsl_gpu3_flops.png'


set xlabel "Memory Footprint (KByte)"
set logscale x
#set xtics [1:16]
#set ytics [1:16]
set ylabel "MFlop/s"
set title "Compare Performance of Baseline and Multi-Threaded GPU"
plot "small_data" using (($1*$1*$1*8)/1000):((($1-1)*($1-1)*($1-1)*9*100)/(1000000*$5))title "baseline" with lp,\
     "small_data" using (($1*$1*$1*8)/1000):((($1-1)*($1-1)*($1-1)*9*100)/(1000000*$6)) title "gpu2" with lp

     


#pause mouse close
# This last line is to avoid the terminal to close 
# when you are not outputting to a file

