//
//  MergeSort.m
//  LeetCode
//
//  Created by Albert on 2020/11/1.
//

#import "MergeSort.h"

@interface MergeSort ()

@property(nonatomic,strong)NSMutableArray *leftArray;
@property(nonatomic,strong)NSMutableArray *array;

@end

@implementation MergeSort

-(instancetype)init{
    if (self=[super init]) {
        
    }
    return self;
}
/**
 执行流程
 ① 不断地将当前序列平均分割成2个子序列
 ✓ 直到不能再分割（序列中只剩1个元素）
 ② 不断地将2个子序列合并成一个有序序列
 ✓ 直到最终只剩下1个有序序列
 
 
 由于归并排序总是平均分割子序列，所以最好、最坏、平均时间复杂度都是 O(nlogn) ，属于稳定排序
 ◼ 从代码中不难看出：归并排序的空间复杂度是 O n/2 + logn = O(n)
 n/2 用于临时存放左侧数组， logn 是因为递归调用
 
 */
-(void)mergeSort:(NSMutableArray *)array{
    self.time=CFAbsoluteTimeGetCurrent();
    self.array=array;
    self.leftArray=[NSMutableArray arrayWithCapacity:array.count >> 1];
    [self sort:0 end:(int)self.array.count];
    self.time=CFAbsoluteTimeGetCurrent()-self.time;
}
//对 [begin, end) 范围的数据进行归并排序
-(void)sort:(int)begin end:(int)end {
    if (end - begin < 2) return;
    int mid = (begin + end) >> 1;
    
    //递归调用数据规模：n/2，设需要的时间T(n/2)
    [self sort:begin end:mid];
    //递归调用数据规模：n/2,设需要的时间T(n/2)
    [self sort:mid end:end];
    //合并操作时间复杂度：O(n)
    [self merge:begin mid:mid end:end];
}
//将 [begin, mid) 和 [mid, end) 范围的序列合并成一个有序序列
-(void)merge:(int)begin mid:(int)mid end:(int)end{
    //leftArray的左起始点li，右结束点le
    int li = 0, le = mid - begin;
    //array的左起始点ri=mid，右结束点re=end
    int ri = mid, re = end;
    //ai是要[begin end）前半部分的起始点
    int ai = begin;
    
    // 备份左边数组
    for (int i = li; i < le; i++) {
        self.leftArray[i] = self.array[begin + i];
    }
    
    while (li < le) { // 如果左边还没有结束
        //如果右边结束了：ri >= re,就直接把左边数组剩下的全部靠过去self.array[ai++] = self.leftArray[li++];
        //如果左右数组都没结束，开始比较
        //如果右边的值小于左边的值则拿右边的值覆盖array[ai++]，同时右边的ri++，被覆盖的ai++
        if (ri < re && [self cmp:[self.array[ri] intValue] to:[self.leftArray[li] intValue]] < 0) {
            self.array[ai++] = self.array[ri++];
        } else {
            //如果右边的值大于等于左边的值则拿备份数组中的值覆盖array[ai++]
            //这样避免了原数组中的相同的值交换，所以是稳定的
            //同时备份数组的li++，被覆盖的ai++
            self.array[ai++] = self.leftArray[li++];
        }
    }
    //如果左边先结束了，那么右边不需要处理
}

-(void)insertSort3:(int *)arr length:(int)len{
    
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


/**
 递归调用时间复杂度分析
 T (n) = 2 ∗ T (n/2) + O(n)
 T (1) =  O(1)
 T (n ) / n = T (n/2) / (n/2) + O(1)
 
 令 S(n) = T (n) /n
 S (1) = O(1)
 S (n) = S (n/2) + O(1) = S (n/4) + O(2) = S (n/8) + O(3) = S (n/2^k) + O( k) = S (1 )+ O(logn) = O(logn)
 T (n)= n ∗ S( n) = O(nlogn)
 由于归并排序总是平均分割子序列，所以最好、最坏、平均时间复杂度都是 O(nlogn) ，属于稳定排序
 
 
 常见的递推式与复杂度：
 
 T(n)=T(n/2)+O(1)            O(logn)
 T(n)=T(n-1)+O(1)           O(n)
 T(n)=T(n/2)+O(n)              O(n)
 T(n)=2*T(n/2)+O(1)        O(n)
 T(n)=2*T(n/2)+O(n)          O(nlogn)
 T(n)=T(n-1)+O(n)              O(n^2)
 T(n)=2*T(n-1)+O(1)         O(2^n)
 T(n)=2*T(n-1)+O(n)         O(2^n)
 
 
 */
@end
