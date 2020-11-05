//
//  UnionFind_QU_Size.m
//  LeetCode
//
//  Created by 58 on 2020/11/5.
//

#import "UnionFind_QU_Size.h"

/**
 ⼀开始就是简单粗暴的把 p 所在的树接到 q 所在的树的根节点下⾯，
 那么这⾥就可能出现「头重脚轻」 的不平衡状况
 我们其实是希望， ⼩⼀些的树接到⼤⼀
 些的树下⾯， 这样就能避免头重脚轻， 更平衡⼀些
 解决⽅法是额外使⽤⼀个 size 数组，记录每棵树包含的节点数
 */
@interface UnionFind_QU_Size ()
@property(nonatomic,strong)NSMutableArray *tree_size;
@end
@implementation UnionFind_QU_Size

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tree_size=[NSMutableArray array];
        for (int i=0; i<self.parents.count; i++) {
            //一开始初始化时，每个元素都是指向他自己的，也就是有n颗树，且每棵树只有一个节点，就是它本身
            // 所以树的大小是1
            self.tree_size[i]=@1;
        }
    }
    return self;
}
//这样，通过⽐较树的重量，就可以保证树的⽣⻓相对平衡，树的⾼度⼤致在 logN 这个数量级，极⼤提升执⾏效率
//此时， find , union , connected 的时间复杂度都下降为 O(logN)， 即便数据
//规模上亿， 所需时间也⾮常少。
- (void)_unionItem1:(int)v1 item2:(int)v2{
    // 俩根结点
    int p1=[self _find:v1];
    int p2=[self _find:v2];
    if (p2==p1) return;
    //如果俩根节点不是同一个，则代表不在一个结合或者没有连通
    //以p1为根节点的树的大小
    int p1_tree_size=[self.tree_size[p1] intValue];
    //以p2为根节点的树的大小
    int p2_tree_size=[self.tree_size[p2] intValue];
    //把小树拼接到大树上
    if (p1_tree_size < p2_tree_size) {
        self.parents[p1]=@(p2);
        //拼接完后要记得把大树的大小更新
        self.tree_size[p2]= @(p2_tree_size+p1_tree_size);
    }else{
        self.parents[p2]=@(p1);
        self.tree_size[p1]= @(p2_tree_size+p1_tree_size);
    }
}
@end
