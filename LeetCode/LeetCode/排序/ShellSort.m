//
//  ShellSort.m
//  LeetCode
//
//  Created by 58 on 2020/11/3.
//

#import "ShellSort.h"


@interface ShellSort()

@property(nonatomic,strong)NSMutableArray *array;

@end

@implementation ShellSort


/**
 959年由唐纳德·希尔（Donald Shell） 提出
 ◼ 希尔排序把序列看作是一个矩阵，分成 𝑚 列，逐列进行排序
 𝑚 从某个整数逐渐减为1
 当 𝑚 为1时，整个序列将完全有序
 ◼ 因此，希尔排序也被称为递减增量排序（Diminishing Increment Sort）
 ◼ 矩阵的列数取决于步长序列（step sequence）
 ✓ 比如，如果步长序列为{1,5,19,41,109,...}，就代表依次分成109列、 41列、 19列、 5列、 1列进行排序
 ✓ 不同的步长序列，执行效率也不同
 
 希尔本人给出的步长序列是 𝑛/2𝑘，比如 𝑛 为16时，步长序列是{1, 2, 4, 8}
 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1
 先分成8列进行排序:
 16 15 14 13 12 11 10 9
 8  7  6  5  4  3  2  1
 每列排序后：
 8  7  6  5  4  3  2  1
 16 15 14 13 12 11 10 9
 组合成了这样：
 8 7 6 5 4 3 2 1 16 15 14 13 12 11 10 9
 之后再分四列进行排序：
 8  7  6  5
 4  3  2  1
 16 15 14 13
 12 11 10 9
 每列排序后：
 4  3  2  1
 8  7  6  5
 12 11 10 9
 16 15 14 13
 组合成了这样：
 4 3 2 1 8 7 6 5 12 11 10 9 16 15 14 13
 再分两列：
 4  3
 2  1
 8  7
 6  5
 12 11
 10 9
 16 15
 14 13
 每列排序后：
 2  1
 4  3
 6  5
 8  7
 10 9
 12 11
 14 13
 16 15
 。。。。一次类推
 不难看出来，从8列 变为 1列的过程中，逆序对的数量在逐渐减少
 因此希尔排序底层一般使用插入排序对每一列进行排序，也很多资料认为希尔排序是插入排序的改进版
 
 */
/**
 假设元素在第 col 列、第 row 行，步长（总列数）是 step
 那么这个元素在数组中的索引是 col + row * step
 比如 9 在排序前是第 2 列、第 0 行，那么它排序前的索引是 2 + 0 * 5 = 2
 比如 4 在排序前是第 2 列、第 1 行，那么它排序前的索引是 2 + 1 * 5 = 7
 
 最好情况是步长序列只有1，且序列几乎有序，时间复杂度为 O(n)
 空间复杂度为O(1)，属于不稳定排序
 */

-(void)shellSort:(NSMutableArray *)arr{
    self.time=CFAbsoluteTimeGetCurrent();
    self.array=arr;
    NSMutableArray *array=[self sedgewickStepSequence];
    for (NSNumber *step in array) {
        [self sort:step.intValue];
    }
    self.time=CFAbsoluteTimeGetCurrent()-self.time;
}
-(void)sort:(int)step {
    // col : 第几列，column的简称
    for (int col = 0; col < step; col++) { // 对第col列进行排序
        // col、col+step、col+2*step、col+3*step
        // 还是插入排序
        for (int begin = col + step; begin < self.array.count; begin += step) {
            int cur = begin;
            while (cur > col && [self cmp:[self.array[cur] intValue] to:[self.array[cur-step] intValue]] < 0) {
                NSNumber *temp=self.array[cur];
                self.array[cur]=self.array[cur-step];
                self.array[cur-step]=temp;
                cur -= step;
            }
        }
    }
}
//希尔本人给出的步长序列是 𝑛/2^𝑘
-(NSMutableArray *)shellStepSequence{
    NSMutableArray *stepSequence=[NSMutableArray array];
    int step = (int)self.array.count;
    while ((step >>= 1) > 0) {
        //加入16个元素
        //那么8 4 2 1
        [stepSequence addObject:@(step)];
    }
    return stepSequence;
}
//目前已知的最好的步长序列，最坏情况时间复杂度是 O(n^(4/3)) ， 1986年由Robert Sedgewick提出
-(NSMutableArray *)sedgewickStepSequence{
    NSMutableArray *stepSequence=[NSMutableArray array];
    int k = 0, step = 0;
    while (true) {
        if (k % 2 == 0) {
            int p = (int)pow(2, k >> 1);
            step = 1 + 9 * (p * p - p);
        } else {
            int pow1 = (int)pow(2, (k - 1) >> 1);
            int pow2 = (int)pow(2, (k + 1) >> 1);
            step = 1 + 8 * pow1 * pow2 - 6 * pow2;
        }
        if (step >= self.array.count) break;
        [stepSequence insertObject:@(step) atIndex:0];
        k++;
    }
    return stepSequence;
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
