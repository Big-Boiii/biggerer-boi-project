extern "C"{

#include <stdio.h>

__global__ 
void
matmultgpu1(int m, int n, int k, double *A, double *B, double *C) {
    	
    int tid=blockIdx.x*blockDim.x+threadIdx.x;

    int i1,i2,i3;

    //printf("to thread einai %d\n",tid);
    
    for(i1 = 0; i1< m; i1++){
    	for(i2 = 0; i2 < n; i2++){    
             C[i1*n+i2]=0;        
	    for(i3 = 0; i3 < k; i3++){ 
		C[i1*n+i2]+=A[i1*k+i3]*B[i3*n+i2];
	     }
        }
    }
	
}



void matmult_gpu1(int m, int n, int k, double *A, double *B, double *C){

  double   *d_A,*d_B,*d_C;

  int sizeA=m * k *sizeof(double);
  int sizeB=k * n *sizeof(double);
  int sizeC=m * n *sizeof(double);
 

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
   dimgGrid.x=1;
   dimgGrid.y=1;
*/
   

//  matmultgpu1<<<dimgGrid,dimBlock>>>(m,n,k,d_A,d_B,d_C);
  matmultgpu1<<<1,1>>>(m,n,k,d_A,d_B,d_C);
  cudaDeviceSynchronize();

  cudaMemcpy(A,d_A,sizeA,cudaMemcpyDeviceToHost);
  cudaMemcpy(B,d_B,sizeB,cudaMemcpyDeviceToHost);
  cudaMemcpy(C,d_C,sizeC,cudaMemcpyDeviceToHost);
  
  cudaFree(d_A);
  cudaFree(d_B);
  cudaFree(d_C);



}
}

