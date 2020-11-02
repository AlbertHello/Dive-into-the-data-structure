//
//  ViewController.m
//  LeetCode
//
//  Created by 58 on 2020/10/15.
//

#import "ViewController.h"
#include "141_LinkedListCycle.h"
#include "203_RemoveLinkedListElements.h"
#include "2_AddTwoNumbers.h"
#include "19_RemoveNthNodeFromEndofList.h"
#include "61_RotateList.h"
#include "82_RemoveDuplicatesfromSortedList2.h"
#include "21_MergeTwoSortedList.h"
#include "20_ValidParentheses.h"
#include "70_ClimbingStairs.h"
#import "15_ThreeSum.h"
#import "8_StringtoInteger.h"
#import "1_TwoSums.h"
#import "BubbleSort1.h"
#import "BubbleSort2.h"
#import "BubbleSort3.h"
#import "SelectSort.h"
#import "HeapSort.h"
#import "InsertSort.h"
#import "MergeSort.h"
#import "QuickSort.h"
#import "149_Max_Points_on_a_Line.h"
#import "28_Implement_strStr.h"
#import "66_Plus_One.h"








@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor systemPinkColor];
    
//    [self test];
    [self leetcodeTest];
//    [self sortTest];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self leetcodeTest];
}

-(void)leetcodeTest{
//    validParenthesesTest();
//    climbStairsTest();
//    [_5_ThreeSum threeSumTest];
//    [_StringtoInteger myAtoiTest];
//    [_49_Max_Points_on_a_Line maxPointsTests];
//    [_8_Implement_strStr locateSubstringTest];
    [_6_Plus_One plusOneTest];
}
-(void)sortTest{
//    int arr1[10]={90,56,23,4,1,45,57,29,40,39};
//    int arr1[1000]={0},arr2[1000]={0},arr3[1000]={0},arr4[1000]={0},arr5[1000]={0};
//    int arr6[1000]={0},arr7[1000]={0},arr8[1000]={0},arr9[1000]={0},arr10[1000]={0};
    NSMutableArray *array1=[NSMutableArray array];
    NSMutableArray *array2=[NSMutableArray array];
    int len=10000;
    for (int i=0; i<len; i++) {
        int rand=arc4random()%len;
//        arr1[i]=rand;
//        arr2[i]=rand;
//        arr3[i]=rand;
//        arr4[i]=rand;
//        arr5[i]=rand;
//        arr6[i]=rand;
//        arr7[i]=rand;
//        arr8[i]=rand;
//        arr9[i]=rand;
//        arr10[i]=rand;
        [array1 addObject:@(rand)];
        [array2 addObject:@(rand)];
    }
//
//    BubbleSort1 *b1=[[BubbleSort1 alloc]init];
//    [b1 bubbleSort1:arr1 length:len];
//    NSLog(@"%@",b1);
//
//    BubbleSort2 *b2=[[BubbleSort2 alloc]init];
//    [b2 bubbleSort2:arr2 length:len];
//    NSLog(@"%@",b2);
//
//    BubbleSort3 *b3=[[BubbleSort3 alloc]init];
//    [b3 bubbleSort3:arr3 length:len];
//    NSLog(@"%@",b3);
//
//    SelectSort *select=[[SelectSort alloc]init];
//    [select selectSort:arr4 length:len];
//    NSLog(@"%@",select);

//    HeapSort *heap=[[HeapSort alloc]init];
//    [heap heapifyWith:arr5 length:len];
//    NSLog(@"%@",heap);
    
//    InsertSort *insert=[[InsertSort alloc]init];
//    [insert insertSort:arr1 length:len];
//    [insert insertSort2:arr1 length:len];
//    [insert insertSort3:arr6 length:len];
//    NSLog(@"%@",insert);
    
    MergeSort *merge=[[MergeSort alloc]init];
    [merge mergeSort:array1];
    NSLog(@"%@",merge);
    
    QuickSort *quick=[[QuickSort alloc]init];
    [quick quickSort:array2];
    NSLog(@"%@",quick);
    
    
//    for (int i=0; i<10; i++) {
//        printf("%d ",arr1[i]);
//    }
//    printf("\n");
}
-(void)test{
    NSLog(@"sizeof(int)         : %lu",sizeof(int));
    NSLog(@"sizeof(short)       : %lu",sizeof(short));
    NSLog(@"sizeof(long)        : %lu",sizeof(long));
    NSLog(@"sizeof(double)      : %lu",sizeof(double));
    NSLog(@"sizeof(float)       : %lu",sizeof(float));
    NSLog(@"sizeof(NSInteger)   : %lu",sizeof(NSInteger));
    NSLog(@"sizeof(NSUInteger)  : %lu",sizeof(NSUInteger));
    NSLog(@"INT_MAX             : %d",INT_MAX);
    NSLog(@"INT_MIN             : %d",INT_MIN);
}

@end
