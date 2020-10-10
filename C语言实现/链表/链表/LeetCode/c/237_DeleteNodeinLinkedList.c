//
//  237_DeleteNodeinLinkedList.c
//  链表
//
//  Created by 58 on 2020/10/10.
//  Copyright © 2020 58. All rights reserved.
//

#include "237_DeleteNodeinLinkedList.h"

void deleteNode(struct ListNode* node) {
    node->val=node->next->val;
    node->next=node->next->next;
}
