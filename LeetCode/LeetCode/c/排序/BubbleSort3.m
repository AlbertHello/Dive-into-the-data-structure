//
//  BubbleSort3.m
//  LeetCode
//
//  Created by Albert on 2020/10/25.
//

#import "BubbleSort3.h"

@implementation BubbleSort3

//对于局部已经排好序的数组，比如尾部已经排序或者其他部位已经排好序
// 5,3,4,2,8,1,9,11,13,14
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
    return str;
}
@end
