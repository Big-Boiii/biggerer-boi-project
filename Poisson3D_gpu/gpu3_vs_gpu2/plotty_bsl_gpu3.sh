#!/bin/gnuplot

set terminal png enhanced size 1000,600
set output 'bsl_gpu2_copy.png'


set xlabel "Matrix Size (N)"
set logscale x
#set xtics [1:16]
#set ytics [1:16]
set ylabel "Time"
set title "Compare Times with and without data transmission"
plot "small_data" using 1:3 title "no-copy" with lp,\
     "small_data" using 1:4 title "copy" with lp

     


#pause mouse close
# This last line is to avoid the terminal to close 
# when you are not outputting to a file

