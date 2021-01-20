#include <stdio.h>
#include <stdlib.h>
#include "mxv.h"

void print_matrix(int n, int k, double **C){
    for (int i=0; i<n; i++){
        for (int j=0; j<k; j++){
            printf("%lf \t", C[i][j]);
        }
        printf("\n");
    }
}

void print_vector(int m, double*B){
	for (int i=0; i<m; i++){
		printf("%lf \n", B[i]);
	}
}


double * allocate_vector(int m){
	double *A;

	A = (double*)malloc(m * sizeof(double *));	
	return A;
}


void assign_vector(double* vec, int m){
	for (int i=0; i<m; i++)
	{
		vec[i]=2.;
	}
}


int main(int argc, char* argv[]){
	int m =3;
	int n=2;

	double *A=allocate_vector(m*n); //A has n rows, m columns
	assign_vector(A, m*n);

	double *B=allocate_vector(n);
	assign_vector(B, n);

	double *C=allocate_vector(m);

	double *A_d;
	cudaMalloc((void**)&A_d, m*n*sizeof(double));
	cudaMemcpy(A_d,A,m*n*sizeof(double),cudaMemcpyHostToDevice);

	double *B_d;
	cudaMalloc((void**)&B_d, n*sizeof(double));
	cudaMemcpy(B_d,B,n*sizeof(double),cudaMemcpyHostToDevice);

	double *C_d;
	cudaMalloc((void**)&C_d, m*sizeof(double));

	dim3 block_size(1);
	dim3 grid_size(m/block_size.x);
	mxv<<<block_size,grid_size>>>(m,n,A_d,B_d,C_d);
	cudaDeviceSynchronize();

	cudaMemcpy(C,C_d,m*sizeof(double),cudaMemcpyDeviceToHost);
	print_vector(m,C);
	
}

