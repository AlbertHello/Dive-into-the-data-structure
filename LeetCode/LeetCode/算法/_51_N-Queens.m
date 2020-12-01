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
 https://leetcode-cn.com/problems/n-queens/
 n 皇后问题研究的是如何将 n 个皇后放置在 n×n 的棋盘上，并且使皇后彼此之间不能相互攻击。
 PS：皇后可以攻击同一行、同一列、左上左下右上右下四个方向的任意单位。
 每一种解法包含一个明确的 n 皇后问题的棋子放置方案，该方案中 'Q' 和 '.' 分别代表了皇后和空位。
 
 决策树的每一层表示棋盘上的每一行；每个节点可以做出的选择是，在该行的任意一列放置一个皇后。
 
 函数 backtrack 依然像个在决策树上游走的指针，通过 row 和 col 就可以表示函数遍历到的位置，通过 isValid 函数可以将不符合条件的情况剪枝
 
 当 N = 8 时，就是八皇后问题
 
 有的时候，我们并不想得到所有合法的答案，只想要一个答案，怎么办呢
 
 复杂度分析

 时间复杂度：O(N!)，其中N 是皇后数量。
 空间复杂度：O(N)，其中N是皇后数量。空间复杂度主要取决于递归调用层数、
 记录每行放置的皇后的列下标的数组以及三个集合，递归调用层数不会超过N，数组的长度为N，每个集合的元素个数都不会超过N
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
    [self backtrack:board row:0];
    return self.res;
}

// 路径：board 中小于 row 的那些行都已经成功放置了皇后
// 选择列表：第 row 行的所有列都是放置皇后的选择
// 结束条件：row 超过 board 的最后一行
-(void)backtrack:(NSMutableArray<NSMutableArray<NSString *> *>*)board
             row:(int)row{
    // 触发结束条件
    if (row == board.count) {
        [self.res removeAllObjects];
        [self.res addObjectsFromArray:board];
        return;
    }
    int colCount = (int)board[row].count; // 列数
    for (int col = 0; col < colCount; col++) {
        // 排除不合法选择
        if (![self isValid:board row:row col:col]) continue;
        // 做选择
        board[row][col] = @"Q";
        // 进入下一行决策
        [self backtrack:board row:row+1];
        // 撤销选择
        board[row][col] = @".";
    }
}
/*
 路径：board 中小于 row 的那些行都已经成功放置了皇后
 检查是否可以在 board[row][col] 放置皇后？就得需要检查
 */
-(BOOL)isValid:(NSMutableArray<NSMutableArray<NSString *> *>*)board
           row:(int)row
           col:(int)col{
    int colCount=(int)board.count; //即时行数也是列数，这里当作列数用
    // 检查列是否有皇后互相冲突
    for (int i = 0; i < row; i++) {
        //检查小雨row的这些行中的col列是否有放置过Q
        if ([board[i][col] isEqualToString:@"Q"]) return false;
    }
    // 检查右上方是否有皇后互相冲突 45度角是否有皇后
    for (int i = row - 1, j = col + 1; i >= 0 && j < colCount; i--, j++) {
        if ([board[i][j] isEqualToString:@"Q"]) return false;
    }
    // 检查左上方是否有皇后互相冲突 135度角是否有皇后
    for (int i = row - 1, j = col - 1; i >= 0 && j >= 0; i--, j--) {
        if ([board[i][j] isEqualToString:@"Q"]) return false;
    }
    return true;
}
//如果找到一种答案就退出：
-(BOOL)backtrack2:(NSMutableArray<NSMutableArray<NSString *> *>*)board
             row:(int)row{
    // 触发结束条件
    if (row == board.count) {
        [self.res removeAllObjects];
        [self.res addObjectsFromArray:board];
        return YES;
    }
    int colCount = (int)board[row].count; // 列数
    for (int col = 0; col < colCount; col++) {
        // 排除不合法选择
        if (![self isValid:board row:row col:col]) continue;
        // 做选择
        board[row][col] = @"Q";
        // 进入下一行决策,如果找到一种答案就退出了，不会再有下下面的撤销
        if( [self backtrack2:board row:row+1] ) return YES;
        // 撤销选择
        board[row][col] = @".";
    }
    return  NO;
}
@end
