//
//  MyQueue.h
//  LeetCode
//
//  Created by 58 on 2020/12/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyQueue : NSObject

-(BOOL)isEmpty;
-(int)size;

// 简单类型
-(int)dequeue;
-(void)enqueue:(int)val;
-(int)peek;

// 对象类型
-(id)dequeue_obj;
-(void)enqueue_obj:(id)obj;
-(id)peek_obj;



@end

NS_ASSUME_NONNULL_END
