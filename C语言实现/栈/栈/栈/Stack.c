//
//  Stack.c
//  栈
//
//  Created by 王启正 on 2019/9/13.
//  Copyright © 2019 58. All rights reserved.
//

#include "Stack.h"
static  Link stack=NULL;
bool init_stack(){
    if (init_link(&stack) == Error) {
        printf("stack init failed ,and exit 'push' func !");
        return false;
    }else{
        return true;
    }
}
void push(int element){
    if (!stack) {
        if (!init_stack()) return;
    }
    insert_element(element, stack);
}
int peek(void){
    if (!stack) {
        if (!init_stack()) return -1;
    }
    struct Node *top_node;
    if(node_of_index(size()-1, stack, &top_node)==Error){
        return -1;
    }
    return top_node->data;
}
int pop(void){
    if (!stack) {
        if (!init_stack()) return -1;
    }
    Element data=0;
    if (delete_element(get_link_length()-1, &data, stack)==Error) {
        printf("get top element failed ,and exit 'pop' func !");
        return -1;
    }
    return data;
}
int size(void){
    if (!stack) {
        if (!init_stack()) return -1;
    }
    return get_link_length();
}
bool isEmety(void){
    if (!stack) {
        if (!init_stack()) return true;
    }
    return is_empty(stack);
}
void print_stack(void){
    if (stack) {
        printf("栈顶到栈底元素排列如下：\n");
        while (!isEmety()) {
            printf("%d \n",peek());
        }
    }
}
