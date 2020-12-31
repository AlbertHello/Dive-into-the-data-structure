//
//  _200_NumberofIslands.m
//  LeetCode
//
//  Created by 58 on 2020/12/31.
//

#import "_200_NumberofIslands.h"
#include "ListNode_C.h"

@implementation _200_NumberofIslands

/**
 200. 岛屿数量
 难度 中等
 https://leetcode-cn.com/problems/number-of-islands/
 给你一个由'1'（陆地）和 '0'（水）组成的的二维网格，请你计算网格中岛屿的数量。
 岛屿总是被水包围，并且每座岛屿只能由水平方向和/或竖直方向上相邻的陆地连接形成。
 此外，你可以假设该网格的四条边均被水包围。
 示例 1：

 输入：grid = [
   ["1","1","1","1","0"],
   ["1","1","0","1","0"],
   ["1","1","0","0","0"],
   ["0","0","0","0","0"]
 ]
 输出：1
 示例 2：

 输入：grid = [
   ["1","1","0","0","0"],
   ["1","1","0","0","0"],
   ["0","0","1","0","0"],
   ["0","0","0","1","1"]
 ]
 输出：3
 */

/**
 方法一：深度优先搜索
 
 我们可以将二维网格看成一个无向图，竖直或水平相邻的1之间有边相连
 为了求出岛屿的数量，我们可以扫描整个二维网格。如果一个位置为1，则以其为起始节点开始进行深度优先搜索。在深度优先搜索的过程中，每个搜索到的1 都会被重新标记为0。因为如果在上下左右四个方向搜索到挨着的1，说明他们是连着的，
 是同一块陆地，置为0后，防止for循环便利到此处把它又当作一个中心点进行上下左右搜寻。
 最终岛屿的数量就是我们进行深度优先搜索的次数。
 
 时间复杂度：O(MN)，其中M 和N 分别为行数和列数。
 空间复杂度：O(MN)，在最坏情况下，整个网格均为陆地，深度优先搜索的深度达到MN。
 */
void dfs(char**grid, int gridSize, int* gridColSize, int r, int c) {
    int nr = gridSize;
    int nc = *gridColSize;
    // 深度搜索过程中 会有r-1 r + 1 c - 1 c + 1，则需要判断越界
    // 深度搜索过程中碰到0其实就是以[r][c]为中心的上下左右搜索可以停止了
    // 因为碰到了水就意味着陆地到头了
    if (r < 0 || c < 0 || r >= nr || c >= nc || grid[r][c] == '0') {
        return;
    }
    // grid[r][c] = 1，标记为0
    grid[r][c] = '0';
    // 下面四行都是以[r][c]为中心点搜索上下左右四个方向，一直碰到水，才返回，然后搜索下一个方向。
    // grid[r-1][c] 是 grid[r][c] 的上方
    dfs(grid, gridSize, gridColSize, r - 1, c);
    // grid[r+1][c] 是 grid[r][c] 的下方
    dfs(grid, gridSize, gridColSize, r + 1, c);
    // grid[r][c-1] 是 grid[r][c] 的左边
    dfs(grid, gridSize, gridColSize, r, c - 1);
    // grid[r][c+1] 是 grid[r][c] 的右边
    dfs(grid, gridSize, gridColSize, r, c + 1);
}
int numIslands(char** grid, int gridSize, int* gridColSize){
    if (grid == NULL || gridSize == 0) return 0;
    
    int nr = gridSize;
    int nc = *gridColSize;
    
    int num_islands = 0;
    for (int r = 0; r < nr; ++r) {
        for (int c = 0; c < nc; ++c) {
            // 碰到1就是个新陆地， 则开始以1为中心往它的上下左右四个方向深度搜索
            // 搜索过程把遇到的1值为0，碰到1代表是两块陆地连载一起的，值为0防止for循环便利到它是重复计算
            if (grid[r][c] == '1') {
                ++num_islands;
                dfs(grid, gridSize, gridColSize, r, c);
            }
        }
    }
    return num_islands;
}

/**
 695. 岛屿的最大面积
 难度 中等
 https://leetcode-cn.com/problems/max-area-of-island/
 给定一个包含了一些 0 和 1 的非空二维数组 grid 。
 一个 岛屿 是由一些相邻的 1 (代表土地) 构成的组合，这里的「相邻」要求两个 1 必须在水平或者竖直方向上相邻。你可以假设 grid 的四个边缘都被 0（代表水）包围着。

 找到给定的二维数组中最大的岛屿面积。(如果没有岛屿，则返回面积为 0 。)
 */

/**
 此题和上题几乎相同，上题是找岛屿个数，这个是找到岛屿后求面积。那么可以这样做，在每次碰到一个1是就让面积+1不久完了。
 */
