//
//  _59_Spiral_Matrix_II.cpp
//  C++ Algorithm
//
//  Created by 58 on 2021/3/3.
//

#include "_59_Spiral_Matrix_II.hpp"


/**
 59. 螺旋矩阵 II
 难度 中等
 https://leetcode-cn.com/problems/spiral-matrix-ii/
 给你一个正整数 n ，生成一个包含 1 到 n2 所有元素，且元素按顺时针顺序螺旋排列的 n x n 正方形矩阵 matrix 。
 示例 1：
 
 输入：n = 3
 输出：[[1,2,3],[8,9,4],[7,6,5]]
 示例 2：

 输入：n = 1
 输出：[[1]]
 
 */
namespace _59_Spiral_Matrix_II {

Spiral_Matrix_II::Spiral_Matrix_II(){
    
}
Spiral_Matrix_II::~Spiral_Matrix_II(){
    
}

vector<vector<int>> generateMatrix(int n) {
    // 创建二维矩阵
    vector<vector<int>> matrix;
    int top = 0;
    int bottom = n-1;
    int left = 0;
    int right = n-1;
    int num = 1, tar = n * n;

    while(num <= tar){
        for(int i=left; i <= right; i++) matrix[top][i] = num++;
        top++;
        for(int i=top; i <= bottom; i++) matrix[i][right] = num++;
        right--;
        for(int i=right; i >= left; i--) matrix[bottom][i] = num++;
        bottom--;
        for(int i=bottom; i >= top; i--) matrix[i][left] = num++;
        left++;
    }
    return matrix;
}

}
