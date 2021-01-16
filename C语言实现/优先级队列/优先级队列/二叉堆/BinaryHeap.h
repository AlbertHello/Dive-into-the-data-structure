//
//  BinaryHeap.h
//  二叉堆
//
//  Created by 58 on 2020/10/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 自定义比较器
 // 小顶堆比较器
 int comparator1(int first,int second){
     return second-first;
 }
 // 大顶堆比较器
 int comparator2(int first,int second){
     return first-second;
 }
 */
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



/// C 实现 创建一个二叉堆
void create_heap(int capacity, bool big);
/// C 实现 添加元素
void add_top(int ele);
/// C 实现 删除堆顶元素
int remove_top(void);
/// C 实现 获取堆顶元素
int get_top(void);
/// C 实现 获取堆大小
int get_heap_size(void);
/// C 实现 获取结果
int *get_result(void);
/// C 实现 小顶堆 上滤
void shiftUp_C_for_small_heap(int index);
/// C 实现 小顶堆 下滤
void shiftdown_C_for_small_heap(int index);
/// C 实现 大顶堆 上滤
void shiftUp_C_for_big_heap(int index);
/// C 实现 大顶堆 下滤
void shiftdown_C_for_big_heap(int index);
@end

NS_ASSUME_NONNULL_END
