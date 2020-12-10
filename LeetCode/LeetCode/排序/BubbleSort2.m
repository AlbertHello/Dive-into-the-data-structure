//
//  BubbleSort2.m
//  LeetCode
//
//  Created by Albert on 2020/10/25.
//

#import "BubbleSort2.h"

@implementation BubbleSort2
// 大O排序
// O(1) < O(logn) < O(n) < O(nlogn) < O(n^2) < O(2^n) < O(n!)

//  名称    最好          最坏               平均            空间   in-place  稳定性
// 冒泡排序  O(n)         O(n^2)            O(n^2)          O(1)    ✅       ✅
// 选择排序  O(n^2)       O(n^2)            O(n^2)          O(1)    ✅       ❌
// 插入排序  O(n)         O(n^2)            O(n^2)          O(1)    ✅       ✅
// 归并排序  O(nlogn)     O(nlogn)          O(nlogn)        O(n)    ❌       ✅
// 快速排序  O(nlogn)     O(n^2)             O(nlogn)        O(logn) ✅       ❌
// 希尔排序  O(n)     O(n^(4/3))~O(n^2)   取决于步长序列       O(1)    ✅       ❌
// 堆排序    O(nlogn)     O(nlogn)         O(nlogn)         O(1)    ✅       ❌
// 计数排序  O(n + k)     O(n + k)          O(n + k)        O(n + k) ❌      ✅
// 基数排序  O(d∗(n+k))   O(d∗(n+k))       O(d∗(n+k))       O(n + k) ❌      ✅
// 桶排序    O(n + k)     O(n + k)          O(n + k)        O(n + m) ❌      ✅

/**
 优化1
 如果序列已经完全有序，可以提前终止冒泡排序
 */
-(void)bubbleSort2:(int *)arr length:(int)len{
    self.time=CFAbsoluteTimeGetCurrent();
    for (int i=len; i>0; i--) {
        bool flag = true; //如果一轮遍历后该值没有变化，说明已经拍好顺序，提前结束便利
        for (int j=0; j<i-1; j++) {
            if ([self cmp:arr[j] to:arr[j+1]] > 0) {
                [self swap:&arr[j] with:&arr[j+1]];
                flag=false;
            }
        }
        if (flag) break;
    }
    self.time=CFAbsoluteTimeGetCurrent()-self.time;
}
-(NSString *)description{
    NSString *class=NSStringFromClass([self class]);
    NSString *time=[NSString stringWithFormat:@"%f",self.time];
    NSString *cmpCount=[NSString stringWithFormat:@"%ld",self.cmpCount];
    NSString *swapCount=[NSString stringWithFormat:@"%ld",self.swapCount];
    NSString *str=[NSString stringWithFormat:@"\n Sort: %@\n 耗时：%@\t 比较次数：%@\t 交换次数：%@\t",class,time,cmpCount,swapCount];
    printf("************************************************\n");
    return str;
}

@end
