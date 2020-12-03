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

@end
