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
-(int)dequeue;
-(void)enqueue:(int)val;
-(int)peek;

@end

NS_ASSUME_NONNULL_END
