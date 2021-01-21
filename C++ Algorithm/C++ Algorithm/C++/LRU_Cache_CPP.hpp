//
//  LRU_Cache_CPP.hpp
//  LeetCode
//
//  Created by 58 on 2021/1/21.
//

#ifndef LRU_Cache_CPP_hpp
#define LRU_Cache_CPP_hpp

#include <stdio.h>
#include <iostream>
#include <unordered_map>
using namespace std;

struct DLinkedNode {
    int key;
    int value;
    DLinkedNode* prev;
    DLinkedNode* next;
    DLinkedNode(): key(0), value(0), prev(nullptr), next(nullptr) {}
    DLinkedNode(int key, int value): key(key), value(value), prev(nullptr), next(nullptr) {}
};

class LRU_Cache_CPP{
private:
    // unordered_map 底层是哈希表
    unordered_map<int, DLinkedNode*> m_map;
    DLinkedNode* m_head;
    DLinkedNode* m_tail;
    int m_size;
    int m_capacity;
    
    void moveToHead(DLinkedNode* node);
    DLinkedNode* removeLast(void);
    void printLRU(void);
public:
    LRU_Cache_CPP(int capacity);
    ~LRU_Cache_CPP();
    void put(int key, int value);
    int get(int key);
    static void LRU_Cache_CPP_Test(void);
};



#endif /* LRU_Cache_CPP_hpp */
