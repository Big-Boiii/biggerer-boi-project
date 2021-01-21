extern "C"
{

#include <stdio.h>

#define BLOCK_SIZE 16

__global__ 
void
matmultgpu2(int m, int n, int k, double *A, double *B, double *C) {
    	
  double Cvalue = 0.0;

  int col = blockIdx.x*blockDim.x+threadIdx.x;
  int row = blockIdx.y*blockDim.y+threadIdx.y;
  
  int e;

  if (row < m && col < n) {
    for(e=0;e<k;++e)
        Cvalue += A[row*k+e] * B[e*n+col];
        
    C[row*n+col] = Cvalue;
  }
	
}



void matmult_gpu2(int m, int n, int k, double *A, double *B, double *C){

  double *d_A, *d_B, *d_C;


  int sizeA = m * k *sizeof(double);
  int sizeB = k * n *sizeof(double);
  int sizeC = m * n *sizeof(double);

  // Allocate memory on the device
  cudaMalloc((void**)&d_A, sizeA);
  cudaMalloc((void**)&d_B, sizeB);
  cudaMalloc((void**)&d_C, sizeC);

  // Copy the values over
  cudaMemcpy(d_A, A, sizeA, cudaMemcpyHostToDevice);
  cudaMemcpy(d_B, B, sizeB, cudaMemcpyHostToDevice);

  // Declare the number of threads
  dim3 numOfThreadsPerBlock;
  numOfThreadsPerBlock.x = BLOCK_SIZE;
  numOfThreadsPerBlock.y = BLOCK_SIZE;

  dim3 numOfBlocks;
  numOfBlocks.x = (n+numOfThreadsPerBlock.x-1)/(numOfThreadsPerBlock.x);
  numOfBlocks.y = (m+numOfThreadsPerBlock.x-1)/(numOfThreadsPerBlock.y);


  matmultgpu2<<<numOfBlocks, numOfThreadsPerBlock>>>(m, n, k, d_A, d_B, d_C);
  cudaDeviceSynchronize();

  cudaMemcpy(C, d_C, sizeC, cudaMemcpyDeviceToHost);

  cudaFree(d_A);
  cudaFree(d_B);
  cudaFree(d_C);
}
}

