//
//  MyQueue.m
//  LeetCode
//
//  Created by 58 on 2020/12/3.
//

#import "MyQueue.h"

// 链表节点
@interface MyQueueNode : NSObject
@property(nonatomic,assign)int val;
@property(nonatomic,strong)MyQueueNode *next;
@end
@implementation MyQueueNode
- (instancetype)init{
    self = [super init];
    if (self) {
        self.val=0;
        self.next=nil;
    }
    return self;
}
@end


@interface MyQueue ()
@property(nonatomic,assign)int size;
@property(nonatomic,strong)MyQueueNode *first;
@property(nonatomic,strong)MyQueueNode *last;
@end

@implementation MyQueue
-(BOOL)isEmpty{
    return self.size == 0;
}
-(int)dequeue{
    if ([self isEmpty]) return -1;
    int val = self.first.val;
    MyQueueNode *first_node=self.first;
    if (self.size == 1) {
        self.first=nil;
        self.last=nil;
    }else{
        self.first=self.first.next;
    }
    first_node=nil;
    self.size--;
    return val;
}
-(int)peek{
    if ([self isEmpty]) return -1;
    return self.first.val;
}
-(void)enqueue:(int)val{
    MyQueueNode *new_node=[[MyQueueNode alloc]init];
    new_node.val=val;
    new_node.next=nil;
    if (self.size == 0) {
        self.first=new_node;
    }else{
        self.last.next=new_node;
    }
    self.last=new_node;
    self.size++;
}
@end
