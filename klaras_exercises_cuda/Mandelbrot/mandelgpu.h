#ifndef __MANDEL_D
#define __MANDEL_D

__global__ void mandelgpu(int width, int height, int *image, int max_iter);

#endif
