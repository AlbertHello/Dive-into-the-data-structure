//
//  _121_Best_Time_to_Buy_and_Sell_Stock.m
//  LeetCode
//
//  Created by 58 on 2020/12/5.
//

#import "_121_Best_Time_to_Buy_and_Sell_Stock.h"
#include "ListNode_C.h"
@implementation _121_Best_Time_to_Buy_and_Sell_Stock

/**
 121. 买卖股票的最佳时机
 https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock/
 难度 简单
 给定一个数组，它的第 i 个元素是一支给定股票第 i 天的价格。
 如果你最多只允许完成一笔交易（即买入和卖出一支股票一次），设计一个算法来计算你所能获取的最大利润。
 注意：你不能在买入股票前卖出股票。
 示例 1:
 输入: [7,1,5,3,6,4]
 输出: 5
 解释: 在第 2 天（股票价格 = 1）的时候买入，在第 5 天（股票价格 = 6）的时候卖出，最大利润 = 6-1 = 5 。
      注意利润不能是 7-1 = 6, 因为卖出价格需要大于买入价格；同时，你不能在买入前卖出股票。
 示例 2:
 输入: [7,6,4,3,1]
 输出: 0
 解释: 在这种情况下, 没有交易完成, 所以最大利润为 0。
 */

//时间复杂度O（n）
//空间复杂度O（1）
int maxProfit(int* prices, int pricesSize){
    if (prices == NULL || pricesSize == 0) return 0;
    // 前面扫描过的最小价格
    int minPrice = prices[0];
    // 前面扫描过的最大利润
    int maxProfit = 0;
    // 扫描所有的价格
    for (int i = 1; i < pricesSize; i++) {
        if (prices[i] < minPrice) {
            minPrice = prices[i];
        } else { // 把第i天的股票卖出
            maxProfit = max(maxProfit, prices[i] - minPrice);
        }
    }
    return maxProfit;
}

/**
 解法二：动态规划思想
 第i天买，第j天卖的利润湿第 i～j 天，所有相邻两天股价差的和
 所以相邻两天股价差如下：
 0～1 1～2 2～3 3～4 4～5
  -6   4   -2   3   -2
 于是就转化成了求【最大子序和】的问题
 
 动态规划一般分为一维、二维、多维（使用状态压缩），对应形式为dp(i)、 dp(i)(j)、 二进制dp(i)(j)。
 1. 动态规划做题步骤:
 明确dp(i) 应该表示什么（二维情况： dp(i)(j)）；
 根据dp(i) 和 dp(i−1) 的关系得出状态转移方程；
 确定初始条件，如 dp(0)。
 2 本题思路
 dp[i] 表示前 i 天的最大利润，因为我们始终要使利润最大化，则：dp[i] = max(dp[i−1],prices[i]−minprice)
 
 */

int maxProfit2(int* prices, int pricesSize){
    if (prices == NULL || pricesSize == 0) return 0;
    int *minus=(int *)malloc(sizeof(int)*(pricesSize-1));
    for (int i = 1; i<pricesSize; i++) {
        minus[i-1]=prices[i]-prices[i-1];
    }
    
    int pre = 0, maxAns = 0;
    for (int i =0; i< pricesSize-1; i++) {
        int num=minus[i];
        //拿前面加过的数和当前数相加，然后再和该数比较
        //如果pre + num的和比pre小，说明num是负数。
        //无论pre重新赋值为pre + num还是num逗比原先pre要小了
        pre = max(pre + num, num);
        //maxAns保存的是连续子数组元素之和最大值，pre计算完后和maxAns比较，
        //如果上一步出现了num为负数，那么maxAns和pre的比较肯定保留的是maxAns
        //有点儿像滚动数组的意思
        maxAns = max(maxAns, pre);
    }
    return maxAns;
}
/**
 状态转移方程
 dp[i][k][0] = max(dp[i-1][k][0], dp[i-1][k][1] + prices[i])
         max(   选择 rest  ,             选择 sell      )
 解释：今天我没有持有股票，有两种可能：
 要么是我昨天就没有持有，然后今天选择 rest，所以我今天还是没有持有；
 要么是我昨天持有股票，但是今天我 sell 了，所以我今天没有持有股票了。
 
 dp[i][k][1] = max(dp[i-1][k][1], dp[i-1][k-1][0] - prices[i])
         max(   选择 rest  ,           选择 buy   )
 解释：今天我持有着股票，有两种可能：
 要么我昨天就持有着股票，然后今天选择 rest，所以我今天还持有着股票；
 要么我昨天本没有持有，但今天我选择 buy，所以今天我就持有股票了。
 
 如果 buy，就要从利润中减去 prices[i]，如果 sell，就要给利润增加 prices[i]。今天的最大利润就是这两种可能选择中较大的那个。而且注意 k 的限制，我们在选择 buy 的时候，把 k 减小了 1，很好理解吧，当然你也可以在 sell 的时候减 1，一样的。
 basecase：
 dp[-1][k][0] = 0
 解释：因为 i 是从 0 开始的，所以 i = -1 意味着还没有开始，这时候的利润当然是 0 。
 dp[-1][k][1] = -infinity
 解释：还没开始的时候，是不可能持有股票的，用负无穷表示这种不可能。
 dp[i][0][0] = 0
 解释：因为 k 是从 1 开始的，所以 k = 0 意味着根本不允许交易，这时候利润当然是 0 。
 dp[i][0][1] = -infinity
 解释：不允许交易的情况下，是不可能持有股票的，用负无穷表示这种不可能。
 就是下面的：
 base case：
 dp[-1][k][0] = dp[i][0][0] = 0
 dp[-1][k][1] = dp[i][0][1] = -infinity
 状态转移方程：
 dp[i][k][0] = max(dp[i-1][k][0], dp[i-1][k][1] + prices[i])
 dp[i][k][1] = max(dp[i-1][k][1], dp[i-1][k-1][0] - prices[i])
 
 */
