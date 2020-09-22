//
//  ReverseLink.c
//  链表
//
//  Created by 王启正 on 2019/12/7.
//  Copyright © 2019 58. All rights reserved.
//

#include "ReverseLink.h"


//带有头结点的链表。 head->first->second->third->null
void ReverseLinkWithHeadNode(Link *head){
    Link p, q, r;
    p=(*head)->next;// p指向first node。
    q=NULL;
    while (p != NULL) {
        r=q;
        q=p;
        p=p->next;
        q->next=r;
    }
    (*head)->next=q;// 修改原先的头结点的下一个节。也即是重新指向了新的第一个节点。
}

//没有头结点的链表。也就是传入的是头指针。 first->second->third->null
void ReverseLinkWithoutHeadNode(Link *link){
    Link p, q, r;
    p=(*link);// link就是first node,让p也指向first node。
    q=NULL;
    while (p != NULL) {
        r=q;
        q=p;
        p=p->next;
        q->next=r;
    }
    (*link)=q;// 修改原先头指针指向的地址。也即是重新指向了新的第一个节点。
}

