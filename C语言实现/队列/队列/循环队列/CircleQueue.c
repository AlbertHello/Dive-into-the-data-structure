//
//  CircleQueue.c
//  队列
//
//  Created by 58 on 2020/10/16.
//  Copyright © 2020 58. All rights reserved.
//

#include "CircleQueue.h"
#include <string.h>


static int * c_queue=NULL;
static int array_capaticty = 10;
static int array_size = 0;
static int front = 0; // 对头index索引值

void check_cqueue(void){
    if (!c_queue) {
        c_queue=(int *)malloc(sizeof(int)*array_capaticty);
        memset(c_queue,0,sizeof(int)*array_capaticty);
    }
}
int get_new_index(int index){
    //这里主要是处理循环队列的
    //front代表对头元素的索引，所以可能是数组中任意一个index，不一定是数组的头部
    //入队时：index=(front+size)%array_capaticty
    //所以出队时：front = (front+1)%array_capaticty
    //因为模的效率不高，换成下面的公式n = n - (n >= m ? m : 0)
    /**
     其实模的操作可以拆成下面的式子
     int n = 13;
     int m = 7;
     int result=0
     if (n >= m) { // 这里注意的是n<2m才能满足n - m
        result = n - m;
     } else {
        result = n;
     }
     
     n%m 等价于 n – (m > n ? 0 : m) 的前提条件： n < 2m
     */
    index += front;
    return index - (index >= array_capaticty ? array_capaticty : 0);
}
void ensureCapacity(int cur_size) {
    int oldCapacity = array_capaticty;
    if (oldCapacity >= cur_size) return;
    
    // 新容量为旧容量的1.5倍
    int newCapacity = oldCapacity + (oldCapacity >> 1);
    int *new_c_queue=(int *)malloc(sizeof(int)*array_capaticty);
    memset(new_c_queue,0,sizeof(int)*array_capaticty);
    for (int i = 0; i < array_size; i++) {
        //新数组的下标从0开始
        //但旧数组的下标是从front开始的：index=(i+front)%array_capaticty
        new_c_queue[i] = c_queue[get_new_index(i)];
    }
    free(c_queue);
    c_queue = new_c_queue;
    array_capaticty=newCapacity;
    // 重置front
    front = 0;
    printf("循环队列已扩容：oldSize: %d, newSize: %d\n",oldCapacity,newCapacity);
}
// 元素的数量
int circle_queue_size(void){
    return array_size;
}
// 是否为空
bool circle_queue_isEmpty(void){
    return array_size == 0;
}
// 清空
void circle_queue_clear(void){
    check_cqueue();
    // 如果存储的是对象类型，则释放时需要循环遍历，把每个元素置位NULL，断开对对象的强引用
    memset(c_queue,0,sizeof(int)*array_capaticty);
    front=0;
    array_size=0;
}
// 从队尾入队
void circle_queue_enQueue(int element){
    check_cqueue();
    ensureCapacity(array_size + 1);
    //如果不是循环则就是往后追加元素：c_queue[array_size]=element
    //循环就得计算模
    c_queue[get_new_index(array_size)] = element;
    array_size++;
}
// 从队头出队
int circle_queue_deQueue(void){
    check_cqueue();
    int frontElement = c_queue[front];
    c_queue[front] = 0;//如果存储的是对象类型，需要c_queue[front]=null,断开对对对象的强引用
    //循环，对头出去以后，front+1
    front = get_new_index(1);
    array_size--;
    return frontElement;
}
// 获取队列的头元素
int circle_queue_front(void){
    check_cqueue();
    return c_queue[front];;
}
void circle_queue_print(void){
    if (array_size==0) return;
    check_cqueue();
    int i=0;
    printf("size= %d, front= %d, [",array_size,front);
    while (i<array_capaticty) {
        printf(" %d",c_queue[i++]);
    }
    printf(" ]\n");
}

