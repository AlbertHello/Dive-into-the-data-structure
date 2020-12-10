//
//  BubbleSort3.m
//  LeetCode
//
//  Created by Albert on 2020/10/25.
//

#import "BubbleSort3.h"

@implementation BubbleSort3

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
 优化2
 如果序列尾部已经局部有序，可以记录最后1次交换的位置，减少比较次数
 
 
 如果相等的2个元素，在排序前后的相对位置保持不变，那么这是稳定的排序算法
 排序前： 5, 1, 3𝑎, 4, 7, 3𝑏
 稳定的排序： 1, 3𝑎, 3𝑏, 4, 5, 7
 不稳定的排序： 1, 3𝑏, 3𝑎, 4, 5, 7
 
 对自定义对象进行排序时，稳定性会影响最终的排序效果
 冒泡排序属于稳定的排序算法
 稍有不慎，稳定的排序算法也能被写成不稳定的排序算法，比如下面的冒泡排序代码是不稳定的
 [self cmp:arr[begin] to:arr[begin-1]] <= 0也就是小于号换成小于等于号
 */


//对于局部已经排好序的数组，比如尾部已经排序或者其他部位已经排好序
//value: 5,3,4,2,8,1,9,11,13,14
//index: 0 1 2 3 4 5 6 7 8 9 10 最后1次交换的位置是index=5

//最坏、平均时间复杂度： O(n2)
//最好时间复杂度： O(n)
//空间复杂度： O(1)

-(void)bubbleSort3:(int *)arr length:(int)len{
    self.time=CFAbsoluteTimeGetCurrent();
    for (int end = len - 1; end > 0; end--) {
        int sortedIndex = 0;
        for (int begin = 1; begin <= end; begin++) {
            if ([self cmp:arr[begin] to:arr[begin-1]] < 0) {
                [self swap:&arr[begin] with:&arr[begin-1]];
                sortedIndex = begin; //每次记录参与比较的较大的那个下标
            }
        }
        //因为5,3,4,2,8,1,9,11,13,14这个例子最后是排好序的，
        //那么sortedIndex最终就停留在了9前面那个下标也就是begin=5
        //这样下一轮end就直接从sortedIndex-1那开始循环
        //跳过了尾部排好序的部分，提升效率
        end = sortedIndex;
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
