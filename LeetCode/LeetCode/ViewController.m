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
#import "149_Max_Points_on_a_Line.h"







@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor systemPinkColor];
    
//    [self test];
//    [self leetcodeTest];
    [self sortTest];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self leetcodeTest];
}

-(void)leetcodeTest{
//    validParenthesesTest();
//    climbStairsTest();
//    [_5_ThreeSum threeSumTest];
//    [_StringtoInteger myAtoiTest];
    [_49_Max_Points_on_a_Line maxPointsTests];
}
-(void)sortTest{
    int arr1[1000]={0},arr2[1000]={0},arr3[1000]={0};
    for (int i=0; i<1000; i++) {
        int rand=arc4random()%1000;
        arr1[i]=rand;
        arr2[i]=rand;
        arr3[i]=rand;
    }
    
    BubbleSort1 *b1=[[BubbleSort1 alloc]init];
    [b1 bubbleSort1:arr1 length:1000];
    NSLog(@"%@",b1);
    
    BubbleSort2 *b2=[[BubbleSort2 alloc]init];
    [b2 bubbleSort2:arr2 length:1000];
    NSLog(@"%@",b2);
    
    BubbleSort3 *b3=[[BubbleSort3 alloc]init];
    [b3 bubbleSort3:arr3 length:1000];
    NSLog(@"%@",b3);
    
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
