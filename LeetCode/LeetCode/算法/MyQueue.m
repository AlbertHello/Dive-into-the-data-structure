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
@property(nonatomic,strong)id obj;
@property(nonatomic,strong)MyQueueNode *next;
@end
@implementation MyQueueNode
- (instancetype)init{
    self = [super init];
    if (self) {
        self.val=0;
        self.next=nil;
        self.obj=nil;
    }
    return self;
}
@end


@interface MyQueue ()
@property(nonatomic,assign)int length;
@property(nonatomic,strong)MyQueueNode *front;
@property(nonatomic,strong)MyQueueNode *rear;
@end

@implementation MyQueue

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.length=0;
        self.front=nil;
        self.rear=nil;
    }
    return self;
}

-(BOOL)isEmpty{
    return self.length == 0;
}
-(int)size{
    return self.length;
}
// 简单类型
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
    self.length--;
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
    self.length++;
}

// 对象类型
-(id)dequeue_obj{
    if ([self isEmpty]) return nil;
    id val = self.front.obj;
    MyQueueNode *front_node=self.front;
    if (self.size == 1) {
        self.front=nil;
        self.rear=nil;
    }else{
        self.front=self.front.next;
    }
    front_node=nil;
    self.length--;
    return val;
}
-(void)enqueue_obj:(id)obj{
    MyQueueNode *new_node=[[MyQueueNode alloc]init];
    new_node.obj=obj;
    new_node.next=nil;
    if (self.size == 0) {
        self.front=new_node;
    }else{
        self.rear.next=new_node;
    }
    self.rear=new_node;
    self.length++;
}
-(id)peek_obj{
    if ([self isEmpty]) return nil;
    return self.front.obj;
}

@end
