#include <stdio.h>

__global__ void cuda_hello(){
//	printf("Hello\n");
	printf("Hello from Thread %d out of %d in block %d.\n  The ThreadID is %d of %d. \n", threadIdx.x +1, blockDim.x, blockIdx.x, threadIdx.x + (blockIdx.x*blockDim.x), 2*blockDim.x);



}

int main(){

	cuda_hello<<<8,2>>>();
	cudaDeviceSynchronize();
	return 0;
}
