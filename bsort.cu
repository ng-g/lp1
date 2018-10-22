


#include<stdio.h>
#include<cuda.h>
#include<stdlib.h>
#define DIVIDER	10000
__global__ void even(int *darr,int n)
{
   int k=blockIdx.x*512+threadIdx.x;
    int t;
     k=k*2; //for even positions
      if(k< n-1)
       {
          if(darr[k]>darr[k+1])
            {  //swap the numbers
               t=darr[k];
                darr[k]=darr[k+1];
                darr[k+1] =t;
             }
       }
}

__global__ void odd(int *darr,int n)
{
   int k=blockIdx.x*512+threadIdx.x;
    int t;
     k=k*2 +1; //for odd positions
      if(k< n-1)
       {
          if(darr[k]>darr[k+1])
            {  //swap the numbers
               t=darr[k];
                darr[k]=darr[k+1];
                darr[k+1] =t;
             }
       }
}
int main()
{
 int *arr,*darr;
 int n,i;
 time_t t;
     srand((unsigned)time(&t));
  printf("\n Enter how many numbers :");
  scanf("%d",&n);
  arr=(int *)malloc(n*sizeof(int));  //for dynamic inputs

   for(i=0; i<n; i++)
	{
		arr[i] = (rand() % DIVIDER) + 1;
        }
  //  printf("\n UNSORTED ARRAY  \n");
  //   for(i=0; i<n; i++)
    //    printf("\t%d",arr[i]);

  cudaMalloc(&darr,n*sizeof(int));  //memory allocation in GPU for darr
  cudaMemcpy(darr,arr ,n*sizeof(int) ,cudaMemcpyHostToDevice); // data transfer from host to GPU

  for(i=0;i<=n/2;i++)
   {
       even<<<n/1024+1,512>>>(darr,n);
       odd<<<n/1024+1,512>>>(darr,n);
   }
cudaMemcpy(arr,darr,n*sizeof(int),cudaMemcpyDeviceToHost);

printf("\n SORTED ARRAY  \n");
     for(i=0; i<n; i++)
      printf("\t%d",arr[i]);

}







/*OUPUT:-
 *
 *
 *
 *
 Enter how many numbers :4

 SORTED ARRAY
	1957	6378	7439	8530*/