/**
 k=1, 只有一次交易
 dp[i][1][0] = max(dp[i-1][1][0], dp[i-1][1][1] + prices[i])
 dp[i][1][1] = max(dp[i-1][1][1], dp[i-1][0][0] - prices[i])=max(dp[i-1][1][1], -prices[i]) //k = 0的basecase所以 dp[i-1][0][0] = 0。
 现在发现 k 都是 1，不会改变，即 k 对状态转移已经没有影响了。
 可以进行进一步化简去掉所有 k：
 dp[i][0] = max(dp[i-1][0], dp[i-1][1] + prices[i])
 dp[i][1] = max(dp[i-1][1], -prices[i])
 得出：
 for (int i = 0; i < n; i++) {
     if (i - 1 == -1) {
         dp[i][0] = 0;
         // 解释：
         //   dp[i][0]
         // = max(dp[-1][0], dp[-1][1] + prices[i])
         // = max(0, -infinity + prices[i]) = 0
         dp[i][1] = -prices[i];
         //解释：
         //   dp[i][1]
         // = max(dp[-1][1], dp[-1][0] - prices[i])
         // = max(-infinity, 0 - prices[i])
         // = -prices[i]
         continue;
     }
     dp[i][0] = Math.max(dp[i-1][0], dp[i-1][1] + prices[i]);
     dp[i][1] = Math.max(dp[i-1][1], -prices[i]);
 }
 return dp[n - 1][0];
 其实不用整个 dp 数组，只需要一个变量储存相邻的那个状态就足够了，这样可以把空间复杂度降到 O(1):
 */
int maxProfit3(int* prices, int pricesSize){
    // base case: dp[-1][0] = 0, dp[-1][1] = -infinity
    int dp_i_0 = 0, dp_i_1 = INT_MIN;
    for (int i = 0; i < pricesSize; i++) {
        // dp[i][0] = max(dp[i-1][0], dp[i-1][1] + prices[i])
        dp_i_0 = max(dp_i_0, dp_i_1 + prices[i]);
        // dp[i][1] = max(dp[i-1][1], -prices[i])
        dp_i_1 = max(dp_i_1, -prices[i]);
    }
    return dp_i_0;
}

/**
 k = +infinity
 如果 k 为正无穷，那么就可以认为 k 和 k - 1 是一样的。可以这样改写框架：
 dp[i][k][0] = max(dp[i-1][k][0], dp[i-1][k][1] + prices[i])
 dp[i][k][1] = max(dp[i-1][k][1], dp[i-1][k-1][0] - prices[i])
        = max(dp[i-1][k][1], dp[i-1][k][0] - prices[i])
 我们发现数组中的 k 已经不会改变了，也就是说不需要记录 k 这个状态了：
 dp[i][0] = max(dp[i-1][0], dp[i-1][1] + prices[i])
 dp[i][1] = max(dp[i-1][1], dp[i-1][0] - prices[i])
 翻译成代码：
 int maxProfit_k_inf(int[] prices) {
     int n = prices.length;
     int dp_i_0 = 0, dp_i_1 = Integer.MIN_VALUE;
     for (int i = 0; i < n; i++) {
         int temp = dp_i_0;
         dp_i_0 = Math.max(dp_i_0, dp_i_1 + prices[i]);
         dp_i_1 = Math.max(dp_i_1, temp - prices[i]);
     }
     return dp_i_0;
 }
 */
int maxProfit_k_inf(int* prices, int pricesSize) {
    int dp_i_0 = 0, dp_i_1 = INT_MIN;
    for (int i = 0; i < pricesSize; i++) {
        int temp = dp_i_0;
        dp_i_0 = max(dp_i_0, dp_i_1 + prices[i]);
        dp_i_1 = max(dp_i_1, temp - prices[i]);
    }
    return dp_i_0;
}

/**
 k = +infinity with cooldown
 每次 sell 之后要等一天才能继续交易。只要把这个特点融入上一题的状态转移方程即可：
 dp[i][0] = max(dp[i-1][0], dp[i-1][1] + prices[i])
 dp[i][1] = max(dp[i-1][1], dp[i-2][0] - prices[i])
 解释：第 i 天选择 buy 的时候，要从 i-2 的状态转移，而不是 i-1 。
 */
