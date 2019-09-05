//
//  DoubleLink.h
//  链表
//
//  Created by 58 on 2019/9/4.
//  Copyright © 2019 58. All rights reserved.
//

#ifndef DoubleLink_h
#define DoubleLink_h

#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>


typedef int Element;
typedef int Status;
static  int g_size_doubleLinkNode=0;
#define Error 0
#define Success 1
//双向链表定义
struct DoubleLinkNode {
    Element data;
    struct DoubleLinkNode *pre;
    struct DoubleLinkNode *next;
};

typedef struct DoubleLinkNode *DoubleLink;
//初始化
Status doubleLinkNode_init_link(DoubleLink *link);
//插入
int doubleLinkNode_insert_element(Element elem,DoubleLink head);
//在index下插入
Status doubleLinkNode_insert_element_at_index(Element elem, int index, DoubleLink head);
//获取index下的node
Status doubleLinkNode_node_of_index(int index, DoubleLink head, DoubleLink *node);
//删除
Status doubleLinkNode_delete_element(int index,Element *data,DoubleLink head);
//更新
Status doubleLinkNode_update_ele(int index, Element ele, DoubleLink head);
//根据ele查找index
int doubleLinkNode_locate_ele_with_element(Element ele, DoubleLink head);
//清空
Status doubleLinkNode_clearLink(DoubleLink head);
//打印
void doubleLinkNode_printLink(DoubleLink link);
//是否为空
bool doubleLinkNode_is_empty(DoubleLink head);
//获取链表长度
int doubleLinkNode_get_link_length(void);
//越界检查
bool doubleLinkNode_boundary_check(int index);

#endif /* DoubleLink_h */
