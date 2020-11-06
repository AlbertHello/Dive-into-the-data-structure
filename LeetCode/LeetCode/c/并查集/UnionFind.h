//
//  UnionFind.h
//  LeetCode
//
//  Created by 58 on 2020/11/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UnionFind : NSObject

@property(nonatomic,assign)NSUInteger capacity;
@property(nonatomic,strong)NSMutableArray *parents;

-(instancetype)initWithCapacity:(int)capacity;
-(int)_find:(int)val;
-(void)_unionItem1:(int)v1 item2:(int)v2;
-(bool)isConnected:(int)v1 item2:(int)v2;
-(BOOL)rangeCheck:(int)v;

@end

NS_ASSUME_NONNULL_END