int maxProfit_with_cool(int* prices, int pricesSize) {
    int dp_i_0 = 0, dp_i_1 = INT_MIN;
    int dp_pre_0 = 0; // 代表 dp[i-2][0]
    for (int i = 0; i < pricesSize; i++) {
        int temp = dp_i_0;
        dp_i_0 = max(dp_i_0, dp_i_1 + prices[i]);
        dp_i_1 = max(dp_i_1, dp_pre_0 - prices[i]);
        dp_pre_0 = temp;
    }
    return dp_i_0;
}

/**
 k = +infinity with fee
 每次交易要支付手续费，只要把手续费从利润中减去即可。改写方程：
 dp[i][0] = max(dp[i-1][0], dp[i-1][1] + prices[i])
 dp[i][1] = max(dp[i-1][1], dp[i-1][0] - prices[i] - fee)
 解释：相当于买入股票的价格升高了。
 在第一个式子里减也是一样的，相当于卖出股票的价格减小了。
 */
int maxProfit_with_fee(int* prices, int pricesSize, int fee) {
    int dp_i_0 = 0, dp_i_1 = INT_MIN;
    for (int i = 0; i < pricesSize; i++) {
        int temp = dp_i_0;
        dp_i_0 = max(dp_i_0, dp_i_1 + prices[i]);
        dp_i_1 = max(dp_i_1, temp - prices[i] - fee);
    }
    return dp_i_0;
}
/**
 k=2
 k = 2 和前面题目的情况稍微不同，因为上面的情况都和 k 的关系不太大。要么 k 是正无穷，状态转移和 k 没关系了；要么 k = 1，跟 k = 0 这个 base case 挨得近，最后也没有存在感。
 原始的动态转移方程，没有可化简的地方
 dp[i][k][0] = max(dp[i-1][k][0], dp[i-1][k][1] + prices[i])
 dp[i][k][1] = max(dp[i-1][k][1], dp[i-1][k-1][0] - prices[i])
 这道题由于没有消掉 k 的影响，所以必须要对 k 进行穷举：
 int max_k = 2;
 int[][][] dp = new int[n][max_k + 1][2];
 for (int i = 0; i < n; i++) {
     for (int k = max_k; k >= 1; k--) {
         if (i - 1 == -1) {  处理 base case }
         dp[i][k][0] = max(dp[i-1][k][0], dp[i-1][k][1] + prices[i]);
         dp[i][k][1] = max(dp[i-1][k][1], dp[i-1][k-1][0] - prices[i]);
     }
 }
 // 穷举了 n × max_k × 2 个状态，正确。
 return dp[n - 1][max_k][0];
 这里 k 取值范围比较小，所以可以不用 for 循环，直接把 k = 1 和 2 的情况全部列举出来也可以：
 dp[i][2][0] = max(dp[i-1][2][0], dp[i-1][2][1] + prices[i])
 dp[i][2][1] = max(dp[i-1][2][1], dp[i-1][1][0] - prices[i])
 dp[i][1][0] = max(dp[i-1][1][0], dp[i-1][1][1] + prices[i])
 dp[i][1][1] = max(dp[i-1][1][1], -prices[i])
 */
int maxProfit_k_2(int* prices,int pricesSize) {
    int dp_i10 = 0, dp_i11 = INT_MIN;
    int dp_i20 = 0, dp_i21 = INT_MIN;
    for (int i=0; i<pricesSize; i++) {
        int price = prices[i];
        dp_i20 = max(dp_i20, dp_i21 + price);
        dp_i21 = max(dp_i21, dp_i10 - price);
        dp_i10 = max(dp_i10, dp_i11 + price);
        dp_i11 = max(dp_i11, -price);
    }
    return dp_i20;
}

/**
 k = any integer
 有了上一题 k = 2 的铺垫，这题应该和上一题的第一个解法没啥区别。但是出现了一个超内存的错误，原来是传入的 k 值会非常大，dp 数组太大了。现在想想，交易次数 k 最多有多大呢？
 一次交易由买入和卖出构成，至少需要两天。所以说有效的限制 k 应该不超过 n/2，如果超过，就没有约束作用了，相当于 k = +infinity。这种情况是之前解决过的。
 直接把之前的代码重用：
 */
int maxProfit_k_any(int max_k, int *prices, int pricesSize) {
    if (max_k > pricesSize / 2) return maxProfit_k_inf(prices, pricesSize);
//    int dp[pricesSize][max_k+1][2]  ={0};
//    for (int i = 0; i < n; i++)
//        for (int k = max_k; k >= 1; k--) {
//            if (i - 1 == -1) { /* 处理 base case */ }
//            dp[i][k][0] = max(dp[i-1][k][0], dp[i-1][k][1] + prices[i]);
//            dp[i][k][1] = max(dp[i-1][k][1], dp[i-1][k-1][0] - prices[i]);
//        }
//    return dp[n - 1][max_k][0];
    return 0;
}

-(void)maxProfitTest{
    
}




@end
