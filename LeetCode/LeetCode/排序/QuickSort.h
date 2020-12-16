//
//  QuickSort.h
//  LeetCode
//
//  Created by Albert on 2020/11/1.
//

#import "Sort.h"

NS_ASSUME_NONNULL_BEGIN

@interface QuickSort : Sort

-(void)quickSort:(NSMutableArray *)array;
/// C 实现 快排 [ begin, end )
void quick_sort(int *nums, int begin, int end);
@end

NS_ASSUME_NONNULL_END
