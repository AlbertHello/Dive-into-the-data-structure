//
//  SingleLink.h
//  链表
//
//  Created by 58 on 2019/8/18.
//  Copyright © 2019 58. All rights reserved.
//

#ifndef SingleLink_h
#define SingleLink_h

#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>


typedef int Element;
typedef int Status;
static  int g_size=0;
#define Error 0
#define Success 1
//单链表定义
struct Node {
    Element data;
    struct Node *next;
};

typedef struct Node *Link;
//初始化
Status init_link(Link *link);
//插入
int insert_element(Element elem,Link head);
//在index下插入
Status insert_element_at_index(Element elem, int index, Link head);
//获取index下的node
Status node_of_index(int index, Link head, Link *node);
//删除
Status delete_element(int index,Element *data,Link head);
//更新
Status update_ele(int index, Element ele, Link head);
//根据ele查找index
int locate_ele_with_element(Element ele, Link head);
//清空
Status clearLink(Link head);
//打印
void printLink(Link link);
//是否为空
bool is_empty(Link head);
//获取链表长度
int get_link_length(void);
//越界检查
bool boundary_check(int index);

#endif /* SingleLink_h */
