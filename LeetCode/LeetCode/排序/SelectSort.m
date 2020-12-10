//
//  SelectSort.m
//  LeetCode
//
//  Created by 58 on 2020/10/28.
//

#import "SelectSort.h"

@implementation SelectSort

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
 执行流程
 ① 从序列中找出最大的那个元素，然后与最末尾的元素交换位置
 ✓ 执行完一轮后，最末尾的那个元素就是最大的元素
 ② 忽略 ① 中曾经找到的最大元素，重复执行步骤 ①
 
 选择排序的交换次数要远远少于冒泡排序，平均性能优于冒泡排序
 最好、最坏、平均时间复杂度： O(n2)，空间复杂度： O(1)，属于不稳定排序
 
 
 思考
 选择排序是否还有优化的空间？
 ✓ 使用堆来选择最大值
 
 */

-(void)selectSort:(int *)arr length:(int)len{
    self.time=CFAbsoluteTimeGetCurrent();
    for (int end=len-1; end>0; end--) {
        int max=0;//记录最大值的索引
        for (int begin=1; begin<=end; begin++) {
            if ([self cmp:arr[max] to:arr[begin] < 0]) {
                //arr[max] < arr[begin]
                max=begin;//最大值索引
            }
        }
        //一轮比较完成交换末尾和最大值，则最后一位就是最大值了。
        //下一轮就不会再跟最后一位的数进行比较了
        //无论找到的那个max是否是最后一位，都有交换这一步。即便相等也要交换，所以不稳定
        [self swap:&arr[max] with:&arr[end]];
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
