//
//  _300_Longest_Increasing_Subsequence.m
//  LeetCode
//
//  Created by 58 on 2020/12/18.
//

#import "_300_Longest_Increasing_Subsequence.h"
#include "ListNode_C.h"

@implementation _300_Longest_Increasing_Subsequence

/**
 300. 最长递增子序列 ¥¥¥¥
 难度 中等
 https://leetcode-cn.com/problems/longest-increasing-subsequence/
 给你一个整数数组 nums ，找到其中最长严格递增子序列的长度。
 子序列是由数组派生而来的序列，删除（或不删除）数组中的元素而不改变其余元素的顺序。例如，[3,6,2,7] 是数组 [0,3,1,6,2,2,7] 的子序列。
 示例 1：
 输入：nums = [10,9,2,5,3,7,101,18]
 输出：4
 解释：最长递增子序列是 [2,3,7,101]，因此长度为 4 。
 示例 2：
 输入：nums = [0,1,0,3,2,3]
 输出：4
 示例 3：
 输入：nums = [7,7,7,7,7,7,7]
 输出：1
 提示：
 1 <= nums.length <= 2500
 -10^4 <= nums[i] <= 10^4
 
 进阶：
 你可以设计时间复杂度为 O(n2) 的解决方案吗？
 你能将算法的时间复杂度降低到 O(n log(n)) 吗?
 */

/**
 解法1 动态规划
 动态规划的核心设计思想是数学归纳法。
 相信大家对数学归纳法都不陌生，高中就学过，而且思路很简单。比如我们想证明一个数学结论，那么我们先假设这个结论在 k<n 时成立，然后想办法证明 k=n 的时候此结论也成立。如果能够证明出来，那么就说明这个结论对于 k 等于任何数都成立。
 类似的，我们设计动态规划算法，不是需要一个 dp 数组吗？我们可以假设 dp[0...i−1] 都已经被算出来了，然后问自己：怎么通过这些结果算出dp[i] ?
 首先要定义清楚 dp 数组的含义，即 dp[i] 的值到底代表着什么？
 dp[i] 表示以 nums[i] 这个数结尾的最长递增子序列的长度。
 根据这个定义，我们的最终结果（子序列的最大长度）应该是 dp 数组中的最大值。
 int res = 0;
 for (int i = 0; i < dp.length; i++) {
     res = max(res, dp[i]);
 }
 return res;
 
 怎么设计算法逻辑来正确计算每个 dp[i] 呢？
 这就是动态规划的重头戏了，要思考如何进行状态转移，这里就可以使用数学归纳的思想：
 我们已经知道了 dp[0...4] 的所有结果，我们如何通过这些已知结果推出 dp[5] 呢？
 index: 0 1 2 3 4 5
 value: 1 4 3 4 2 3
 
 dp   : 1 2 2 3 2 ?
 
 根据刚才我们对 dp 数组的定义，现在想求 dp[5] 的值，也就是想求以 nums[5] 为结尾的最长递增子序列。
 nums[5] = 3，既然是递增子序列，我们只要找到前面那些结尾比 3 小的子序列，然后把 3 接到最后，就可以形成一个新的递增子序列，而且这个新的子序列长度加一。
 当然，可能形成很多种新的子序列，但是我们只要最长的，把最长子序列的长度作为 dp[5] 的值即可:
 for (int j=0; j<i; j++){
    if (nums[j] < num[i]){
        dp[i] = max(dp[i], dp[j] + 1);
    }
 }
 还有一个细节问题，就是 base case。dp 数组应该全部初始化为 1，因为子序列最少也要包含自己，所以长度最小为 1。

 1 首先明确 dp 数组所存数据的含义。这步很重要，如果不得当或者不够清晰，会阻碍之后的步骤。
 2 然后根据 dp 数组的定义，运用数学归纳法的思想，假设 dp[0...i−1] 都已知，想办法求出 dp[i]，一旦这一步完成，整个题目基本就解决了。
 3 但如果无法完成这一步，很可能就是 dp 数组的定义不够恰当，需要重新定义 dp 数组的含义；或者可能是 dp 数组存储的信息还不够，不足以推出下一步的答案，需要把 dp 数组扩大成二维数组甚至三维数组。
 */

// 时间复杂度： O(n^2)
// 空间复杂度： O(n)
int lengthOfLIS(int* nums, int numsSize){
    if (nums == NULL) return 0;
    if (numsSize <= 1) return 1;
    int res = 0;
    // dp[i] 表示以 nums[i] 这个数结尾的最长递增子序列的长度。
    int *dp=(int *)malloc(sizeof(int)*numsSize);
    //memset(dp, 1, sizeof(int)*numsSize); 赋值为1，此函数不能用。打印每个数是16843009
    for (int i = 0; i < numsSize; i++) {
        dp[i]=1;
    }
    for (int i=1; i<numsSize; i++) {
        for (int j=0; j<i; j++){
           if (nums[j] < nums[i]){
               dp[i] = max(dp[i], dp[j] + 1);
           }
        }
    }
    for (int i = 0; i < numsSize; i++) {
        res = max(res, dp[i]);
    }
    free(dp);
    return res;
}


/**
 解法2 ：二分查找
 这个解法的时间复杂度会将为 O(NlogN).其实最长递增子序列和一种叫做 patience game 的纸牌游戏有关，甚至有一种排序方法就叫做 patience sorting（耐心排序）。
 首先，给你一排扑克牌，我们像遍历数组那样从左到右一张一张处理这些扑克牌，最终要把这些牌分成若干堆。
 处理这些扑克牌要遵循以下规则：
 只能把点数小的牌压到点数比它大的牌上。如果当前牌点数较大没有可以放置的堆，则新建一个堆，把这张牌放进去。如果当前牌有多个堆可供选择，则选择最左边的堆放置。
 比如说上述的扑克牌最终会被分成这样 5 堆（我们认为 A 的值是最大的，而不是 1）。
 为什么遇到多个可选择堆的时候要放到最左边的堆上呢？因为这样可以保证牌堆顶的牌有序（2, 4, 7, 8, Q），证明略
 按照上述规则执行，可以算出最长递增子序列，牌的堆数就是我们想求的最长递增子序列的长度，证明略
 我们只要把处理扑克牌的过程编程写出来即可。每次处理一张扑克牌不是要找一个合适的牌堆顶来放吗，牌堆顶的牌不是有序吗，这就能用到二分查找了：用二分查找来搜索当前牌应放置的位置。
 
 */
int lengthOfLIS2(int* nums, int numsSize){
    int *top=(int *)malloc(sizeof(numsSize));
    // 牌堆数初始化为0
    int piles=0;
    for (int i=0; i<numsSize; i++) {
        // 要处理的扑克牌
        int poker = nums[i];
        // 探测左侧边界的二分查找
        int left = 0, right = piles;
        while (left < right) {
            int mid = (left + right) / 2;
            if (top[mid] > poker) {
                right=mid;
            }else if (top[mid] < poker){
                left = mid+1;
            }else{
                right=mid;
            }
        }
        // 没找到合适的牌堆，新建一堆
        if (left == piles) {
            piles++;
        }
        // 把这张牌放到牌堆顶
        top[left]=poker;
    }
    // 牌堆数就是LIS 长度
    return piles;
}


void lengthOfLISTest(void){
    int a[]={10,9,2,5,3,7,101,18};
    printf(" %d\n",lengthOfLIS(a, 8));
}

@end
