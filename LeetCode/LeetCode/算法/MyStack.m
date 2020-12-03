//
//  MyStack.m
//  LeetCode
//
//  Created by 58 on 2020/12/3.
//

#import "MyStack.h"

@interface MyStack ()

@property(nonatomic,strong)NSMutableArray *container;

@end

@implementation MyStack

- (instancetype)init{
    self = [super init];
    if (self) {
        self.container=[NSMutableArray array];
    }
    return self;
}
-(BOOL)isEmpty{
    return self.container.count == 0;
}
-(int)peek{
    if ([self isEmpty]) return INT_MAX;
    NSNumber *last=self.container.lastObject;
    return last.intValue;
}
-(int)pop{
    int top = self.peek;
    if (top == -1) return top;
    [self.container removeLastObject];
    return top;
}
-(void)push:(int)val{
    [self.container addObject:@(val)];
}


@end
