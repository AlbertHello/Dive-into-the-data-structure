//
//  BubbleSort2.m
//  LeetCode
//
//  Created by Albert on 2020/10/25.
//

#import "BubbleSort2.h"

@implementation BubbleSort2

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
    return str;
}

@end
