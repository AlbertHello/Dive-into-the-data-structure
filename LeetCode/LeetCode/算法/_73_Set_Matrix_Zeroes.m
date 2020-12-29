//
//  _73_Set_Matrix_Zeroes.m
//  LeetCode
//
//  Created by 58 on 2020/12/29.
//

#import "_73_Set_Matrix_Zeroes.h"

@implementation _73_Set_Matrix_Zeroes

/**
 73. 矩阵置零
 难度 中等
 https://leetcode-cn.com/problems/set-matrix-zeroes/
 给定一个 m x n 的矩阵，如果一个元素为 0，则将其所在行和列的所有元素都设为 0。请使用原地算法。
 示例 1:
 输入:
 [
   [1,1,1],
   [1,0,1],
   [1,1,1]
 ]
 输出:
 [
   [1,0,1],
   [0,0,0],
   [1,0,1]
 ]
 示例 2:

 输入:
 [
   [0,1,2,0],
   [3,4,5,2],
   [1,3,1,5]
 ]
 输出:
 [
   [0,0,0,0],
   [0,4,5,0],
   [0,3,1,0]
 ]
 进阶:

 一个直接的解决方案是使用  O(mn) 的额外空间，但这并不是一个好的解决方案。
 一个简单的改进方案是使用 O(m + n) 的额外空间，但这仍然不是最好的解决方案。
 你能想出一个常数空间的解决方案吗？
 */

/**
 解法1
 时间复杂度：O(M×N)，其中 M 和 N 分别对应行数和列数。
 空间复杂度：O(M+N)。
 */
void setZeroes(int** matrix, int matrixSize, int* matrixColSize){
    int R = matrixSize;
    int C = *matrixColSize;
    
    // 记录matrix[i][j] == 0时的行号和列号
    int *rows = (int *)malloc(sizeof(int) * R);
    int *cols = (int *)malloc(sizeof(int) * C);
    for (int i=0; i<R; i++) { // O(m)
        rows[i]=-1; // 初始值为-1
    }
    for (int i=0; i<C; i++) { // O(n)
        cols[i]=-1; // 初始值为-1
    }
    // Essentially, we mark the rows and columns that are to be made zero
    for (int i = 0; i < R; i++) { // O(m*n)
      for (int j = 0; j < C; j++) {
        if (matrix[i][j] == 0) {
            rows[i]=0; // 记录下行号
            cols[j]=0; // 记录下列号
        }
      }
    }
    // Iterate over the array once again and using the rows and cols sets, update the elements.
    for (int i = 0; i < R; i++) { // O(m*n)
      for (int j = 0; j < C; j++) {
        if (rows[i] == 0 || cols[j] == 0) {
            // 置0
            matrix[i][j] = 0;
        }
      }
    }
}
/**
 解法2
 1 遍历整个矩阵，如果 cell[i][j] == 0 就将第 i 行和第 j 列的第一个元素标记。
 2 第一行和第一列的标记是相同的，都是 cell[0][0]，所以需要一个额外的变量告知第一列是否被标记，同时用 cell[0][0] 继续表示第一行的标记。
 3 然后，从第二行第二列的元素开始遍历，如果第 r 行或者第 c 列被标记了，那么就将 cell[r][c] 设为 0。这里第一行和第一列的作用就相当于方法一中的 row_set 和 column_set 。
 4 然后我们检查是否 cell[0][0] == 0 ，如果是则赋值第一行的元素为零。
 5 然后检查第一列是否被标记，如果是则赋值第一列的元素为零。
 
 时间复杂度：O(M×N)，其中 M 和 N 分别对应行数和列数。
 空间复杂度：O(1)。
 */
void setZeroes2(int** matrix, int matrixSize, int* matrixColSize){
    bool isCol = false; // 标记第一列，matrix[0][0]作为第一行的标记
    int R = matrixSize;
    int C = *matrixColSize;
    
    for (int i = 0; i < R; i++) {
        // 1 找第一列中是否有数字为0
        if (matrix[i][0] == 0) { // 看第一列中是否有数字为0，如果有，则标记isCol
            isCol = true;
        }
        // 2 找其行列中是否有值是0
        // 之后从第二列开始矩阵中的数 matrix[i][j]
        for (int j = 1; j < C; j++) {
            // 如果matrix[i][j]等于0，则吧该行的第一个数标记为0，该列第一个数标记为0
          if (matrix[i][j] == 0) {
              matrix[0][j] = 0;
              matrix[i][0] = 0;
            }
        }
    }
    
    // 上面跑完到此处， 第二行第二列开始 每行的行首或每列的列首数字就定了，如果是0，代表该行或该列出现过0
    // 3 检查从第二行第二列开始的其他行列
    // 从第二行第二列开始再次遍历数组，并利用上面生成的第一行和第一列的标记更新其他行列的元素。
    for (int i = 1; i < R; i++) {
      for (int j = 1; j < C; j++) {
        if (matrix[i][0] == 0 || matrix[0][j] == 0) {
            // 如果某行的第一个元素是0活着某列的第一个元素是0，则matrix[i][j] 职位0
          matrix[i][j] = 0;
        }
      }
    }
    // 4 检查第一行
    // matrix[0][0]作为第一行的标记，如果为0表示第一行中数字有的是0
    if (matrix[0][0] == 0) {
      for (int j = 0; j < C; j++) {
        matrix[0][j] = 0; // 则把整行置为0
      }
    }
    // 5 检查第一列
    // isCol 这是第一列的标记。
    if (isCol) {
      for (int i = 0; i < R; i++) {
        matrix[i][0] = 0; // 把第一列职位0
      }
    }
}







@end
