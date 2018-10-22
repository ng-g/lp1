#include <stdio.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include<bits/stdc++.h>
#include <iostream>
using namespace std;
int n;

__global__ void BSearch(int* da,int num,int n)				// kernel function definition
{

	const int tid = blockIdx.x*blockDim.x + threadIdx.x;

         if(da[tid]==num)
		    da[0]=tid;
}
int main()
{
	int num,nb;
	printf("\n Enter number of elements :");   //you can give any large number
	scanf("%d",&n);
	int a[n+1];
	time_t t;
    srand((unsigned)time(&t));
    a[0]=-1;
    for(unsigned i = 1 ; i <= n ; i++)
    {
    	    	    		a[i]=a[i-1]+rand()%n;  //for generating sorted random sequence
    }

    printf("\n\n Generated array\n");
    for(int i=1; i <=n;i++)
    	printf("%d\t ",a[i]);
    printf("\n Enter number to be searched :");
    scanf("%d",&num);
    //allocating number of blocks

    if(n%1024==0)
    	nb=n/1024;
    else
    	nb=n/1024 +1;

    int* da;//GPU parameter
    //int dpos;

    	cudaMalloc(&da, (n+1)*sizeof(int));		//assign memory to parameters on GPU

    	cudaMemcpy(da, a, (n+1)*sizeof(int), cudaMemcpyHostToDevice);		//copy the array from CPU to GPU

    BSearch<<<nb,1024>>>(da,num,n);
int result;
    cudaMemcpy(&result, da, sizeof(int), cudaMemcpyDeviceToHost);
 if(result==-1)
        	printf("\nElement not found");
    else
    	printf("\nElement found at %d",result);

return 0;
}







/*OUTPUT:-
 *
 *
 * Enter number of elements :5


 Generated array
2	 4	 7	 9	 11
 Enter number to be searched :7

Element found at 91

*/
 
