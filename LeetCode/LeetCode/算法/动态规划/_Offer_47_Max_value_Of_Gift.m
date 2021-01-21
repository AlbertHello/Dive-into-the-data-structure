//
//  _Offer_47_Max_value_Of_Gift.m
//  LeetCode
//
//  Created by 58 on 2020/12/5.
//

#import "_Offer_47_Max_value_Of_Gift.h"

@implementation _Offer_47_Max_value_Of_Gift

/**
 剑指 Offer 47. 礼物的最大价值 ¥
 https://leetcode-cn.com/problems/li-wu-de-zui-da-jie-zhi-lcof/
 在一个 m*n 的棋盘的每一格都放有一个礼物，每个礼物都有一定的价值（价值大于 0）。你可以从棋盘的左上角开始拿格子里的礼物，并每次向右或者向下移动一格、直到到达棋盘的右下角。
 给定一个棋盘及其上面的礼物的价值，请计算你最多能拿到多少价值的礼物？
 示例 1:
 输入:
 [
   [1,3,1],
   [1,5,1],
   [4,2,1]
 ]
 输出: 12
 解释: 路径 1→3→5→2→1 可以拿到最多价值的礼物
 提示：
 0 < grid.length <= 200
 0 < grid[0].length <= 200
 */
/**
 动态规划思想：
 假设dp[row][col]是走到grid[row][col]位置时的最大价值，那如何走到[row][col]呢？
 有两种可能：
 从[row][col-1]往右走
 从[row-1][col]往下走
 只有第一行第一列是比较特殊的，因为第一行和第一列只有一种走法，要么往下走要么往右走

 其余的：
 dp[row][col] = max(dp[row - 1][col], dp[row][col - 1]) + grid[row][col];
 */
// 空间复杂度：O（m*n） 开辟了新数组dp
int maxValue(int** grid, int gridSize, int* gridColSize){
    int rows = gridSize; // 行数
    int cols = *gridColSize; // 列数
    int **dp=(int **)malloc(sizeof(int *)*(rows * cols));
    dp[0][0] = grid[0][0]; // 左上角的那个礼物的价值就直接赋值给dp
    // 第0行礼物只有一种路径才能拿到，那就是只能向右走
    for (int col = 1; col < cols; col++) {
        // 前一个礼物的dp价值加上本礼物的价值就是本礼物的dp价值
        dp[0][col] = dp[0][col - 1] + grid[0][col];
    }
    // 第0列礼物只有一种路径才能拿到，那就是只能向下走
    for (int row = 1; row < rows; row++) {
        //前一个礼物的dp价值加上本礼物的价值就是本礼物的dp价值
        dp[row][0] = dp[row - 1][0] + grid[row][0];
    }
    // 那么其他格子中的礼物要想拿到最大价值，就需要判断上面的dp[row - 1][col]和左面的dp[row][col-1]谁最大
    // 然后这个值再加上本礼物的价值grid[row][col]就是dp[row][col]
    for (int row = 1; row < rows; row++) { //行 从row=1开始哦
        for (int col = 1; col < cols; col++) { //列 从col=1开始哦
            dp[row][col] = max(dp[row - 1][col], dp[row][col - 1]) + grid[row][col];
        }
    }
    return dp[rows - 1][cols - 1];
}
// 优化
//// 空间复杂度：O（1）
int maxValue2(int** grid, int gridSize, int* gridColSize){
    int rows = gridSize; // 行数
    int cols = *gridColSize; // 列数
    for(int j = 1; j < cols; j++) // 初始化第一行
        grid[0][j] += grid[0][j - 1];
    for(int i = 1; i < rows; i++) // 初始化第一列
        grid[i][0] += grid[i - 1][0];
    for(int i = 1; i < rows; i++){
        for(int j = 1; j < cols; j++){
            grid[i][j] += max(grid[i][j - 1], grid[i - 1][j]);
        }
    }
    return grid[rows - 1][cols - 1];
}

@end
