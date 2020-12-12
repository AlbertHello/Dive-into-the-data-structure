//
//  ListNode_C.h
//  链表
//
//  Created by 58 on 2020/10/10.
//  Copyright © 2020 58. All rights reserved.
//

#ifndef ListNode_C_h
#define ListNode_C_h

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>


struct SingleLinkNode_1 {
    int val;
    struct SingleLinkNode_1 *next;
};
typedef struct SingleLinkNode_1 SingleNode_1;

struct SingleLink_1 {
    int size;
    SingleNode_1 *first;
};
typedef struct SingleLink_1 SingleLink_1;



SingleLink_1 *create_single_link_1(void);
void add_for_single_node_1(int val, SingleLink_1 *link);
void print_single_link_1(SingleLink_1 *link);
int min(int a, int b);
int max(int a, int b);
void swap(int *a, int *b);



#endif /* ListNode_C_h */
