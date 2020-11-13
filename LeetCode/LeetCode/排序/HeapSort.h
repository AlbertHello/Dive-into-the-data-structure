//
//  HeapSort.h
//  LeetCode
//
//  Created by 58 on 2020/10/28.
//

#import "Sort.h"

NS_ASSUME_NONNULL_BEGIN

@interface HeapSort : Sort

-(void)heapifyWith:(NSMutableArray *)array;

-(void)heapifyWith:(int *)arr length:(int)len;
@end

NS_ASSUME_NONNULL_END
