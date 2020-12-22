//
//  BinaryHeap.h
//  二叉堆
//
//  Created by 58 on 2020/10/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/// 自定义比较器
typedef int(*Comparator)(int first,int second);

@interface BinaryHeap : NSObject
/// 自定义比较器
@property(nonatomic,assign)Comparator comparator;

/// 元素的数量
-(NSUInteger)size;
// 是否为空
-(BOOL)isEmpty;
// 清空
-(void)clear;
// 添加元素
-(void)add:(int)ele;
// 获得堆顶元素
-(int)getElement;
// 删除堆顶元素
-(int)removeEle;
// 删除堆顶元素的同时插入一个新元素
-(int)replace:(int)ele;
-(void)printHeap;

//create heap by big-batches
-(void)heapifyWith:(NSArray *)array;


@end

NS_ASSUME_NONNULL_END
