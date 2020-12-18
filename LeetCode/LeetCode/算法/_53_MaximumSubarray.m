//
//  _53_MaximumSubarray.m
//  LeetCode
//
//  Created by 58 on 2020/12/18.
//

#import "_53_MaximumSubarray.h"
#include "ListNode_C.h"

@interface Status : NSObject

@property(nonatomic,assign)int lSum;
@property(nonatomic,assign)int rSum;
@property(nonatomic,assign)int mSum;
@property(nonatomic,assign)int iSum;

- (instancetype)initWithLsum:(int)lsum rsum:(int)rsum msum:(int)msum isum:(int)isum;
@end

@implementation Status
- (instancetype)initWithLsum:(int)lsum rsum:(int)rsum msum:(int)msum isum:(int)isum{
    self = [super init];
    if (self) {
        self.lSum=lsum;
        self.rSum=rsum;
        self.mSum=msum;
        self.iSum=isum;
    }
    return self;
}
@end


@implementation _53_MaximumSubarray

/**
 53. 最大子序和
 难度 简单
 链接：https://leetcode-cn.com/problems/maximum-subarray
 
 给定一个整数数组 nums ，找到一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。
 Example 1:

 Input: nums = [-2,1,-3,4,-1,2,1,-5,4]
 Output: 6
 Explanation: [4,-1,2,1] has the largest sum = 6.
 Example 2:

 Input: nums = [1]
 Output: 1
 Example 3:

 Input: nums = [0]
 Output: 0
 Example 4:

 Input: nums = [-1]
 Output: -1
 Example 5:

 Input: nums = [-2147483647]
 Output: -2147483647
 
 进阶:
 如果你已经实现复杂度为 O(n) 的解法，尝试使用更为精妙的分治法求解。
 */

int find_max(int num1, int num2){
    return num1>=num2 ? num1:num2;
}

//时间复杂度：O(n)，其中n 为 nums 数组的长度。我们只需要遍历一遍数组即可求得答案。
//空间复杂度：O(1)。我们只需要常数空间存放若干变量。
int maxSubArray(int* nums, int numsSize){
    int pre = 0, maxAns = nums[0];
    for (int i =0; i<numsSize; i++) {
        int num=nums[i];
        //拿前面加过的数和当前数相加，然后再和该数比较
        //如果pre + num的和比pre小，说明num是负数。
        //无论pre重新赋值为pre + num还是num逗比原先pre要小了
        pre = find_max(pre + num, num);
        //maxAns保存的是连续子数组元素之和最大值，pre计算完后和maxAns比较，
        //如果上一步出现了num为负数，那么maxAns和pre的比较肯定保留的是maxAns
        //有点儿像滚动数组的意思
        maxAns = find_max(maxAns, pre);
    }
    return maxAns;
}

/**
 分治
 
 对于一个区间[l,r]，我们可以维护四个量：
 lSum 表示[l,r] 内以l 为左端点的最大子段和
 rSum 表示[l,r] 内以r 为右端点的最大子段和
 mSum 表示[l,r] 内的最大子段和
 iSum 表示[l,r] 的区间和
 
 //时间复杂度：O(n)，其中n 为 nums 数组的长度。我们只需要遍历一遍数组即可求得答案。
 //空间复杂度：O(logn)。递归会使用O(logn) 的栈空间，故渐进空间复杂度为O(logn)。
 */
-(int)maxSubArray2:(int*)nums length:(int)numsSize{
    return [self getInfo:nums left:0 right:numsSize].mSum;
}
/**
 定义一个操作 get(a, l, r) 表示查询a 序列[l,r] 区间内的最大子段和，那么最终我们要求的答案就是 get(nums, 0, numssize)。如何分治实现这个操作呢？对于一个区间[l,r]，我们取m=(l+r)/2，
 对区间[l,m] 和 [m+1,r] 分治求解。当递归逐层深入直到区间长度缩小为1的时候，递归「开始回升」。
 这个时候我们考虑如何通过[l,m] 区间的信息和[m+1,r] 区间的信息合并成区间[l,r] 的信息。
 */
-(Status *)getInfo:(int *)a left:(int)l right:(int)r{
    if (l == r) {
        return [[Status alloc] initWithLsum:a[l] rsum:a[l] msum:a[l] isum:a[l]];
    }
    int m = (l + r) >> 1;
    Status *lSub = [self getInfo:a left:l right:m]; // [l, m)
    Status *rSub = [self getInfo:a left:m+1 right:r]; // [m+1, r)
    
    return [self pushUp:lSub r:rSub];
}
/**
 递归到底之后开始往上走，iSum就等于左右子区间的iSum相加
 1 首先最好维护的是 iSum，区间[l,r] 的 iSum 就等于「左子区间」的 iSum 加上「右子区间」的 iSum。
 
 2 对于[l,r] 的 lSum，存在两种可能，它要么等于「左子区间」的 lSum，要么等于「左子区间」的 iSum 加上「右子区间」的 lSum，二者取大。
 
 3 对于[l,r] 的 rSum，同理，它要么等于「右子区间」的 rSum，要么等于「右子区间」的 iSum 加上「左子区间」的 rSum，二者取大。
 
 4 当计算好上面的三个量之后，就很好计算[l,r] 的 mSum 了。我们可以考虑[l,r] 的 mSum 对应的区间是否跨越
 m。它可能不跨越m，也就是说[l,r] 的 mSum 可能是「左子区间」的 mSum 和 「右子区间」的 mSum 中的一个；它也可能跨越m，可能是「左子区间」的 rSum 和 「右子区间」的 lSum 求和。三者取大。
 
 */
-(Status *)pushUp:(Status*)l r:(Status *)r{
    int iSum = l.iSum + r.iSum;
    int lSum = max(l.lSum, l.iSum + r.lSum);
    int rSum = max(r.rSum, r.iSum + l.rSum);
    int mSum = max(max(l.mSum, r.mSum), l.rSum + r.lSum);
    return [[Status alloc] initWithLsum:lSum rsum:rSum msum:mSum isum:iSum];
}
/**
 「方法二」相较于「方法一」来说，时间复杂度相同，但是因为使用了递归，并且维护了四个信息的结构体，运行的时间略长，空间复杂度也不如方法一优秀，而且难以理解。那么这种方法存在的意义是什么呢？

 对于这道题而言，确实是如此的。但是仔细观察「方法二」，它不仅可以解决区间[0,n−1]，还可以用于解决任意的子区间
 [l,r] 的问题。如果我们把[0,n−1] 分治下去出现的所有子区间的信息都用堆式存储的方式记忆化下来，
 即建成一颗真正的树之后，我们就可以在O(logn) 的时间内求到任意区间内的答案，我们甚至可以修改序列中的值，
 做一些简单的维护，之后仍然可以在O(logn) 的时间内求到任意区间内的答案，对于大规模查询的情况下，
 这种方法的优势便体现了出来。这棵树就是上文提及的一种神奇的数据结构——线段树。
 
 */

@end
