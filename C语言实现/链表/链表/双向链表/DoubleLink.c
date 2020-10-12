//
//  DoubleLink.c
//  链表
//
//  Created by 58 on 2019/9/4.
//  Copyright © 2019 58. All rights reserved.
//

#include "DoubleLink.h"

bool doubleLinkNode_boundary_check(int index, DoubleLink d_link);
int doubleLinkNode_get_link_length(DoubleLink d_link);


//1、创建
DoubleLink create_double_link(void){
    DoubleLink link=(DoubleLink)malloc(sizeof(struct DoubleLinkNode));
    link->size=0;
    link->first=NULL;
    link->last=NULL;
    return link;
}

//2、增加一个元素
int doubleLinkNode_insert_element(Element elem,DoubleLink d_link){
    doubleLinkNode_insert_element_at_index(elem,d_link->size, d_link);
    return Success;
}
bool doubleLinkNode_is_empty(DoubleLink d_link){
    return (d_link->first == NULL);
}

Status doubleLinkNode_insert_element_at_index(Element elem, int index, DoubleLink d_link){
    
    //新节点
    struct DoubleLinkNode * new_node=(struct DoubleLinkNode *)malloc(sizeof(struct DoubleLinkNode));
    new_node->data=elem;//新节点赋值
    if (index==0) {//插入到最前面
        //旧头结点。此时旧头结点可能为null
        DoubleLinkNode head_node=d_link->first;
        new_node->pre=NULL;//设置新节点的pre为null
        new_node->next=head_node;//设置新节点->旧头结点
        if (d_link->size==0) {
            d_link->last=new_node;//这是添加第一个节点，所以last和first指向的都是第一个节点
        }else{
            head_node->pre=new_node;//旧头结点不为空时重新设置pre
        }
        d_link->first=new_node;//头指针指向这个新节点，那么这个新节点就成了新的头结点。
    }else if (index==d_link->size){//插入到最后位置
        struct DoubleLinkNode *last_node = d_link->last;//旧尾节点
        last_node->next=new_node;//旧尾节点重新设置next
        new_node->pre=last_node;//新节点也就是新尾节点设置pre
        new_node->next=NULL;//新节点也就是新尾节点设置next
        d_link->last=new_node;//头指针的last重新设置
    }else{//插入到其他位置
        struct DoubleLinkNode *current_node;//获取当前index的节点
        if(doubleLinkNode_node_of_index(index, d_link, &current_node)==Error)
            return Error;
        current_node->pre->next=new_node;//当前节点的前节点的后节点设置为新节点
        new_node->pre=current_node->pre;//新节点的pre
        new_node->next=current_node;//新节点的next
        current_node->pre=new_node;//当前节点的pre
    }
    d_link->size++;
    return Success;
}

//3、删除一个元素
Status doubleLinkNode_delete_element(int index,Element *data,DoubleLink d_link){
    struct DoubleLinkNode *delete_node;
    if (index==0) {
        delete_node=d_link->first;//这是头结点
        d_link->first=delete_node->next;//重新设置头结点
        if (d_link->size==1) {
            d_link->last=NULL;
        }else{
            delete_node->next->pre=NULL;//原先排第二的node就为头结点了，所以pre置空
        }
    }else{
        if(doubleLinkNode_node_of_index(index, d_link, &delete_node)==Error) return Error;
        delete_node->pre->next=delete_node->next;
        delete_node->next->pre=delete_node->pre;
    }
    *data=delete_node->data;
    free(delete_node);
    d_link->size--;
    printf("delete one node,index=%d.size=%d\n",index,d_link->size);
    return Success;
}
//4、修改一个元素
Status doubleLinkNode_update_ele(int index, Element ele, DoubleLink d_link){
    DoubleLinkNode node;
    if (doubleLinkNode_node_of_index(index, d_link, &node)==Error)return Error;
    node->data=ele;
    return Success;
}
//5、获取链表长度
int doubleLinkNode_get_link_length(DoubleLink d_link){
    return d_link->size;
}
//6、根据下标index查找元素Element
Status doubleLinkNode_node_of_index(int index, DoubleLink d_link, DoubleLinkNode *node){
    if (doubleLinkNode_boundary_check(index, d_link)) return Error;
    
    // 1、方法1 从头遍历
//    (*node) = d_link->first;//此时node表示头结点
//    int i=0;
//    while ((*node) && i<index) {
//        (*node)= (*node)->next;//依次后移
//        i++;
//    }
//    return Success;
    
    // 2、方法2 遍历一半
    if (index < d_link->size/2) { // index 小于size的一半，也就是遍历前半部分
        (*node) = d_link->first;
        for (int i=0; i<index; i++) {
            (*node)=(*node)->next;
        }
    }else{ // index 大于等于于size的一半，也就是遍历后半部分
        (*node) = d_link->last;
        for (int i = d_link->size-1; i>index; i--) {
            (*node)=(*node)->pre;
        }
    }
    return Success;
}
//7、根据元素Element查找下标index
int doubleLinkNode_locate_ele_with_element(Element ele, DoubleLink d_link){
    int index=-1;
    struct DoubleLinkNode *node=d_link->first;
    for (int i=0; i<d_link->size; i++) {
        if ((node->data == ele) && node) {
            index=i;
            break;
        }
        node=node->next;
    }
    return index;
}
//8、清空链表
Status doubleLinkNode_clearLink(DoubleLink d_link){
    DoubleLinkNode head_node=d_link->first;
    while (head_node) {
        DoubleLinkNode temp=head_node;
        head_node=head_node->next;
        printf("删除%d\n",temp->data);
        free(temp);
    }
    d_link->first=NULL;
    d_link->last=NULL;
    d_link->size =0;
    printf("链表被清空...\n");
    return Success;
}
//9、检查是否越界
bool doubleLinkNode_boundary_check(int index, DoubleLink d_link){
    if (index<0 || index>=d_link->size) {
        printf("index=%d out of bounds. size=%d \n",index,d_link->size);
        return true;
    }else{
        return false;
    }
}
//10、打印链表
void doubleLinkNode_printLink(DoubleLink d_link){
    int i=0;
    struct DoubleLinkNode *node=d_link->first;
    while (node) {
        printf("第%d个节点：data=%d,本节点地址: %p 下个节点地址: %p 上个节点地址=%p\n",i+1,node->data,node,node->next,node->pre);
        node=node->next;
        i++;
    }
    printf("size=%d\n",d_link->size);
}
