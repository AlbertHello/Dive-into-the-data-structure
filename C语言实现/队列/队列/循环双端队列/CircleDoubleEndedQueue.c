//
//  CircleDoubleEndedQueue.c
//  队列
//
//  Created by 58 on 2020/10/16.
//  Copyright © 2020 58. All rights reserved.
//

#include "CircleDoubleEndedQueue.h"
#include <string.h>

static int * c_d_queue=NULL;
static int array_capaticty = 10;
static int array_size = 0;
static int front = 0; // 对头index索引值,不需要设置rear队尾指针，因为front+size-1就等于rear，

void circle_d_queue_check_cqueue(void){
    if (!c_d_queue) {
        c_d_queue=(int *)malloc(sizeof(int)*array_capaticty);
        memset(c_d_queue,0,sizeof(int)*array_capaticty);
    }
}
int circle_d_queue_get_new_index(int index){
    index += front;
    if (index < 0) {
        //比如front=0时，再往前面插入元素，index=-1了就。
        //那么front应该走到数组最后面，当做对头
        //负数直接加上数组长度array_capaticty就等于得到数组最后面那个index
        return index + array_capaticty;
    }
    return index - (index >= array_capaticty ? array_capaticty : 0);
}
void circle_d_queue_ensure_capacity(int cur_size) {
    int oldCapacity = array_capaticty;
    if (oldCapacity >= cur_size) return;
    
    // 新容量为旧容量的1.5倍
    int newCapacity = oldCapacity + (oldCapacity >> 1);
    int *new_c_d_queue=(int *)malloc(sizeof(int)*newCapacity);
    memset(new_c_d_queue,0,sizeof(int)*newCapacity);
    for (int i = 0; i < array_size; i++) {
        //新数组的下标从0开始
        //但旧数组的下标是从front开始的：index=(i+front)%array_capaticty
        int index=circle_d_queue_get_new_index(i);
        new_c_d_queue[i] = c_d_queue[index];
    }
    free(c_d_queue);
    c_d_queue = new_c_d_queue;
    array_capaticty=newCapacity;
    // 重置front
    front = 0;
    printf("循环队列已扩容：oldSize: %d, newSize: %d\n",oldCapacity,newCapacity);
}

// 元素的数量
int circle_d_queue_size(void){
    return array_size;
}
// 是否为空
bool circle_d_queue_isEmpty(void){
    return array_size == 0;
}
// 清空
void circle_d_queue_clear(void){
    circle_d_queue_check_cqueue();
    // 如果存储的是对象类型，则释放时需要循环遍历，把每个元素置位NULL，断开对对象的强引用
    memset(c_d_queue,0,sizeof(int)*array_capaticty);
    front = 0;
    array_size = 0;
}
// 从队尾入队
void circle_d_queue_enQueueRear(int element){
    circle_d_queue_check_cqueue();
    circle_d_queue_ensure_capacity(array_size+ 1); // 添加元素先准备扩容操作
    //正常情况就是从队尾入队，就是在数组后追加，就是c_d_queue[array_size]=new_element
    int index = circle_d_queue_get_new_index(array_size);
    c_d_queue[index] = element;
    array_size++;
}
// 从队头出队
int circle_d_queue_deQueueFront(void){
    circle_d_queue_check_cqueue();
    int frontElement = c_d_queue[front];
    //如果存储的是对象类型，需要c_queue[front]=null,断开对对对象的强引用
    c_d_queue[front] = 0;
    //循环，对头出去以后，front+1
    front = circle_d_queue_get_new_index(1);
    array_size--;
    return frontElement;
}
// 从队头入队
void circle_d_queue_enQueueFront(int element){
    circle_d_queue_check_cqueue();
    // 添加元素先准备扩容操作
    circle_d_queue_ensure_capacity(array_size + 1);
    //在数组前面追加元素就得减一嘛，减一就有可能得到负数
    front = circle_d_queue_get_new_index(-1);
    c_d_queue[front] = element;
    array_size++;
}
// 从队尾出队
int  circle_d_queue_deQueueRear(void){
    circle_d_queue_check_cqueue();
    //正常情况就是获取数组的最后一个元素嘛：array_size-1
    int rearIndex = circle_d_queue_get_new_index(array_size - 1);
    int rear = c_d_queue[rearIndex];
    //如果存储的是对象类型，需要c_queue[rearIndex]=null,断开对对对象的强引用
    c_d_queue[rearIndex] = 0;
    array_size--;
    return rear;
}
// 获取队列的头元素
int circle_d_queue_front(void){
    circle_d_queue_check_cqueue();
    return c_d_queue[front];
}
// 获取队列的的尾元素
int circle_d_queue_rear(void){
    circle_d_queue_check_cqueue();
    int rearIndex = circle_d_queue_get_new_index(array_size - 1);
    return c_d_queue[rearIndex];
}
void circle_d_queue_print(void){
    if (array_size==0) return;
    circle_d_queue_check_cqueue();
    int i=0;
    printf("size= %d, front= %d, [",array_size,front);
    while (i<array_capaticty) {
        printf(" %d",c_d_queue[i++]);
    }
    printf(" ]\n");
}
