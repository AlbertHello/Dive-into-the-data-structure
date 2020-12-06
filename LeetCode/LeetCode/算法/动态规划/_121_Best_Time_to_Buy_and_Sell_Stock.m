//
//  _121_Best_Time_to_Buy_and_Sell_Stock.m
//  LeetCode
//
//  Created by 58 on 2020/12/5.
//

#import "_121_Best_Time_to_Buy_and_Sell_Stock.h"

@implementation _121_Best_Time_to_Buy_and_Sell_Stock

/**
 121. 买卖股票的最佳时机
 https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock/
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


int max_121(int a, int b){
    return a > b ? a : b;
}
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
            maxProfit = max_121(maxProfit, prices[i] - minPrice);
        }
    }
    return maxProfit;
}

/**
 解法二：动态规划思想
 第i天买，第j天卖的利润湿第 i～j 天哪，所有相邻两天股价差的和
 所以相邻两天股价差如下：
 0～1 1～2 2～3 3～4 4～5
  -6   4   -2   3   -2
 于是就转化成了求【最大子序和】的问题
 
 动态规划一般分为一维、二维、多维（使用状态压缩），对应形式为dp(i)、 dp(i)(j)、 二进制dp(i)(j)。
 1. 动态规划做题步骤:
 明确p(i) 应该表示什么（二维情况： dp(i)(j)）；
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
        pre = max_121(pre + num, num);
        //maxAns保存的是连续子数组元素之和最大值，pre计算完后和maxAns比较，
        //如果上一步出现了num为负数，那么maxAns和pre的比较肯定保留的是maxAns
        //有点儿像滚动数组的意思
        maxAns = max_121(maxAns, pre);
    }
    return maxAns;
}






@end
