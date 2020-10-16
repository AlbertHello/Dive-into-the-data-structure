//
//  DynamicArray.c
//  动态数组
//
//  Created by 58 on 2020/10/16.
//

#include "DynamicArray.h"

static int array_capaticty = 4;
static int *d_array=NULL;
static int array_size = 0;

void ensureCapacity(int capacity);
int range_check(int index);

void create_dynamic_array_list(void){
    if (!d_array) {
        d_array=(int *)malloc(sizeof(int)*array_capaticty);
    }
}
void create_dynamic_array_list_with_capaticty(int capaticty){
    array_capaticty = (capaticty < array_capaticty) ? array_capaticty : capaticty;
    create_dynamic_array_list();
}
void clear(void){
    array_size=0;
}
int size(void){
    return array_size;
}
bool is_empty(void){
    return array_size == 0;
}
bool contains(int ele){
    return index_of(ele) != -1;
}
void add(int ele){
    add_element_at(array_size, ele);
}
void add_element_at(int index, int ele){
    if (!range_check(index)) return ;
    ensureCapacity(array_size + 1);
    for (int i = array_size; i > index; i--) {
        d_array[i] = d_array[i - 1]; //从后开始，依次往后挪一个位置
    }
    d_array[index] = ele;
    array_size++;
}
int reset(int index, int ele){
    if (!range_check(index)) return -1;
    int old = d_array[index];
    d_array[index] = ele;
    return old;
}
int remove_element(int index){
    if (!range_check(index)) return -1;
    int old = d_array[index];
    for (int i = index + 1; i < array_size; i++) {
        d_array[i - 1] = d_array[i]; // 从被删掉的那个元素往后所有的元素依次往前挪一个
    }
    d_array[--array_size] = 0;
    return old;
}
int index_of(int ele){
    
    for (int i = 0; i < array_size; i++) {
        if (ele == d_array[i]) return i; // 最多遍历n次
    }
    return -1; //表示没找到
}
void print_array(void){
    if (array_size==0) return;
    int i=0;
    printf("size= %d, [",array_size);
    while (i<array_size) {
        printf(" %d",d_array[i++]);
    }
    printf(" ]\n");
}
void ensureCapacity(int cur_size) {
    int oldCapacity = array_capaticty;
    if (oldCapacity >= cur_size) return;
    // 新容量为旧容量的1.5倍
    int newCapacity = oldCapacity + (oldCapacity >> 1);
    array_capaticty=newCapacity;
    int *new_array=(int *)malloc(sizeof(int)*newCapacity);
    for (int i = 0; i < array_size; i++) {
        new_array[i] = d_array[i]; //把旧数组中的元素全部拷贝到新
    }
//    memcpy(new_array,d_array,sizeof(int)*array_size);
    free(d_array); // 释放旧数组
    d_array = new_array;
    printf("数组已扩容：oldSize: %d, newSize: %d\n",array_size,newCapacity);
}
int range_check(int index){
    if (index <0 || index > array_size) {
        return 0;
    }
    return 1;
}




