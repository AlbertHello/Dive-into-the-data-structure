//
//  _969_PancakeSorting.m
//  LeetCode
//
//  Created by Albert on 2021/1/3.
//

#import "_969_PancakeSorting.h"

@interface _969_PancakeSorting ()


@property(nonatomic,strong)NSMutableArray<NSNumber*>*res;
@end


@implementation _969_PancakeSorting

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 记录反转操作序列
        self.res=[NSMutableArray array];
    }
    return self;
}


/**
 969. 煎饼排序
 难度 中等
 https://leetcode-cn.com/problems/pancake-sorting/
 给定数组 A，我们可以对其进行煎饼翻转：我们选择一些正整数 k <= A.length，然后反转 A 的前 k 个元素的顺序。我们要执行零次或多次煎饼翻转（按顺序一次接一次地进行）以完成对数组 A 的排序。
 返回能使 A 排序的煎饼翻转操作所对应的 k 值序列。任何将数组排序且翻转次数在 10 * A.length 范围内的有效答案都将被判断为正确。
 示例 1：
 输入：[3,2,4,1]
 输出：[4,2,4,3]
 解释：
 我们执行 4 次煎饼翻转，k 值分别为 4，2，4，和 3。
 初始状态 A = [3, 2, 4, 1]
 第一次翻转后 (k=4): A = [1, 4, 2, 3]
 第二次翻转后 (k=2): A = [4, 1, 2, 3]
 第三次翻转后 (k=4): A = [3, 2, 1, 4]
 第四次翻转后 (k=3): A = [1, 2, 3, 4]，此时已完成排序。
 示例 2：
 输入：[1,2,3]
 输出：[]
 解释：
 输入已经排序，因此不需要翻转任何内容。
 请注意，其他可能的答案，如[3，3]，也将被接受。
 */

/**
 如果我们找到了前 n 个烧饼中最大的那个，然后设法将这个饼子翻转到最底下，那么，原问题的规模就可以减小，递归调用 pancakeSort(A, n-1) 即可。
 接下来，对于上面的这 n - 1 块饼，如何排序呢？还是先从中找到最大的一块饼，然后把这块饼放到底下，再递归调用 pancakeSort(A, n-1-1)……
 你看，这就是递归性质，总结一下思路就是：
 1、找到 n 个饼中最大的那个。
 2、把这个最大的饼移到最底下。
 3、递归调用 pancakeSort(A, n - 1)。
 base case：n == 1 时，排序 1 个饼时不需要翻转。
 那么，最后剩下个问题，如何设法将某块烧饼翻到最后呢？
 其实很简单，比如第 3 块饼是最大的，我们想把它换到最后，也就是换到第 n 块。可以这样操作：
 1、用锅铲将前 3 块饼翻转一下，这样最大的饼就翻到了最上面。
 2、用锅铲将前 n 块饼全部翻转，这样最大的饼就翻到了第 n 块，也就是最后一块。
 
 唯一需要注意的是，数组索引从 0 开始，而我们要返回的结果是从 1 开始算的。
 
 算法的时间复杂度很容易计算，因为递归调用的次数是 n，每次递归调用都需要一次 for 循环，时间复杂度是 O(n)，所以总的复杂度是 O(n^2)。
 */


-(NSMutableArray<NSNumber*>* )pancakeSort:(int*) cakes size:(int)cakesSize{
    [self sort:cakes length:cakesSize];
    return self.res;
}

-(void)sort:(int*)cakes length:(int)n{
    // base case
    if (n == 1) return;
    // 寻找最大饼的索引
    int maxCake = 0;
    int maxCakeIndex = 0;
    for (int i = 0; i < n; i++){
        if (cakes[i] > maxCake) {
            maxCakeIndex = i;
            maxCake = cakes[i];
        }
    }
    // 第一次翻转，将最大饼翻到最上面
    [self reverseCakes:cakes from:0 to:maxCakeIndex];
    [self.res addObject:@(maxCakeIndex+1)];
    // 第二次翻转，将最大饼翻到最下面
    [self reverseCakes:cakes from:0 to:n-1];
    [self.res addObject:@(n)];

    // 递归调用
    [self sort:cakes length:n-1];
}

- (void)reverseCakes:(int *)cakes from:(int)i to:(int)j{
    while (i < j) {
        int temp = cakes[i];
        cakes[i] = cakes[j];
        cakes[j] = temp;
        i++; j--;
    }
}
@end
