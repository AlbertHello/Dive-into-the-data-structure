//
//  CircleSingleLink.c
//  链表
//
//  Created by 58 on 2019/9/3.
//  Copyright © 2019 58. All rights reserved.
//

#include "CircleSingleLink.h"


//1、创建
CircleSingleLink create_single_circle_link(void){
    CircleSingleLink link=(CircleSingleLink)malloc(sizeof(struct NodeOfCircleSingle));
    link->data=0;
    link->next=NULL;
    g_size_of_circleSingleLink=0;
    return link;
}

//1、创建
Status circleSingleLink_init_link(CircleSingleLink *head){
    *head=(CircleSingleLink)malloc(sizeof(struct NodeOfCircleSingle));
    if (*head) {
        (*head)->data=0;
        (*head)->next=NULL;
        g_size_of_circleSingleLink=0;
        return Success;
    }else{
        return Error;
    }
}

//2、增加一个元素
int circleSingleLink_insert_element(Element elem,CircleSingleLink head){
    circleSingleLink_insert_element_at_index(elem,g_size_of_circleSingleLink, head);
    return Success;
}
bool circleSingleLink_is_empty(CircleSingleLink head){
    return (head->next == NULL);
}

Status circleSingleLink_insert_element_at_index(Element elem, int index, CircleSingleLink head){
    //头结点
    CircleSingleLink head_node=head->next;
    //新节点
    struct NodeOfCircleSingle * new_node=(struct NodeOfCircleSingle *)malloc(sizeof(struct NodeOfCircleSingle));
    new_node->data=elem;//新节点赋值
    if (index==0) {//插入到最前面
        new_node->next=head_node;//设置新节点->旧头结点
        
        struct NodeOfCircleSingle * last_node=NULL;
        if (g_size_of_circleSingleLink==0) {
            last_node=new_node;//如果此时只有一个节点，那么这第一个节点也是最后一个节点。
        }else{
            circleSingleLink_node_of_index(g_size_of_circleSingleLink-1, head, &last_node);//获取最后一个节点，要在修改头结点之前获取尾节点
        }
        //头指针指向这个新节点，那么这个新节点就成了新的头结点。在这之前先获取尾节点。
        head->next=new_node;
        last_node->next=head->next;//最后一个节点指向第一个节点，形成一个环。
    }else{//插入到其他位置
        struct NodeOfCircleSingle *pre_node;
        if(circleSingleLink_node_of_index(index-1, head, &pre_node)==Error)//获取要插入点的前一个节点pre_node
            return Error;
        new_node->next=pre_node->next;//新节点下一个节点是pre_node的下一个节点。
        pre_node->next=new_node;//pre_node的下一个节点修改为这个新节点
    }
    g_size_of_circleSingleLink++;
//    printf("insert one node at index=%d,size=%d\n",index,g_size_of_circleSingleLink);
    return Success;
}

//3、删除一个元素
Status circleSingleLink_delete_element(int index,Element *data,CircleSingleLink head){
    struct NodeOfCircleSingle *pre_node;
    struct NodeOfCircleSingle *delete_node;
    if (index==0) {
        delete_node=head->next;//这是头结点
        if (g_size_of_circleSingleLink==1) {
            head->next=NULL;//如果只有一个节点，只需要把头指针的next置位空即可。
        }else{
            struct NodeOfCircleSingle * last_node=NULL;
            circleSingleLink_node_of_index(g_size_of_circleSingleLink-1, head, &last_node);//获取最后一个节点
            head->next=delete_node->next;//重新设置头结点
            last_node->next=head->next;//重新设置尾节点的next
        }
    }else{
        if(circleSingleLink_node_of_index(index-1, head, &pre_node)==Error) return Error;
        delete_node=pre_node->next;
        pre_node->next=delete_node->next;
    }
    *data=delete_node->data;//返回要删除的该节点的值
    free(delete_node);//释放节点
//    printf("delete one node,index=%d.size=%d\n",index,g_size_of_circleSingleLink);
    g_size_of_circleSingleLink--;

    return Success;
}
//4、修改一个元素
Status circleSingleLink_update_ele(int index, Element ele, CircleSingleLink head){
    CircleSingleLink node;
    if (circleSingleLink_node_of_index(index, head, &node)==Error)return Error;
    node->data=ele;
    return Success;
}
//5、获取链表长度
int circleSingleLink_get_link_length(){
    return g_size_of_circleSingleLink;
}
//6、根据下标index查找元素Element
Status circleSingleLink_node_of_index(int index, CircleSingleLink head, CircleSingleLink *node){
    if (circleSingleLink_boundary_check(index)) return Error;
    (*node) = head->next;//此时node表示头结点
    int i=0;
    while ((*node) && i<index) {
        (*node)= (*node)->next;//依次后移
        i++;
    }
    return Success;
}
//7、根据元素Element查找下标index
int circleSingleLink_locate_ele_with_element(Element ele, CircleSingleLink head){
    int index=-1;
    struct NodeOfCircleSingle *node=head->next;
    for (int i=0; i<g_size_of_circleSingleLink; i++) {
        if ((node->data == ele) && node) {
            index=i;
            break;
        }
        node=node->next;
    }
    return index;
}
//8、清空链表
Status circleSingleLink_clearLink(CircleSingleLink head){
    CircleSingleLink head_node=head->next;
    int i=0;
    while (head_node && i<g_size_of_circleSingleLink) {
        CircleSingleLink temp=head_node;
        head_node=head_node->next;
        printf("删除%d\n",temp->data);
        free(temp);
        i++;
    }
    head->next=NULL;
    g_size_of_circleSingleLink =0;
    printf("链表被清空...\n");
    return Success;
}
//9、检查是否越界
bool circleSingleLink_boundary_check(int index){
    if (index<0 || index>=g_size_of_circleSingleLink) {
        printf("index=%d out of bounds. size=%d \n",index,g_size_of_circleSingleLink);
        return true;
    }else{
        return false;
    }
}
//10、打印链表
void circleSingleLink_printLink(CircleSingleLink link){
    int i=0;
    struct NodeOfCircleSingle *node=link->next;//头结点
    struct NodeOfCircleSingle *last_node=NULL; circleSingleLink_node_of_index(g_size_of_circleSingleLink-1, link, &last_node);//尾节点
    while (node && i<g_size_of_circleSingleLink) {
        printf("第%d个节点：data=%d,本节点地址: %p 下个节点地址: %p\n",i+1,node->data,node,node->next);
        node=node->next;
        i++;
    }
    printf("size=%d\n",g_size_of_circleSingleLink);
}
void circleSingleLink_print_node_at_index(CircleSingleLink link,int index){
    struct NodeOfCircleSingle *node=NULL;
    circleSingleLink_node_of_index(index, link, &node);
    if (node) {
        printf("第%d个节点：data=%d,本节点地址: %p 下个节点地址: %p\n",index+1,node->data,node,node->next);
    }else{
        printf("查找index=%d的节点失败\n",index);
    }
}

