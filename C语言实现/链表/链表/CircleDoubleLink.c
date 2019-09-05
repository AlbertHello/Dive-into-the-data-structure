//
//  CircleDoubleLink.c
//  链表
//
//  Created by 58 on 2019/9/5.
//  Copyright © 2019 58. All rights reserved.
//

#include "CircleDoubleLink.h"

//1、初始化一个链表
Status circleDoubleLinkNode_init_link(CircleDoubleLink *head){
    *head=(CircleDoubleLink)malloc(sizeof(struct CircleDoubleLinkNode));
    if (*head) {
        (*head)->data=0;
        (*head)->pre=NULL;
        (*head)->next=NULL;
        g_size_circleDoubleLinkNode=0;
        return Success;
    }else{
        return Error;
    }
}

//2、增加一个元素
int circleDoubleLinkNode_insert_element(Element elem,CircleDoubleLink head){
    circleDoubleLinkNode_insert_element_at_index(elem,g_size_circleDoubleLinkNode, head);
    return Success;
}
bool circleDoubleLinkNode_is_empty(CircleDoubleLink head){
    return (head->next == NULL);
}

Status circleDoubleLinkNode_insert_element_at_index(Element elem, int index, CircleDoubleLink head){
    
    //新节点
    struct CircleDoubleLinkNode * new_node=(struct CircleDoubleLinkNode *)malloc(sizeof(struct CircleDoubleLinkNode));
    new_node->data=elem;//新节点赋值
    if (index==0) {//插入到最前面
        //旧头结点。此时旧头结点可能为null
        CircleDoubleLink head_node=head->next;
        new_node->pre=NULL;//设置新节点的pre为null
        new_node->next=head_node;//设置新节点->旧头结点
        //头指针
        if (g_size_circleDoubleLinkNode==0) {
            head->pre=new_node;//这是添加一个节点时。
        }else{
            head_node->pre=new_node;//旧头结点不为空时重新设置pre
        }
        head->next=new_node;//头指针指向这个新节点，那么这个新节点就成了新的头结点。
    }else if (index==g_size_circleDoubleLinkNode){//插入到最后位置
        struct CircleDoubleLinkNode *last_node;//旧尾节点
        if(circleDoubleLinkNode_node_of_index(index-1, head, &last_node)==Error)
            return Error;
        last_node->next=new_node;//旧尾节点重新设置next
        new_node->pre=last_node;//新节点也就是新尾节点设置pre
        new_node->next=NULL;//新节点也就是新尾节点设置next
        head->pre=new_node;//头指针的pre重新设置
    }else{//插入到其他位置
        struct CircleDoubleLinkNode *current_node;//获取当前index的节点
        if(circleDoubleLinkNode_node_of_index(index, head, &current_node)==Error)
            return Error;
        current_node->pre->next=new_node;//当前节点的前节点的后节点设置为新节点
        new_node->pre=current_node->pre;//新节点的pre
        new_node->next=current_node;//新节点的next
        current_node->pre=new_node;//当前节点的pre
    }
    g_size_circleDoubleLinkNode++;
    printf("insert one node at index=%d,size=%d\n",index,g_size_circleDoubleLinkNode);
    return Success;
}

//3、删除一个元素
Status circleDoubleLinkNode_delete_element(int index,Element *data,CircleDoubleLink head){
    struct CircleDoubleLinkNode *delete_node;
    if (index==0) {
        delete_node=head->next;//这是头结点
        head->next=delete_node->next;//重新设置头结点
        if (g_size_circleDoubleLinkNode==1) {
            head->pre=NULL;
        }else{
            delete_node->next->pre=NULL;
        }
    }else{
        if(circleDoubleLinkNode_node_of_index(index, head, &delete_node)==Error) return Error;
        delete_node->pre->next=delete_node->next;
        delete_node->next->pre=delete_node->pre;
    }
    *data=delete_node->data;
    free(delete_node);
    printf("delete one node,index=%d.size=%d\n",index,g_size_circleDoubleLinkNode);
    g_size_circleDoubleLinkNode--;

    return Success;
}
//4、修改一个元素
Status circleDoubleLinkNode_update_ele(int index, Element ele, CircleDoubleLink head){
    CircleDoubleLink node;
    if (circleDoubleLinkNode_node_of_index(index, head, &node)==Error)return Error;
    node->data=ele;
    return Success;
}
//5、获取链表长度
int circleDoubleLinkNode_get_link_length(){
    return g_size_circleDoubleLinkNode;
}
//6、根据下标index查找元素Element
Status circleDoubleLinkNode_node_of_index(int index, CircleDoubleLink head, CircleDoubleLink *node){
    if (circleDoubleLinkNode_boundary_check(index)) return Error;
    (*node) = head->next;//此时node表示头结点
    int i=0;
    while ((*node) && i<index) {
        (*node)= (*node)->next;//依次后移
        i++;
    }
    return Success;
}
//7、根据元素Element查找下标index
int circleDoubleLinkNode_locate_ele_with_element(Element ele, CircleDoubleLink head){
    int index=-1;
    struct CircleDoubleLinkNode *node=head->next;
    for (int i=0; i<g_size_circleDoubleLinkNode; i++) {
        if ((node->data == ele) && node) {
            index=i;
            break;
        }
        node=node->next;
    }
    return index;
}
//8、清空链表
Status circleDoubleLinkNode_clearLink(CircleDoubleLink head){
    CircleDoubleLink head_node=head->next;
    while (head_node) {
        CircleDoubleLink temp=head_node;
        head_node=head_node->next;
        printf("删除%d\n",temp->data);
        free(temp);
        g_size_circleDoubleLinkNode--;
    }
    head->pre=NULL;
    head->next=NULL;
    g_size_circleDoubleLinkNode =0;
    printf("链表被清空...\n");
    return Success;
}
//9、检查是否越界
bool circleDoubleLinkNode_boundary_check(int index){
    if (index<0 || index>=g_size_circleDoubleLinkNode) {
        printf("index=%d out of bounds. size=%d \n",index,g_size_circleDoubleLinkNode);
        return true;
    }else{
        return false;
    }
}
//10、打印链表
void circleDoubleLinkNode_printLink(CircleDoubleLink link){
    int i=0;
    struct CircleDoubleLinkNode *node=link->next;
    while (node) {
        printf("第%d个节点：data=%d,本节点地址: %p 下个节点地址: %p 上个节点地址=%p\n",i+1,node->data,node,node->next,node->pre);
        node=node->next;
        i++;
    }
    printf("size=%d\n",g_size_circleDoubleLinkNode);
}
