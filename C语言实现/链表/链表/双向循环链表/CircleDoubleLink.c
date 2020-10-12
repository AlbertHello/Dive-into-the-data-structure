//
//  CircleDoubleLink.c
//  链表
//
//  Created by 58 on 2019/9/5.
//  Copyright © 2019 58. All rights reserved.
//

#include "CircleDoubleLink.h"

CircleDoubleLink create_circle_double_link(void){
    CircleDoubleLink link=(CircleDoubleLink)malloc(sizeof(struct CircleDoubleLinkNode));
    link->size=0;
    link->first=NULL;
    link->last=NULL;
    return link;
}
//2、增加一个元素
int circleDoubleLinkNode_insert_element(Element elem,CircleDoubleLink cd_link){
    circleDoubleLinkNode_insert_element_at_index(elem,cd_link->size, cd_link);
    return Success;
}
bool circleDoubleLinkNode_is_empty(CircleDoubleLink cd_link){
    return (cd_link->first == NULL);
}

Status circleDoubleLinkNode_insert_element_at_index(Element elem, int index, CircleDoubleLink cd_link){
    
    //新节点
    CircleDoubleLinkNode new_node=(CircleDoubleLinkNode)malloc(sizeof(struct CircleDoubleLinkNode));
    new_node->data=elem;//新节点赋值
    if (index==0) {//插入到最前面
        if (cd_link->size==0) {//这是添加整个链表中第一个节点时
            cd_link->last=new_node;//头指针的first和last都指向这个新节点
            new_node->pre=new_node;//新节点的pre为指向自己
            new_node->next=new_node;//新节点的next也指向自己
        }else{
            //此处头结点head_node有值。
            CircleDoubleLinkNode head_node=cd_link->first;
            CircleDoubleLinkNode last_node=cd_link->last;
            new_node->pre=head_node->pre;//新节点的pre指向旧头结点的pre
            new_node->next=head_node;//新节点的next也指向就头结点
            head_node->pre=new_node;//旧头结点pre则指向这个新节点。
            last_node->next=new_node;//最后一个节点next重新指向这个新节点
        }
        cd_link->first=new_node;//头指针指向这个新节点，那么这个新节点就成了新的头结点。
    }else if (index==cd_link->size){//插入到最后位置
        CircleDoubleLinkNode head_node=cd_link->first;
        CircleDoubleLinkNode last_node=cd_link->last;//旧尾节点
        head_node->pre=new_node;//头结点的pre指向了新的尾结点
        new_node->pre=last_node;//新节点也就是新尾节点设置pre
        new_node->next=last_node->next;//新节点也就是新尾节点设置next
        last_node->next=new_node;//旧尾节点重新设置next
        cd_link->last=new_node;//头指针的last重新设置
    }else{//插入到其他位置
        CircleDoubleLinkNode current_node;//获取当前index的节点
        if(circleDoubleLinkNode_node_of_index(index, cd_link, &current_node)==Error)
            return Error;
        current_node->pre->next=new_node;//当前节点的前节点的后节点设置为新节点
        new_node->pre=current_node->pre;//新节点的pre
        new_node->next=current_node;//新节点的next
        current_node->pre=new_node;//当前节点的pre
    }
    cd_link->size++;
    return Success;
}

//3、删除一个元素
Status circleDoubleLinkNode_delete_element(int index,Element *data,CircleDoubleLink cd_link){
    CircleDoubleLinkNode delete_node=NULL;
    if (index==0) {
        delete_node=cd_link->first;//这是头结点
        if (cd_link->size==1) {
            cd_link->first=NULL;
            cd_link->last=NULL;
        }else{
            CircleDoubleLinkNode last_node=cd_link->last;//旧尾节点
            cd_link->first=delete_node->next;//重新设置头结点
            last_node->next=delete_node->next;//重新设置尾结点的next
            delete_node->next->pre=delete_node->pre;//新头结点的pre从新设置
        }
    }else{
        if(circleDoubleLinkNode_node_of_index(index, cd_link, &delete_node)==Error) return Error;
        cd_link->last=delete_node->pre;
        delete_node->pre->next=delete_node->next;
        delete_node->next->pre=delete_node->pre;
    }
    *data=delete_node->data;
    free(delete_node);
    printf("delete one node,index=%d.size=%d\n",index,cd_link->size);
    cd_link->size--;
    return Success;
}
//4、修改一个元素
Status circleDoubleLinkNode_update_ele(int index, Element ele, CircleDoubleLink cd_link){
    CircleDoubleLinkNode node;
    if (circleDoubleLinkNode_node_of_index(index, cd_link, &node)==Error)return Error;
    node->data=ele;
    return Success;
}
//5、获取链表长度
int circleDoubleLinkNode_get_link_length(CircleDoubleLink cd_link){
    return cd_link->size;
}
//6、根据下标index查找元素Element
Status circleDoubleLinkNode_node_of_index(int index, CircleDoubleLink cd_link, CircleDoubleLinkNode *node){
    if (circleDoubleLinkNode_boundary_check(index,cd_link)) return Error;
    (*node) = cd_link->first;//此时node表示头结点
    int i=0;
    while ((*node) && i<index) {
        (*node)= (*node)->next;//依次后移
        i++;
    }
    return Success;
}
//7、根据元素Element查找下标index
int circleDoubleLinkNode_locate_ele_with_element(Element ele, CircleDoubleLink cd_link){
    int index=-1;
    struct CircleDoubleLinkNode *node=cd_link->first;
    for (int i=0; i<cd_link->size; i++) {
        if ((node->data == ele) && node) {
            index=i;
            break;
        }
        node=node->next;
    }
    return index;
}
//8、清空链表
Status circleDoubleLinkNode_clearLink(CircleDoubleLink cd_link){
    CircleDoubleLinkNode head_node=cd_link->first;
    int i=0;
    while (head_node && i<cd_link->size) {
        CircleDoubleLinkNode temp=head_node;
        head_node=head_node->next;
        printf("删除%d\n",temp->data);
        free(temp);
        i++;
    }
    cd_link->first=NULL;
    cd_link->last=NULL;
    cd_link->size=0;
    printf("链表被清空...\n");
    return Success;
}
//9、检查是否越界
bool circleDoubleLinkNode_boundary_check(int index,CircleDoubleLink cd_link){
    if (index<0 || index>=cd_link->size) {
        printf("index=%d out of bounds. size=%d \n",index,cd_link->size);
        return true;
    }else{
        return false;
    }
}
//10、打印链表
void circleDoubleLinkNode_printLink(CircleDoubleLink cd_link){
    int i=0;
    CircleDoubleLinkNode node=cd_link->first;
    while (node && i<cd_link->size) {
        printf("第%d个节点：data=%d,本节点地址: %p 下个节点地址: %p 上个节点地址=%p\n",i+1,node->data,node,node->next,node->pre);
        node=node->next;
        i++;
    }
    printf("size=%d\n",cd_link->size);
}
