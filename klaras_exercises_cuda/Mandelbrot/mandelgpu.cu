#include <stdio.h>

__global__ void mandelgpu(int disp_width, int disp_height, int *array, int max_iter) {

    double 	scale_real, scale_imag;
    double 	x, y, u, v, u2, v2;
    int 	row,column, iter;
    column = threadIdx.y + blockIdx.y*blockDim.y;
    row= threadIdx.x + blockIdx.x*blockDim.x;	     

    scale_real = 3.5 / (double)disp_width;
    scale_imag = 3.5 / (double)disp_height;

    x = (column * scale_real) - 2.25; 
    y = (row * scale_imag) - 1.75; 

    u    = 0.0;
    v    = 0.0;
    u2   = 0.0;
    v2   = 0.0;
    iter = 0;

    while ( u2 + v2 < 4.0 &&  iter < max_iter ) {
	v = 2 * v * u + y;
	u = u2 - v2 + x;
	u2 = u*u;
	v2 = v*v;
	iter = iter + 1;
	}

    // if we exceed max_iter, reset to zero
    iter = iter == max_iter ? 0 : iter;
    //printf("This is Thread %d and Block %d. \n The value for this Cell is %d. \n", column, row, iter);
    array[row*disp_height + column] = iter;
}
