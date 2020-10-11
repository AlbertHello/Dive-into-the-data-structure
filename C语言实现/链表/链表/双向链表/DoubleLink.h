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
//双向链表节点定义
struct DoubleLinkNode {
    Element data;
    struct DoubleLinkNode *pre;
    struct DoubleLinkNode *next;
};
typedef struct DoubleLinkNode *DoubleLinkNode;

//双向链表定义
struct DoubleLink {
    int size;
    DoubleLinkNode first;// 头节点
    DoubleLinkNode last; // 尾节点
};
typedef struct DoubleLink *DoubleLink;

//创建
DoubleLink create_double_link(void);
//插入
int doubleLinkNode_insert_element(Element elem,DoubleLink d_link);
//在index下插入
Status doubleLinkNode_insert_element_at_index(Element elem, int index, DoubleLink d_link);
//获取index下的node
Status doubleLinkNode_node_of_index(int index, DoubleLink d_link, DoubleLinkNode *node);
//删除
Status doubleLinkNode_delete_element(int index,Element *data,DoubleLink d_link);
//更新
Status doubleLinkNode_update_ele(int index, Element ele, DoubleLink d_link);
//根据ele查找index
int doubleLinkNode_locate_ele_with_element(Element ele, DoubleLink d_link);
//清空
Status doubleLinkNode_clearLink(DoubleLink d_link);
//打印
void doubleLinkNode_printLink(DoubleLink d_link);
//是否为空
bool doubleLinkNode_is_empty(DoubleLink d_link);
//获取链表长度
int doubleLinkNode_get_link_length(DoubleLink d_link);

#endif /* DoubleLink_h */
