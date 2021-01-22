//
//  ReverseLink.hpp
//  C++ Algorithm
//
//  Created by 58 on 2021/1/21.
//

#ifndef ReverseLink_hpp
#define ReverseLink_hpp

#include <stdio.h>
#include <iostream>
using namespace std;

namespace ReverseLink {

class ListNode{
public:
    int val;
    ListNode *next;
    ListNode(int val):val(val),next(nullptr){}
    ~ListNode(){}
};
class Solution {
public:
    ListNode* reverseList(ListNode* head);
    ListNode* reverseList(ListNode* head, ListNode* tail);
    ListNode* reverseKGroup(ListNode* head, int k);
    static void ReverseLinkTest(void);
    
};
}





#endif /* ReverseLink_hpp */
