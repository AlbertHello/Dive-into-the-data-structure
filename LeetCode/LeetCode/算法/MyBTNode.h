//
//  MyBTNode.h
//  LeetCode
//
//  Created by 58 on 2020/12/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyBTNode : NSObject
@property(assign, nonatomic)int val;
@property(strong, nonatomic,nullable)MyBTNode *parent;
@property(strong, nonatomic,nullable)MyBTNode *left;
@property(strong, nonatomic,nullable)MyBTNode *right;

-(instancetype)initWithParent:(MyBTNode *)p
                       lChild:(MyBTNode *)lc
                       rChild:(MyBTNode *)rc
                          val:(int)val;

@end


NS_ASSUME_NONNULL_END
