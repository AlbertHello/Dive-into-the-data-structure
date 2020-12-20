//
//  PriorityQueue.m
//  优先级队列
//
//  Created by Albert on 2020/12/20.
//

#import "PriorityQueue.h"
#import "BinaryHeap.h"

@interface PriorityQueue ()
@property(nonatomic,strong)BinaryHeap *heap;
@end

@implementation PriorityQueue

-(instancetype)initWith:(PriorityComparator)comparator{
    if (self= [super init]) {
        self.heap=[[BinaryHeap alloc]init];
        self.heap.comparator=comparator;
    }
    return self;
}

-(NSUInteger)size{
    return [self.heap size];
}
-(BOOL)isEmpty{
    return [self.heap isEmpty];
}
-(void)clear{
    [self.heap clear];
}
-(void)enQueue:(int)ele {
    [self.heap add:ele];
}
-(int)deQueue{
    return [self.heap removeEle];
}
-(int)front{
    return [self.heap getElement];
}
-(void)printPQ{
    [self.heap printHeap];
}
@end
