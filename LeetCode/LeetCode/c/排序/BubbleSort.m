//
//  BubbleSort.m
//  LeetCode
//
//  Created by Albert on 2020/10/24.
//

#import "BubbleSort.h"

@implementation BubbleSort

+(void)bubbleSort1{
    int arr[]={10,9,8,7,6,5,4,3,2,1};
    int len=sizeof(arr)/sizeof(int);
    printf("len= %d\n",len);
    int count=0;
    for (int i=len; i>0; i--) {
        for (int j=0; j<i-1; j++) {
            count++;
            if (arr[j]>arr[j+1]) {
                int temp=arr[j];
                arr[j]=arr[j+1];
                arr[j+1]=temp;
            }
        }
    }
    for (int i=0; i<len; i++) {
        printf("%d ",arr[i]);
    }
    printf("\n");
    printf("compare counts: %d\n",count);
}
+(void)bubbleSort2{
    int arr[]={10,2,23,40,45,56,59,89};
    int len=sizeof(arr)/sizeof(int);
    printf("len= %d\n",len);
    int count=0;
    for (int i=len; i>0; i--) {
        bool flag = true;
        for (int j=0; j<i-1; j++) {
            count++;
            if (arr[j]>arr[j+1]) {
                int temp=arr[j];
                arr[j]=arr[j+1];
                arr[j+1]=temp;
                flag=false;
            }
        }
        if (flag) break;
    }
    for (int i=0; i<len; i++) {
        printf("%d ",arr[i]);
    }
    printf("\n");
    printf("compare counts: %d\n",count);
}
+(void)bubbleSortTest{
    [self bubbleSort1];
//    [self bubbleSort2];
}

@end
