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
@property(nonatomic,strong)MyQueueNode *front;
@property(nonatomic,strong)MyQueueNode *rear;
@end

@implementation MyQueue
-(BOOL)isEmpty{
    return self.size == 0;
}
-(int)dequeue{
    if ([self isEmpty]) return -1;
    int val = self.front.val;
    MyQueueNode *front_node=self.front;
    if (self.size == 1) {
        self.front=nil;
        self.rear=nil;
    }else{
        self.front=self.front.next;
    }
    front_node=nil;
    self.size--;
    return val;
}
-(int)peek{
    if ([self isEmpty]) return -1;
    return self.front.val;
}
-(void)enqueue:(int)val{
    MyQueueNode *new_node=[[MyQueueNode alloc]init];
    new_node.val=val;
    new_node.next=nil;
    if (self.size == 0) {
        self.front=new_node;
    }else{
        self.rear.next=new_node;
    }
    self.rear=new_node;
    self.size++;
}
@end
