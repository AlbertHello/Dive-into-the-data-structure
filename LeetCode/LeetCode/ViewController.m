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
#include "1_TwoSum.h"
#include "21_MergeTwoSortedList.h"
#include "20_ValidParentheses.h"
#include "70_ClimbingStairs.h"
#import "15_ThreeSum.h"
#import "8_StringtoInteger.h"





@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor systemPinkColor];
    
    [self test];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self leetcodeTest];
}

-(void)leetcodeTest{
//    validParenthesesTest();
//    climbStairsTest();
//    [_5_ThreeSum threeSumTest];
    [_StringtoInteger myAtoiTest];
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
