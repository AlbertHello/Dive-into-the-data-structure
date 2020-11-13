//
//  UnionFind_QU_Rank.m
//  LeetCode
//
//  Created by 58 on 2020/11/5.
//

#import "UnionFind_QU_Rank.h"


@interface UnionFind_QU_Rank ()
//树高度
@property(nonatomic,strong)NSMutableArray *tree_rank;
@end
@implementation UnionFind_QU_Rank

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tree_rank=[NSMutableArray array];
        for (int i=0; i<self.parents.count; i++) {
            //一开始初始化时，每个元素都是指向他自己的，也就是有n颗树，且每棵树只有一个节点，就是它本身
            // 所以树的高度是1
            self.tree_rank[i]=@1;
        }
    }
    return self;
}
//这样，通过⽐较树的高度，更能大概率的把树控制平衡，复杂度更好的确定在O（logn）
- (void)_unionItem1:(int)v1 item2:(int)v2{
    // 俩根结点
    int p1=[self _find:v1];
    int p2=[self _find:v2];
    if (p2==p1) return;
    //如果俩根节点不是同一个，则代表不在一个结合或者没有连通
    //以p1为根节点的树的大小
    int p1_tree_rank=[self.tree_rank[p1] intValue];
    //以p2为根节点的树的大小
    int p2_tree_rank=[self.tree_rank[p2] intValue];
    //把矮树拼接到高树上
    if (p1_tree_rank < p2_tree_rank) { // 小于
        self.parents[p1] = @(p2);
    } else if (p1_tree_rank > p2_tree_rank) { //大于
        self.parents[p2] = @(p1);
    } else { //等于
        //如果两树高度相等，谁拼接到谁都行，但记得要树的高度加一
        self.parents[p1] = @(p2);
        self.tree_rank[p2] = @(p2_tree_rank+1);
    }
}
@end
