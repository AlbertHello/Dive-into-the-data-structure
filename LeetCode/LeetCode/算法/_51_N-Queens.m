//
//  _51_N-Queens.m
//  LeetCode
//
//  Created by 58 on 2020/11/30.
//

#import "_51_N-Queens.h"


@interface _51_N_Queens()

//二维数组。表示棋盘
@property(nonatomic,strong)NSMutableArray<NSMutableArray<NSString *> *>*res;

@end

@implementation _51_N_Queens


-(instancetype)initWithNum:(int)n{
    if (self=[super init]) {
        self.res=[NSMutableArray array];
    }
    return self;
}

/**
 51. N 皇后
 n 皇后问题研究的是如何将 n 个皇后放置在 n×n 的棋盘上，并且使皇后彼此之间不能相互攻击。
 PS：皇后可以攻击同一行、同一列、左上左下右上右下四个方向的任意单位。
 每一种解法包含一个明确的 n 皇后问题的棋子放置方案，该方案中 'Q' 和 '.' 分别代表了皇后和空位。
 
 决策树的每一层表示棋盘上的每一行；每个节点可以做出的选择是，在该行的任意一列放置一个皇后。
 
 */

-(NSMutableArray<NSMutableArray<NSString *> *>*)solveNQueens:(int)n{
    
    // '.' 表示空，'Q' 表示皇后，初始化空棋盘。
    NSMutableArray<NSMutableArray<NSString *> *>*board=[NSMutableArray array];
    for (int i=0; i<n; i++) { // 行
        NSMutableArray<NSString *> *colum=[NSMutableArray array];
        for (int j=0; j<n; j++) { // 列
            [colum addObject:@"."]; // 用“.”初始化，表示棋盘是空的
        }
        [board addObject:colum];
    }
//    [self]
    return self.res;
}

// 路径：board 中小于 row 的那些行都已经成功放置了皇后
// 选择列表：第 row 行的所有列都是放置皇后的选择
// 结束条件：row 超过 board 的最后一行
-(void)backtrack:(NSMutableArray<NSMutableArray<NSString *> *>*)board, row:(int)row{
    // 触发结束条件
    if (row == column.count) {
        self.res
        [self.res addObjectsFromArray:board];
        return;
    }
    int n = board[row].size();
    for (int col = 0; col < n; col++) {
        // 排除不合法选择
        if (!isValid(board, row, col)) continue;
        // 做选择
        board[row][col] = 'Q';
        // 进入下一行决策
        backtrack(board, row + 1);
        // 撤销选择
        board[row][col] = '.';
    }
}
@end
