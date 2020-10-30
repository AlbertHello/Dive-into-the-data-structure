//
//  RBTree.m
//  红黑树
//
//  Created by 58 on 2020/10/29.
//

#import "RBTree.h"

@implementation RBTNode

-(instancetype)initWithColor:(BOOL)color{
    if (self = [super init]) {
        self.color=color;
    }
    return self;
}
@end

@implementation RBTree





-(void)afterAdd:(BSTNode *)node{
    BSTNode *parent=node.parent;
    //根节点
    if (parent==NULL) {
        [self black:parent];
        return;
    }
    
    //如果父节点是黑的，则满足四种情况直接返回不需要调整
    if ([self isBlack:parent]) return;
    
    //叔父节点
    BSTNode *uncle=[parent sibling];
    //祖父节点 同时把祖父节点染红
    BSTNode *grand=[self red:parent.parent];
    if ([self isRed:uncle]) {// 叔父节点是红色【B树节点上溢】
        [self black:parent];
        [self black:uncle];
        // 把祖父节点当做是新添加的节点
        [self afterAdd:grand];
    }
    
    // 叔父节点不是红色
    if ([parent isLeftChild]) { // L
        
        if ([node isLeftChild]) { // LL
            [self black:parent];
        } else { // LR
            [self black:node];
//            [self rotateLeft:parent];
        }
//        [self rotateLeft:grand];
    } else { // R
        if ([node isLeftChild]) { // RL
            [self black:node];
//            [self rotateRight:parent];
        } else { // RR
            [self black:parent];
        }
//        [self rotateLeft:grand];
    }
}












-(BSTNode *)resetColor:(BSTNode *)node color:(BOOL)color{
    if (node == nil) return nil;
    RBTNode *n=(RBTNode *)node;
    n.color=color;
    return n;
}
-(BSTNode *)red:(BSTNode *)node{
    return  [self resetColor:node color:RED];
}
-(BSTNode *)black:(BSTNode *)node{
    return  [self resetColor:node color:BLACK];
}
-(BOOL)colorOf:(BSTNode *)node{
    if (node == NULL) {
        return BLACK;
    }else{
        RBTNode *n=(RBTNode *)node;
        return n.color;
    }
}
-(BOOL)isBlack:(BSTNode *)node{
    return [self colorOf:node] == BLACK;
}
    
-(BOOL)isRed:(BSTNode *)node{
    return [self colorOf:node] == RED;
}
@end