// dfs方法稍作修改
int dfs_area(int**grid, int gridSize, int* gridColSize, int r, int c) {
    int nr = gridSize;
    int nc = *gridColSize;
    // 深度搜索过程中 会有r-1 r + 1 c - 1 c + 1，则需要判断越界
    // 深度搜索过程中碰到0其实就是以[r][c]为中心的上下左右搜索可以停止了
    // 因为碰到了水就意味着陆地到头了
    if (r < 0 || c < 0 || r >= nr || c >= nc || grid[r][c] == 0) {
        return 0;
    }
    // 这里grid[r][c] = 1，标记为0后，此时面积要+1了
    grid[r][c] = 0;
    
    // 下面四行都是以[r][c]为中心点搜索上下左右四个方向，一直碰到水，才返回，然后搜索下一个方向。
    // grid[r-1][c] 是 grid[r][c] 的上方
    int area_top = dfs_area(grid, gridSize, gridColSize, r - 1, c);
    // grid[r+1][c] 是 grid[r][c] 的下方
    int area_bottom = dfs_area(grid, gridSize, gridColSize, r + 1, c);
    // grid[r][c-1] 是 grid[r][c] 的左边
    int area_left = dfs_area(grid, gridSize, gridColSize, r, c - 1);
    // grid[r][c+1] 是 grid[r][c] 的右边
    int area_right = dfs_area(grid, gridSize, gridColSize, r, c + 1);
    
    return 1 + area_top + area_bottom + area_left +area_right;
}
int maxAreaOfIsland(int** grid, int gridSize, int* gridColSize){
    if (grid == NULL || gridSize == 0) return 0;
    
    int nr = gridSize;
    int nc = *gridColSize;
    
    int area_islands = 0;
    for (int r = 0; r < nr; ++r) {
        for (int c = 0; c < nc; ++c) {
            // 碰到1就是个新陆地， 则开始以1为中心往它的上下左右四个方向深度搜索
            // 搜索过程把遇到的1值为0，碰到1代表是两块陆地连载一起的，值为0防止for循环便利到它是重复计算
            if (grid[r][c] == 1) {
                int area = dfs_area(grid, gridSize, gridColSize, r, c);
                area_islands = max(area_islands, area);
            }
        }
    }
    return area_islands;
}

/**
 463. 岛屿的周长
 难度 简单
 https://leetcode-cn.com/problems/island-perimeter/
 给定一个 row x col 的二维网格地图 grid ，其中：grid[i][j] = 1 表示陆地， grid[i][j] = 0 表示水域。
 网格中的格子 水平和垂直 方向相连（对角线方向不相连）。整个网格被水完全包围，但其中恰好有一个岛屿（或者说，一个或多个表示陆地的格子相连组成的岛屿）。 岛屿中没有“湖”（“湖” 指水域在岛屿内部且不和岛屿周围的水相连）。格子是边长为 1 的正方形。网格为长方形，且宽度和高度均不超过 100 。计算这个岛屿的周长。
 */

/**
 岛屿周长跟什么有关？跟边界和与水接触的边。我们在dfs时把碰到的1改成2，代表便利过了。
 1 碰到边界让周长加一
 2 碰到水让周长加1
 */
// dfs方法稍作修改
int dfs_circle(int**grid, int gridSize, int* gridColSize, int r, int c) {
    int nr = gridSize;
    int nc = *gridColSize;
    // 1 深度搜索过程中 会有r-1 r + 1 c - 1 c + 1，则需要判断越界。碰到边界加1
    // 深度搜索过程中碰到0其实就是以[r][c]为中心的上下左右搜索可以停止了
    // 2 因为碰到了水就意味着陆地到头了，所以周长加1
    if (r < 0 || c < 0 || r >= nr || c >= nc || grid[r][c] == 0) {
        return 1; // 加一
    }
    // 代表此处时遍历过的陆地不计算周长
    if (grid[r][c] == 2) {
        return 0;
    }
    // 这里grid[r][c] = 1，标记为2后
    grid[r][c] = 2;
    // 下面四行都是以[r][c]为中心点搜索上下左右四个方向，一直碰到水，才返回，然后搜索下一个方向。
    // grid[r-1][c] 是 grid[r][c] 的上方
    int area_top = dfs_circle(grid, gridSize, gridColSize, r - 1, c);
    // grid[r+1][c] 是 grid[r][c] 的下方
    int area_bottom = dfs_circle(grid, gridSize, gridColSize, r + 1, c);
    // grid[r][c-1] 是 grid[r][c] 的左边
    int area_left = dfs_circle(grid, gridSize, gridColSize, r, c - 1);
    // grid[r][c+1] 是 grid[r][c] 的右边
    int area_right = dfs_circle(grid, gridSize, gridColSize, r, c + 1);
    
    return area_top + area_bottom + area_left +area_right;
}
int islandPerimeter(int** grid, int gridSize, int* gridColSize){
    if (grid == NULL || gridSize == 0) return 0;
    
    int nr = gridSize;
    int nc = *gridColSize;
    
    for (int r = 0; r < nr; ++r) {
        for (int c = 0; c < nc; ++c) {
            // 碰到1就是个新陆地， 则开始以1为中心往它的上下左右四个方向深度搜索
            // 搜索过程把遇到的1值为0，碰到1代表是两块陆地连载一起的，值为0防止for循环便利到它是重复计算
            if (grid[r][c] == 1) {
                // 题目要求只有一个岛屿
                return  dfs_area(grid, gridSize, gridColSize, r, c);
            }
        }
    }
    return 0;
}
@end
