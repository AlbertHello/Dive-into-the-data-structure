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
 
 相关题目：
 买卖股票的最佳时机（简单） k = 1 就是本题
 买卖股票的最佳时机 II（简单） k = +infinity（正无穷）
 买卖股票的最佳时机 III（困难）k = 2
 买卖股票的最佳时机 IV（困难） k = 任意整数
 最佳买卖股票时机含冷冻期（中等）k不限次数，但卖完之后隔一天才能再买
 买卖股票的最佳时机含手续费（中等） k不限次数，但每卖一笔都有手续费
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
 1 每天都有三种「选择」：买入、卖出、无操作，我们用 buy, sell, rest 表示这三种选择。但问题是，并不是每天都可以任意选择这三种选择的，因为 sell 必须在 buy 之后，buy 必须在 sell 之后。那么 rest 操作还应该分两种状态，一种是 buy 之后的 rest（持有了股票），一种是 sell 之后的 rest（没有持有股票）。而且别忘了，我们还有交易次数 k 的限制，就是说你 buy 还只能在 k > 0 的前提下操作。
 
 2 这个问题的「状态」有三个，第一个是天数，第二个是允许交易的最大次数，第三个是当前的持有状态（即之前说的 rest 的状态，我们不妨用 1 表示持有，0 表示没有持有）。然后我们用一个三维数组就可以装下这几种状态的全部组合：
 
 dp[i][k][0 or 1]
 0 <= i <= n-1, 1 <= k <= K
 n 为天数，大 K 为最多交易数
 此问题共 n × K × 2 种状态，全部穷举就能搞定。
 for 0 <= i < n:
     for 1 <= k <= K:
         for s in {0, 1}:
             dp[i][k][s] = max(buy, sell, rest)
 用自然语言描述出每一个状态的含义，比如说 dp[3][2][1] 的含义就是：今天是第三天，我现在手上持有着股票，至今最多进行 2 次交易。再比如 dp[2][3][0] 的含义：今天是第二天，我现在手上没有持有股票，至今最多进行 3 次交易。
 我们想求的最终答案是 dp[n - 1][K][0]，即最后一天，最多允许 K 次交易，最多获得多少利润。读者可能问为什么不是 dp[n - 1][K][1]？因为 [1] 代表手上还持有股票，[0] 表示手上的股票已经卖出去了，很显然后者得到的利润一定大于前者。
 
 3 状态转移方程：
 dp[i][k][0] = max(dp[i-1][k][0], dp[i-1][k][1] + prices[i])
               max(   选择 rest  ,             选择 sell     )
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
 dp[i][1][1] = max(dp[i-1][1][1], dp[i-1][0][0] - prices[i])
             = max(dp[i-1][1][1], -prices[i]) //k = 0的basecase所以 dp[i-1][0][0] = 0。
 现在发现 k 都是 1，不会改变，即 k 对状态转移已经没有影响了。
 可以进行进一步化简去掉所有 k：
 dp[i][0] = max(dp[i-1][0], dp[i-1][1] + prices[i])
 dp[i][1] = max(dp[i-1][1], -prices[i])
 得出：
 for (int i = 0; i < n; i++) {
     if (i - 1 == -1) {
         dp[i][0] = 0;
         // 解释：
         //   dp[i][0
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
     dp[i][0] = max(dp[i-1][0], dp[i-1][1] + prices[i]);
     dp[i][1] = max(dp[i-1][1], -prices[i]);
 }
 return dp[n - 1][0];
 其实不用整个 dp 数组，只需要一个变量储存相邻的那个状态就足够了，这样可以把空间复杂度降到 O(1):
 */
// k=1
int maxProfit3(int* prices, int pricesSize){
    int dp_i_0 = 0, dp_i_1 = INT_MIN;
    for (int i = 0; i < pricesSize; i++) {
        dp_i_0 = max(dp_i_0, dp_i_1 + prices[i]);
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
        dp_i_0 = max(temp, dp_i_1 + prices[i]);
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
        dp_i_0 = max(temp, dp_i_1 + prices[i]);
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
        dp_i_0 = max(temp, dp_i_1 + prices[i]);
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
    int rows=pricesSize;
    int cols=max_k;
    int dims=2;
    int ***dp=(int ***)malloc(sizeof(int)*rows*cols*dims);
    for (int i = 0; i < pricesSize; i++)
        for (int k = max_k; k >= 1; k--) {
            if (i - 1 == -1) {
                /* 处理 base case
                 dp[-1][k][0] = 0
                 解释：因为 i 是从 0 开始的，所以 i = -1 意味着还没有开始，这时候的利润当然是 0 。
                 dp[-1][k][1] = -infinity
                 解释：还没开始的时候，是不可能持有股票的，用负无穷表示这种不可能。
                 dp[i][0][0] = 0
                 解释：因为 k 是从 1 开始的，所以 k = 0 意味着根本不允许交易，这时候利润当然是 0 。
                 dp[i][0][1] = -infinity
                 解释：不允许交易的情况下，是不可能持有股票的，用负无穷表示这种不可能。
                 */
                dp[i][k][0] = dp[i][0][0] = 0;
                dp[i][k][1] = dp[i][0][1] = INT_MIN;
                continue;
            }
            dp[i][k][0] = max(dp[i-1][k][0], dp[i-1][k][1] + prices[i]);
            dp[i][k][1] = max(dp[i-1][k][1], dp[i-1][k-1][0] - prices[i]);
        }
    return dp[pricesSize - 1][max_k][0];
}
+(NSInteger)maxProfit_k_any:(NSArray<NSNumber *> *)prices maxK:(int)max_k{
    int length=(int)prices.count;
    if (max_k > prices.count / 2){
        int *p=(int *)malloc(sizeof(int)*length);
        for (int i=0; i<length; i++) {
            p[i]=((NSNumber *)prices[i]).intValue;
        }
        return (int)maxProfit_k_inf(p, length);
    }
    NSMutableArray<NSMutableArray<NSMutableArray<NSNumber *>*>*> *res=[NSMutableArray array];
    for (int i = 0; i < length; i++)
        for (int k = max_k; k >= 1; k--) {
            if (i - 1 == -1) {
                /* 处理 base case
                 dp[-1][k][0] = 0
                 解释：因为 i 是从 0 开始的，所以 i = -1 意味着还没有开始，这时候的利润当然是 0 。
                 dp[-1][k][1] = -infinity
                 解释：还没开始的时候，是不可能持有股票的，用负无穷表示这种不可能。
                 dp[i][0][0] = 0
                 解释：因为 k 是从 1 开始的，所以 k = 0 意味着根本不允许交易，这时候利润当然是 0 。
                 dp[i][0][1] = -infinity
                 解释：不允许交易的情况下，是不可能持有股票的，用负无穷表示这种不可能。
                 */
                res[i][k][0] = res[i][0][0] = @(0);
                res[i][k][1] = res[i][0][1] = @(INT_MIN);
                continue;
            }
            int max1=max(res[i-1][k][0].intValue, res[i-1][k][1].intValue + prices[i].intValue);
            res[i][k][0] = @(max1);
            int max2=max(res[i-1][k][1].intValue, res[i-1][k-1][0].intValue - prices[i].intValue);
            res[i][k][1] = @(max2);
        }
    return res[prices.count - 1][max_k][0].intValue;
}

void maxProfitTest(){
//    NSInteger value = [_121_Best_Time_to_Buy_and_Sell_Stock maxProfit_k_any:@[@(3),@(2),@(6),@(5),@(0),@(3)] maxK:2];
//    NSLog(@"%d",value);
    
    int a[]={3,2,6,5,0,3};
    printf("%d\n",maxProfit_k_2(a, 6));
    
}

    


@end
