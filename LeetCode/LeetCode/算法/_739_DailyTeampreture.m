//
//  _739_DailyTeampreture.m
//  LeetCode
//
//  Created by 58 on 2020/12/3.
//

#import "_739_DailyTeampreture.h"

@interface Stack : NSObject
@property(nonatomic,strong)NSMutableArray *container;
-(BOOL)isEmpty;
-(int)peek;
-(int)pop;
-(void)push:(int)val;

@end

@implementation Stack
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.container=[NSMutableArray array];
    }
    return self;
}
-(BOOL)isEmpty{
    return self.container.count == 0;
}
-(int)peek{
    if ([self isEmpty]) return INT_MAX;
    NSNumber *last=self.container.lastObject;
    return last.intValue;
}
-(int)pop{
    int top = self.peek;
    if (top == -1) return top;
    [self.container removeLastObject];
    return top;
}
-(void)push:(int)val{
    [self.container addObject:@(val)];
}

@end


@implementation _739_DailyTeampreture

/**
 则有如下题目：
 739. 每日温度
 https://leetcode-cn.com/problems/daily-temperatures/
 请根据每日 气温 列表，重新生成一个列表。对应位置的输出为：要想观测到更高的气温，至少需要等待的天数。如果气温在这之后都不会升高，请在该位置用 0 来代替。
 例如，给定一个列表 temperatures = [73, 74, 75, 71, 69, 72, 76, 73]，你的输出应该是 [1, 1, 4, 2, 1, 1, 0, 0]。
 提示：气温 列表长度的范围是 [1, 30000]。每个气温的值的均为华氏度，都是在 [30, 100] 范围内的整数。
 
 这个题其实就只是找某个数的右边的第一个比它大的数
 
 */

/**
 解法1：单调栈。
 将要入栈的元素先和栈顶元素比较大小
 如果小于栈顶元素表示将要入栈的元素的左边第一个比它大的就是这个栈顶元素，随后入栈。
 如果大于栈顶元素，则栈顶元素出栈，且表明该栈顶元素的右边第一个比它大的就是将要入栈的这个元素；
    栈顶元素出栈后，将要入栈的这个元素再继续和新栈顶元素大小比较。
 */
int* dailyTemperatures1(int* T, int length) {
    if (T == NULL || length == 0) return NULL;
    int *result = (int *)malloc(sizeof(int)*length);
    Stack *stack=[[Stack alloc]init]; // 栈中存储的是数组索引
    for (int i = 0; i < length; i++) {
        // 这里应该要写大于，不要写大于等于
        while (!stack.isEmpty && T[i] > T[stack.peek]) {
            // 如果将要压栈的这个元素比栈顶元素大，那么T[i]就是比T[stack.peek]的右边第一个大的数
            result[stack.peek] = i - stack.peek; // i - stack.peek 就是两个数的索引之差
            [stack pop]; // 删除这个栈顶元素，再循环，T[i]再和下一个栈顶元素比较
        }
        [stack push:i]; // 栈为空或T[i]小于栈顶元素。直接入栈。
    }
    return result;
}


/**
 解法2:倒推法
 index: 0   1   2   3   4   5   6   7
 value: 73 74  75   75  69  72  76  73
 
 index: 0   1   2   3   4   5   6   7
 days : 1   1   4   3   1   1   0   0
 
 从右往左找。首先能肯定最后的73度后面没有其他的了，所以days是0，
 当比较到index=3，value=75时， 此时days=3，再往左走一个的值跟index=3的值一样。 那么可以直接用
 index=3的days值加上1就是index=4的days的值。
 
 核心来说就是当前index利用之前已经计算过的大小关系。不用每次到一个index时都要和它之后的每一个只比较。
 
 
 */
int* dailyTemperatures2(int* T, int length){
    if (T == NULL || length == 0) return NULL;
    int * days = (int *)malloc(sizeof(int)*length);
    // 为啥 length - 2 ？因为最后温度对应的days肯定时0啊，所以它不需要参与计算。
    for (int i = length - 2; i >= 0; i--) { // 从右往左
        int j = i + 1; // 另一个索引，这个索引比i大1，当计算到i时，j肯定已经计算过了，可利用j。
        while (true) {
            if (T[i] < T[j]) { // 前面的小于后面的，不用说days就直接等于j-i
                days[i] = j - i;
                break; // 跳出循环进行，继续往左
            } else if (days[j] == 0) { // 这里就代表T[i] >= T[j]
                // 如果 days[j] 都等于0了，那比T[j]大的值，它的days[i]更得等于0了。
                days[i] = 0;
                break;
            }
            // 来到这里说明 T[i] >= T[j]，并且 days[j] ！= 0
            // 就另j回到那个比j大的那个值，之后下一轮比较，就是当前值T[i]和比j大的那个值比较了
            j = j + days[j];
        }
    }
    return days;
}
@end
