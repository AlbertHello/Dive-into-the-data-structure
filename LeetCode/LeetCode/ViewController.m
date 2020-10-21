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




@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor systemPinkColor];
    
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self leetcodeTest];
}
-(void)leetcodeTest{
//    validParenthesesTest();
//    climbStairsTest();
    [_5_ThreeSum threeSumTest];
}

@end
