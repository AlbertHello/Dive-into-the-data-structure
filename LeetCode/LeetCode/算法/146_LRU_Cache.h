//
//  146_LRU_Cache.h
//  LeetCode
//
//  Created by 58 on 2020/10/27.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface _46_LRU_Cache : NSObject


-(instancetype)initWithCapacity:(NSUInteger)capacity;
-(NSInteger)get:(NSString *)key;
-(void)put:(NSString *)key value:(NSInteger)value;

+(void)LRU_Cache_Test;
@end

NS_ASSUME_NONNULL_END
