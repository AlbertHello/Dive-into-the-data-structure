//
//  MyBTNode.m
//  LeetCode
//
//  Created by 58 on 2020/12/3.
//

#import "MyBTNode.h"

@implementation MyBTNode

- (instancetype)init{
    self = [super init];
    if (self) {
        self.val=0;
        self.parent=nil;
        self.left=nil;
        self.right=nil;
    }
    return self;
}
-(instancetype)initWithParent:(MyBTNode *)p
                       lChild:(MyBTNode *)lc
                       rChild:(MyBTNode *)rc
                          val:(int)val{
    self = [super init];
    if (self) {
        self.val=val;
        self.parent=p;
        self.left=lc;
        self.right=rc;
    }
    return self;
}
@end
