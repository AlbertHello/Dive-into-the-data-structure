//
//  RBTree.h
//  红黑树
//
//  Created by 58 on 2020/10/29.
//

#import <Foundation/Foundation.h>
#import "BST.h"

#define RED YES
#define BLACK NO

@interface RBTNode : BSTNode

@property(assign, nonatomic)BOOL color;

-(instancetype _Nonnull )initWithColor:(BOOL)color;

@end

NS_ASSUME_NONNULL_BEGIN

@interface RBTree : BST


-(BSTNode *)resetColor:(BSTNode *)node color:(BOOL)color;


@end

NS_ASSUME_NONNULL_END
