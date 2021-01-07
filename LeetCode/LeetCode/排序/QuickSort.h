//
//  QuickSort.h
//  LeetCode
//
//  Created by Albert on 2020/11/1.
//

#import "Sort.h"

NS_ASSUME_NONNULL_BEGIN

@interface QuickSort : Sort
/// OC 实现 快排
-(void)quickSort:(NSMutableArray *)array;
/// C 实现 快排 [ begin, end ) 开区间
void quick_sort(int *nums, int begin, int end);
/// C 实现 快排2 [begin, end] 闭区间
void quick_sort2(int* nums, int begin, int end);

@end

NS_ASSUME_NONNULL_END
