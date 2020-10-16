//
//  CircleQueue.h
//  队列
//
//  Created by 58 on 2020/10/16.
//  Copyright © 2020 58. All rights reserved.
//

#ifndef CircleQueue_h
#define CircleQueue_h

#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>

//循环队列
//用数组实现，而且还得当容量不足时自动扩容


int circle_queue_size(void); // 元素的数量
bool circle_queue_isEmpty(void); // 是否为空
void circle_queue_clear(void); // 清空
void circle_queue_enQueue(int element); // 从队尾入队
int circle_queue_deQueue(void); // 从队头出队
int circle_queue_front(void); // 获取队列的头元素
void circle_queue_print(void);


#endif /* CircleQueue_h */
