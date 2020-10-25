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
    return str;
}

@end
