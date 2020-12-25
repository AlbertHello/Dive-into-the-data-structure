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
#import "ShellSort.h"
#import "149_Max_Points_on_a_Line.h"
#import "28_Implement_strStr.h"
#import "66_Plus_One.h"
#import "_821_Shortest_Distance_to_a_Character.h"
#import "146_LRU_Cache.h"
#import "5_LongestPalindromicSubstring.h"
#import "_394_Decode_String.h"
#import "_16_16Sub_Sort_LCCI.h"
#import "_151_Reverse_Words_in_a_String.h"
#import "3_LongestSubstringWithoutRepeatingCharacters.h"
#import "_54_Spiral_Matrix.h"
#import "_7_Reverse_Integer.h"
#import "_252_MeetingRoom.h"
#import "_253_MeetingRoom_2.h"
#import "_42_Trapping_Rain_Water.h"
#import "_22_GenerateParentheses.h"
#import "_17_LetterCombinationsofaPhoneNumber.h"
#import "BinaryTree.h"
#import "_300_Longest_Increasing_Subsequence.h"
#import "_347_TopKFrequentElements.h"
#import "_572_Subtree_of_Another_Tree.h"
#import "_121_Best_Time_to_Buy_and_Sell_Stock.h"







@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor systemPinkColor];
    
    
//    NSArray *arr=@[@(2),@(1),@(-3),@(5),@(3),@(6),];
//    NSArray *new=[arr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
//        NSNumber *o1=(NSNumber *)obj1;
//        NSNumber *o2=(NSNumber *)obj2;
//        NSInteger o1_val=[o1 integerValue];
//        NSInteger o2_val=[o2 integerValue];
//        if (o1_val < o2_val) { // 生序
//            return NSOrderedAscending;
//        }else{
//            return NSOrderedDescending;
//        }
//    }];
//    NSLog(@"%@",new);
    
    
    
    
//    [self test];
    [self leetcodeTest];
//    [self sortTest];
//    [self testBinaryTree];
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
//    [_6_Plus_One plusOneTest];
//    [_821_Shortest_Distance_to_a_Character shortestToCharTest];
//    [_46_LRU_Cache LRU_Cache_Test];
//    longestPalindromeTest();
//    [_394_Decode_String decodeStringTest];
//    [_16_16Sub_Sort_LCCI subSortTest];
//    [_151_Reverse_Words_in_a_String reverseWordsTest];
//    [__LongestSubstringWithoutRepeatingCharacters lengthOfLongestSubstring_c_Test];
//    rotate_right_test();
//    [_7_Reverse_Integer integerReverseTest];
//    [_252_MeetingRoom canAttendMeetingsTest];
//    [_253_MeetingRoom_2 minMeetingRoomTest];
//    [_42_Trapping_Rain_Water trapTest];
//    [_22_GenerateParentheses generateParenthesis_OC_TEST];
//    [_17_LetterCombinationsofaPhoneNumber letterCombinationsTest];
//    lengthOfLISTest();
//    [_347_TopKFrequentElements topKFrequentTest];
//    maxProfitTest();
    [_572_Subtree_of_Another_Tree isSubtreeTest];
    
    
}
-(void)testBinaryTree{
    [BinaryTree binaryTreeTest];
}
-(void)sortTest{
//    int arr1[10]={90,56,23,4,1,45,57,29,40,39};
//    int arr1[1000]={0},arr2[1000]={0},arr3[1000]={0},arr4[1000]={0},arr5[1000]={0};
//    int arr6[1000]={0},arr7[1000]={0},arr8[1000]={0},arr9[1000]={0},arr10[1000]={0};
    NSMutableArray *array1=[NSMutableArray array];
    NSMutableArray *array2=[NSMutableArray array];
    NSMutableArray *array3=[NSMutableArray array];
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
        [array3 addObject:@(rand)];
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
    
//    MergeSort *merge=[[MergeSort alloc]init];
//    [merge mergeSort:array1];
//    NSLog(@"%@",merge);
//
//    QuickSort *quick=[[QuickSort alloc]init];
//    [quick quickSort:array2];
//    NSLog(@"%@",quick);
//
//    ShellSort *shell=[[ShellSort alloc]init];
//    [shell shellSort:array3];
//    NSLog(@"%@",shell);
    
    
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
