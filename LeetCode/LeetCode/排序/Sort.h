//
//  Sort.h
//  LeetCode
//
//  Created by Albert on 2020/10/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Sort : NSObject


@property(nonatomic,assign)NSUInteger swapCount;
@property(nonatomic,assign)NSUInteger cmpCount;
@property(nonatomic,assign)CFAbsoluteTime time;


-(int )cmp:(int)v1 to:(int)v2;
-(void)swap:(int *) v1 with:(int *) v2;
-(void)swapObj:(NSObject *)obj1 with:(NSObject *)obj2;
@end

NS_ASSUME_NONNULL_END
