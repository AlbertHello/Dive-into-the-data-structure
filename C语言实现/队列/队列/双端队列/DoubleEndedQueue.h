//
//  DoubleEndedQueue.h
//  队列
//
//  Created by 58 on 2020/10/15.
//  Copyright © 2020 58. All rights reserved.
//

#ifndef DoubleEndedQueue_h
#define DoubleEndedQueue_h

#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include "DoubleLink.h"


//双端队列是头尾两端都能添加或删除的队列
//用双向链表实现


int doubleEndedQueue_size(void); // 元素的数量
bool doubleEndedQueue_isEmpty(void); // 是否为空
void doubleEndedQueue_clear(void); // 清空
void doubleEndedQueue_enQueueRear(int element); // 从队尾入队
int doubleEndedQueue_deQueueFront(void); // 从队头出队
void doubleEndedQueue_enQueueFront(int element); // 从队头入队
int  doubleEndedQueue_deQueueRear(void); // 从队尾出队
int doubleEndedQueue_front(void); // 获取队列的头元素
int doubleEndedQueue_rear(void);// 获取队列的的尾元素
void doubleEndedQueue_print(void);


#endif /* DoubleEndedQueue_h */
