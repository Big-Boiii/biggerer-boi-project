extern "C"{

#include <stdio.h>

#define BLOCK_SIZE 1

__global__ 
void
matmultgpu2(int m, int n, int k, double *A, double *B, double *C) {
    	
 float Cvalue=0;

  int col=blockIdx.x*blockDim.x+threadIdx.x;
  int row=blockIdx.y*blockDim.y+threadIdx.y;
  
  int e;
  for(e=0;e<k;++e)
      Cvalue+=A[row*k+e]*B[e*n+col];
  C[row*n+col]=Cvalue;
	
}



void matmult_gpu2(int m, int n, int k, double *A, double *B, double *C){

  double   *h_A,*h_B,*h_C,*d_A,*d_B,*d_C;
   
    
    int sizeA=m * k *sizeof(double);
    int sizeB=k * n *sizeof(double);
    int sizeC=m * n *sizeof(double);
 

    

    cudaMallocHost((void**)&h_A,sizeA);
    cudaMallocHost((void**)&h_B,sizeB);
    cudaMallocHost((void**)&h_C,sizeC);

 

  //Alloc memory on the device
  cudaMalloc((void**)&d_A,sizeA);
  cudaMalloc((void**)&d_B,sizeB);
  cudaMalloc((void**)&d_C,sizeC);

  cudaMemcpy(d_A,A,sizeA,cudaMemcpyHostToDevice);
  cudaMemcpy(d_B,B,sizeB,cudaMemcpyHostToDevice);

/*
 dim3 dimBlock;
 dimBlock.x=1;
 dimBlock.y=1;



  dim3 dimgGrid;
  

   // dimgGrid.x=(int)ceil((float)n/dimBlock.x);
   // dimgGrid.y=(int)ceil((float)m/dimBlock.y);
  dimgGrid.x=(int)ceil((float)(n+dimBlock.x-1)/dimBlock.x);
  dimgGrid.y=(int)ceil((float)(m+dimBlock.y-1)/dimBlock.y);
   	
 // dimgGrid.x=n;
//  dimgGrid.y=m;

  matmultgpu2<<<dimgGrid,dimBlock>>>(m,n,k,d_A,d_B,d_C);
*/

  dim3 numOfThreadsPerBlock;
  numOfThreadsPerBlock.x=BLOCK_SIZE;
  numOfThreadsPerBlock.y=BLOCK_SIZE;



  dim3 numOfBlocks;
  //numOfBlocks.x=(int)ceil((float)(n-numOfThreadsPerBlock.x-1)/numOfThreadsPerBlock.x);
  //numOfBlocks.y=(int)ceil((float)(m-numOfThreadsPerBlock.y-1)/numOfThreadsPerBlock.y);

/*
 numOfBlocks.x=(n+numOfThreadsPerBlock.x-1)/(numOfThreadsPerBlock.x);
  numOfBlocks.y=(m+numOfThreadsPerBlock.x-1)/(numOfThreadsPerBlock.y);

*/

 numOfBlocks.x=(n)/(numOfThreadsPerBlock.x);
  numOfBlocks.y=(m)/(numOfThreadsPerBlock.y);
  matmultgpu2<<<numOfBlocks,numOfThreadsPerBlock>>>(m,n,k,d_A,d_B,d_C);
  cudaDeviceSynchronize();

  cudaMemcpy(A,d_A,sizeA,cudaMemcpyDeviceToHost);
  cudaMemcpy(B,d_B,sizeB,cudaMemcpyDeviceToHost);
  cudaMemcpy(C,d_C,sizeC,cudaMemcpyDeviceToHost);
  
  cudaFree(d_A);
  cudaFree(d_B);
  cudaFree(d_C);



}
}

