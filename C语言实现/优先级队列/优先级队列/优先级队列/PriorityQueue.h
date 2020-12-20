//
//  PriorityQueue.h
//  优先级队列
//
//  Created by Albert on 2020/12/20.
//

#import <Foundation/Foundation.h>
/// 自定义比较器  first < second   升序，first = second   相等，first > second   降序
typedef int(*PriorityComparator)(int first,int second);

NS_ASSUME_NONNULL_BEGIN

@interface PriorityQueue : NSObject

-(instancetype)initWith:(PriorityComparator)comparator;
-(NSUInteger)size;
-(BOOL)isEmpty;
-(void)clear;
-(void)enQueue:(int)ele;
-(int)deQueue;
-(int)front;
-(void)printPQ;


@end

NS_ASSUME_NONNULL_END
