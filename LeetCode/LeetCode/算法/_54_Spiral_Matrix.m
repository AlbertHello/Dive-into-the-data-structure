//
//  _54_Spiral_Matrix.m
//  LeetCode
//
//  Created by 58 on 2020/12/9.
//

#import "_54_Spiral_Matrix.h"

@implementation _54_Spiral_Matrix



/**
 54. 螺旋矩阵
 难度 中等
 https://leetcode-cn.com/problems/spiral-matrix/
 给定一个包含 m x n 个元素的矩阵（m 行, n 列），请按照顺时针螺旋顺序，返回矩阵中的所有元素。
 示例 1:
 输入:
 [
  [ 1, 2, 3 ],
  [ 4, 5, 6 ],
  [ 7, 8, 9 ]
 ]
 输出: [1,2,3,6,9,8,7,4,5]
 示例 2:

 输入:
 [
   [1, 2, 3, 4],
   [5, 6, 7, 8],
   [9,10,11,12]
 ]
 输出: [1,2,3,4,8,12,11,10,9,5,6,7]
 */

/**
 思路：
 实际的转圈其实是设置四个变量， top、bottom、left和right，分别表示最上面一行、最下面一行，最左边一列和最右边一列
 */

/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* spiralOrder(int** matrix, int matrixSize, int* matrixColSize, int* returnSize){
    if (matrix == NULL) return NULL;
    *returnSize=matrixSize*matrixColSize[0];
    int *res = (int *)malloc(sizeof(int)*(*returnSize));
    int top = 0; // 第1行
    int bottom = matrixSize - 1; // 最下面一行
    int left = 0;
    int right = *matrixColSize - 1; // 最右边一列
    int cur = 0;
    while (top <= bottom && left <= right) {
        // left top -> right top
        // top行：从左往右
        for (int i = left; i <= right; i++) {
            res[cur++] = matrix[top][i];
        }
        top++; // top行走完之后top往下移动一行，以备下次。

        // right top -> right bottom
        // 前面走完就走到最后一列了。这时从最后一列right从上到下
        for (int i = top; i <= bottom; i++) {
            res[cur++] = matrix[i][right];
        }
        right--; // right列走完之后right往左移动一列，以备下次。

        // 奇数行、偶数列的时候有问题
        if (top > bottom || left > right) break;

        // right bottom -> left bottom
        // 这时已经走到了矩阵的右下角。从右下角开始，走到左下角
        for (int i = right; i >= left; i--) {
            res[cur++] = matrix[bottom][i];
        }
        bottom--; // bottom行走完之后bottom往上移动一行，以备下次。

        // left bottom -> left top
        // 这时候走到了左下角，该从左下角往上走了
        for (int i = bottom; i >= top; i--) {
            res[cur++] = matrix[i][left];
        }
        left++; // left列走完之后left往右移动一列，以备下次。
    }
    return res;
}




@end
