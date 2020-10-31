//
//  InsertSort.m
//  LeetCode
//
//  Created by 58 on 2020/10/30.
//

#import "InsertSort.h"

@implementation InsertSort


-(void)insertSort:(int *)arr length:(int)len{
    self.time=CFAbsoluteTimeGetCurrent();
    for (int begin=1; begin<len; begin++) {
        int cur=begin;
        while (cur>0 && [self cmp:arr[cur] to:arr[cur-1]] < 0) {
            [self swap:&arr[cur] with:&arr[cur-1]];
            cur--;
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
