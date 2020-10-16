//
//  DynamicArray.h
//  动态数组
//
//  Created by 58 on 2020/10/16.
//

#ifndef DynamicArray_h
#define DynamicArray_h

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

void create_dynamic_array_list(void);
void create_dynamic_array_list_with_capaticty(int capaticty);

void clear(void);
int size(void);
bool is_empty(void);
bool contains(int ele);
void add(int ele);
void add_element_at(int index, int ele);
int reset(int index, int ele);
int remove_element(int index);
int index_of(int ele);
void print_array(void);


#endif /* DynamicArray_h */
