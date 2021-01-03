//
//  MyStack.h
//  LeetCode
//
//  Created by 58 on 2020/12/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyStack : NSObject
-(BOOL)isEmpty;
-(int)size;

// 简单类型
-(int)peek;
-(int)pop;
-(void)push:(int)val;

// 对象类型
-(id)peek_obj;
-(id)pop_obj;
-(void)push_obj:(id)obj;
@end

NS_ASSUME_NONNULL_END
