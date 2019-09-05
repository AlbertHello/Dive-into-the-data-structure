//
//  CircleSingleLink.h
//  链表
//
//  Created by 58 on 2019/9/3.
//  Copyright © 2019 58. All rights reserved.
//

#ifndef CircleSingleLink_h
#define CircleSingleLink_h

#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>

typedef int Element;
typedef int Status;
static  int g_size_of_circleSingleLink=0;
#define Error 0
#define Success 1

///单向循环链表定义
struct NodeOfCircleSingle {
    Element data;
    struct NodeOfCircleSingle *next;
};
typedef struct NodeOfCircleSingle *CircleSingleLink;


///NOTE：
//1、单向循环链表和单链表相比需要着重处理的是在index=0处添加、删除元素，因为此处需要处理尾节点的next指向，要谨记在改变头结点之前先获取尾节点，然后再操作。
//2、另外需要主要的就是在打印和清空链表时有个循环，循环条件就不能在单单判断当前node是否不为空，因为此链表是循环链表，尾节点next不为空，所以没法结束循环，此时需要再加一个判断条件index<g_size_of_circleSingleLink(链表程度)即可。

//初始化
Status circleSingleLink_init_link(CircleSingleLink *link);
//插入
int circleSingleLink_insert_element(Element elem,CircleSingleLink head);
//在index下插入
Status circleSingleLink_insert_element_at_index(Element elem, int index, CircleSingleLink head);
//获取index下的node
Status circleSingleLink_node_of_index(int index, CircleSingleLink head, CircleSingleLink *node);
//删除
Status circleSingleLink_delete_element(int index,Element *data,CircleSingleLink head);
//更新
Status circleSingleLink_update_ele(int index, Element ele, CircleSingleLink head);
//根据ele查找index
int circleSingleLink_locate_ele_with_element(Element ele, CircleSingleLink head);
//清空
Status circleSingleLink_clearLink(CircleSingleLink head);
//打印
void circleSingleLink_printLink(CircleSingleLink link);
//打印某个节点
void circleSingleLink_print_node_at_index(CircleSingleLink link,int index);
//是否为空
bool circleSingleLink_is_empty(CircleSingleLink head);
//获取链表长度
int circleSingleLink_get_link_length(void);
//越界检查
bool circleSingleLink_boundary_check(int index);
#endif /* CircleSingleLink_h */

