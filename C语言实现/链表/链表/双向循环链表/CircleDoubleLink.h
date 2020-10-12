//
//  CircleDoubleLink.h
//  链表
//
//  Created by 58 on 2019/9/5.
//  Copyright © 2019 58. All rights reserved.
//

#ifndef CircleDoubleLink_h
#define CircleDoubleLink_h

#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>


typedef int Element;
typedef int Status;
static  int g_size_circleDoubleLinkNode=0;
#define Error 0
#define Success 1
//双向链表节点定义
struct CircleDoubleLinkNode {
    Element data;
    struct CircleDoubleLinkNode *pre;
    struct CircleDoubleLinkNode *next;
};
typedef struct CircleDoubleLinkNode *CircleDoubleLinkNode;

//双向链表定义
struct CircleDoubleLink {
    int size;
    CircleDoubleLinkNode first;
    CircleDoubleLinkNode last;
};
typedef struct CircleDoubleLink *CircleDoubleLink;

//创建
CircleDoubleLink create_circle_double_link(void);

//插入
int circleDoubleLinkNode_insert_element(Element elem,CircleDoubleLink cd_link);
//在index下插入
Status circleDoubleLinkNode_insert_element_at_index(Element elem, int index, CircleDoubleLink cd_link);
//获取index下的node
Status circleDoubleLinkNode_node_of_index(int index, CircleDoubleLink cd_link, CircleDoubleLinkNode *node);
//删除
Status circleDoubleLinkNode_delete_element(int index,Element *data,CircleDoubleLink cd_link);
//更新
Status circleDoubleLinkNode_update_ele(int index, Element ele, CircleDoubleLink cd_link);
//根据ele查找index
int circleDoubleLinkNode_locate_ele_with_element(Element ele, CircleDoubleLink cd_link);
//清空
Status circleDoubleLinkNode_clearLink(CircleDoubleLink cd_link);
//打印
void circleDoubleLinkNode_printLink(CircleDoubleLink cd_link);
//是否为空
bool circleDoubleLinkNode_is_empty(CircleDoubleLink cd_link);
//获取链表长度
int circleDoubleLinkNode_get_link_length(void);
//越界检查
bool circleDoubleLinkNode_boundary_check(int index);

#endif /* CircleDoubleLink_h */
