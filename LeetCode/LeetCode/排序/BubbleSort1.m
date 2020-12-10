//
//  BubbleSort.m
//  LeetCode
//
//  Created by Albert on 2020/10/24.
//

#import "BubbleSort1.h"

@interface BubbleSort1 ()

@end

@implementation BubbleSort1

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
 何为原地算法？ In-place Algorithm
 不依赖额外的资源或者依赖少数的额外资源，仅依靠输出来覆盖输入
 空间复杂度为 𝑂(1) 的都可以认为是原地算法
 
 冒泡排序属于In-place
 执行流程（本课程统一以升序为例子）
 ① 从头开始比较每一对相邻元素，如果第1个比第2个大，就交换它们的位置
 ✓ 执行完一轮后，最末尾那个元素就是最大的元素
 ② 忽略 ① 中曾经找到的最大元素，重复执行步骤 ①，直到全部元素有序
 */


-(void)bubbleSort1:(int *)arr length:(int)len{
    self.time=CFAbsoluteTimeGetCurrent();
    for (int i=len; i>0; i--) {
        for (int j=0; j<i-1; j++) {
            //比较一轮，较大者被挪到了最后面，下一次比较就不再和最后一个比较
            if ([self cmp:arr[j] to:arr[j+1]] >0 ) {
                //交换，把大的往后挪
                [self swap:&arr[j] with:&arr[j+1]];
            }
        }
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
