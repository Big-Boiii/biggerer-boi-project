#include <stdio.h>
#include <stdlib.h>
#include "mandel.h"
#include "mandelgpu.h"
#include "writepng.h"
#include <omp.h>



int
main(int argc, char *argv[]) {

    int   width, height;
    int	  max_iter;
    int   *image_d;
    int   *image_h;

    width    = 5000;
    height   = 5000;
    max_iter = 400;

    // command line argument sets the dimensions of the image
    if ( argc == 2 ) width = height = atoi(argv[1]);

    
    image_h = (int *)malloc( width * height * sizeof(int));
    cudaMalloc((void**)&image_d, width*height*sizeof(int));
    if ( image_h == NULL ) {
       fprintf(stderr, "memory allocation failed!\n");
       return(1);
    }
    //launch kernel
    dim3 block_size(10, 10);
    dim3 grid_size(width/block_size.x, height/ block_size.y);
    mandelgpu<<<grid_size,block_size>>>(width, height, image_d, max_iter);
    //mandel(width,height,image_h,max_iter);
    cudaDeviceSynchronize();
    //copy results back
    cudaMemcpy(image_h,image_d,width*height*sizeof(int), cudaMemcpyDeviceToHost);
    writepng("mandelbrot.png", image_h, width, height);

    //cleanup results:
    cudaFree(image_d);
    free(image_h);

    return(0);
}
