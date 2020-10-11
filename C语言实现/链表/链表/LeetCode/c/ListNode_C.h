//
//  ListNode_C.h
//  链表
//
//  Created by 58 on 2020/10/10.
//  Copyright © 2020 58. All rights reserved.
//

#ifndef ListNode_C_h
#define ListNode_C_h

#include <stdbool.h>

struct ListNode_C {
    int val;
    struct ListNode_C *next;
};
typedef struct ListNode_C SingleLink_C;


SingleLink_C *create_link_C(void);




#endif /* ListNode_C_h */
