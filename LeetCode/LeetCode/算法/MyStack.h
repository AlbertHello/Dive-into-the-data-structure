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
-(int)peek;
-(int)pop;
-(void)push:(int)val;
@end

NS_ASSUME_NONNULL_END
