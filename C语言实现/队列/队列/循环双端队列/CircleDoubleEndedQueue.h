//
//  CircleDoubleEndedQueue.h
//  队列
//
//  Created by 58 on 2020/10/16.
//  Copyright © 2020 58. All rights reserved.
//

#ifndef CircleDoubleEndedQueue_h
#define CircleDoubleEndedQueue_h

#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>

//循环队列
//用数组实现，而且还得当容量不足时自动扩容

int circle_d_queue_size(void); // 元素的数量
bool circle_d_queue_isEmpty(void); // 是否为空
void circle_d_queue_clear(void); // 清空
void circle_d_queue_enQueueRear(int element); // 从队尾入队
int circle_d_queue_deQueueFront(void); // 从队头出队
void circle_d_queue_enQueueFront(int element); // 从队头入队
int  circle_d_queue_deQueueRear(void); // 从队尾出队
int circle_d_queue_front(void); // 获取队列的头元素
int circle_d_queue_rear(void);// 获取队列的的尾元素
void circle_d_queue_print(void);


#endif /* CircleDoubleEndedQueue_h */
