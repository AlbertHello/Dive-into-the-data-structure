//
//  Queue.h
//  队列
//
//  Created by 58 on 2019/9/21.
//  Copyright © 2019 58. All rights reserved.
//

#ifndef Queue_h
#define Queue_h

//队列的实现可以直接利用动态数组和链表，且优先使用双向链表，因为队列主要是对头尾进行操作。

#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include "DoubleLink.h"

typedef struct Queue{
    int data;
} QueueNode;

int size(void);
bool isEmpty(void);
void enQueue(int ele);
int deQueue(void);
int front(void);
void clear(void);
void printQueue(void);


#endif /* Queue_h */
