#!/bin/gnuplot

set terminal png enhanced size 1000,600
set output 'sum_reductions.png'


set xlabel "Memory Footprint (KByte)"
#set xtics [1:16]
#set ytics [1:16]
set ylabel "MFlop/s"
set title "Compare Performance of different Sum Reductions"
plot "sum_reduction_data" using (($1*$1*$1*8)/1000):((($1-1)*($1-1)*($1-1)*9*100)/(1000000*$2))  title "atomicAdd" with lp,\
     "sum_reduction_data" using (($1*$1*$1*8)/1000):((($1-1)*($1-1)*($1-1)*9*100)/(1000000*$3)) title "warpReduction" with lp,\
     "sum_reduction_data" using (($1*$1*$1*8)/1000):((($1-1)*($1-1)*($1-1)*9*100)/(1000000*$4)) title "blockReduction" with lp

     


#pause mouse close
# This last line is to avoid the terminal to close 
# when you are not outputting to a file

