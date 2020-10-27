//
//  BinaryHeap.h
//  二叉堆
//
//  Created by 58 on 2020/10/27.
//

#import <Foundation/Foundation.h>
#import "MJBinaryTreeInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface BinaryHeap : NSObject<MJBinaryTreeInfo>

@property(nonatomic,assign)NSUInteger bigHeap;//是否是大顶堆，默认是YES

int size(void); // 元素的数量
bool isEmpty(void); // 是否为空
void clear(void); // 清空
void add(int element); // 添加元素
int get(void); // 获得堆顶元素
int remove_ele(void); // 删除堆顶元素
int  replace(int element); // 删除堆顶元素的同时插入一个新元素


-(NSUInteger)size;
-(BOOL)isEmpty;
-(void)clear;
-(void)add:(int)ele;
-(int)getElement;
-(int)removeEle;
-(int)replace:(int)ele;
-(void)printHeap;

//create heap by big-batches
-(void)heapifyWith:(NSArray *)array;


@end

NS_ASSUME_NONNULL_END
