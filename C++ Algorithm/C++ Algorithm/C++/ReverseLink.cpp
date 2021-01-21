//
//  ReverseLink.cpp
//  C++ Algorithm
//
//  Created by 58 on 2021/1/21.
//

#include "ReverseLink.hpp"



namespace ReverseLink {

ListNode* Solution::reverseList(ListNode* head){
    
    ListNode* prev = nullptr;
    ListNode* curr = head;
    while (curr != nullptr) {
        ListNode* next = curr->next;
        curr->next = prev;
        prev = curr;
        curr = next;
    }
    return prev;
}
// reverse [head, tail)
ListNode* Solution::reverseList(ListNode* head, ListNode* tail){
    
    ListNode* prev = nullptr;
    ListNode* curr = tail;
    while (curr != tail) {
        ListNode* next = curr->next;
        curr->next = prev;
        prev = curr;
        curr = next;
    }
    return prev;
}
//「K 个一组反转链表」
ListNode* Solution::reverseKGroup(ListNode* head, int k) {
    if (head == nullptr) return nullptr;
    // 区间 [a, b) 包含 k 个待反转元素，那么[a, b)就是一组
    ListNode *a=nullptr, *b=nullptr;
    a = b = head;
    for (int i = 0; i < k; i++) {
        // 不足 k 个，不需要反转，base case
        if (b == nullptr) return head;
        b = b->next;
    }
    // 反转前 k 个元素
    ListNode *newHead = reverseList(a, b);
    // 递归反转后续链表并连接起来
    a->next = reverseKGroup(b, k);
    return newHead;
}

void Solution::ReverseLinkTest(void){
    Solution so;
    
    ListNode *node1 = new ListNode(1);
    ListNode *node2 = new ListNode(2);
    ListNode *node3 = new ListNode(3);
    ListNode *node4 = new ListNode(4);
    
    node1->next=node2;
    node2->next=node3;
    node3->next=node4;
    
    ListNode *head=so.reverseList(node1);
    
    while (head != nullptr) {
        cout << head->val << "->" ;
        head=head->next;
    }
    cout << "null" << endl;
}

}

