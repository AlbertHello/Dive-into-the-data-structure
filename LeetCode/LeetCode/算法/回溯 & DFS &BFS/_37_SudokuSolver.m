//
//  _37_SudokuSolver.m
//  LeetCode
//
//  Created by Albert on 2021/1/3.
//

#import "_37_SudokuSolver.h"

@implementation _37_SudokuSolver


/**
 37. 解数独
 难度 困难
 https://leetcode-cn.com/problems/sudoku-solver/
 编写一个程序，通过填充空格来解决数独问题。
 一个数独的解法需遵循如下规则：
 数字 1-9 在每一行只能出现一次。
 数字 1-9 在每一列只能出现一次。
 数字 1-9 在每一个以粗实线分隔的 3x3 宫内只能出现一次。
 空白格用 '.' 表示。
 */


/**
 
 当 j 到达超过每一行的最后一个索引时，转为增加 i 开始穷举下一行，并且在穷举之前添加一个判断，跳过不满足条件的数字.
 
 什么时候结束递归？显然 r == m 的时候就说明穷举完了最后一行，完成了所有的穷举，就是 base case。
 另外，前文也提到过，为了减少复杂度，我们可以让 backtrack 函数返回值为 boolean，如果找到一个可行解就返回 true，这样就可以阻止后续的递归。只找一个可行解.
 */

bool backtrack_shudu(char** board, int i, int j) {
    int m = 9, n = 9;
    if (j == n) {
        // 穷举到最后一列的话就换到下一行重新开始。
        return backtrack_shudu(board, i + 1, 0);
    }
    if (i == m) {
        // 找到一个可行解，触发 base case
        return true;
    }

    if (board[i][j] != '.') {
        // 如果有预设数字，不用我们穷举
        return backtrack_shudu(board, i, j + 1);
    }

    for (char ch = '1'; ch <= '9'; ch++) {
        // 如果遇到不合法的数字，就跳过
        if (!isValid_shudu(board, i, j, ch)) continue;

        board[i][j] = ch;
        // 如果找到一个可行解，立即结束
        if (backtrack_shudu(board, i, j + 1)) {
            return true;
        }
        board[i][j] = '.';
    }
    // 穷举完 1~9，依然没有找到可行解，此路不通
    return false;
}

// 判断 board[i][j] 是否可以填入 n
bool isValid_shudu(char** board, int r, int c, char n) {
    for (int i = 0; i < 9; i++) {
       // 判断行是否存在重复
       if (board[r][i] == n) return false;
       // 判断列是否存在重复
       if (board[i][c] == n) return false;
       // 判断 3 x 3 方框是否存在重复
       if (board[(r/3)*3 + i/3][(c/3)*3 + i%3] == n) return false;
   }
   return true;
}
@end
