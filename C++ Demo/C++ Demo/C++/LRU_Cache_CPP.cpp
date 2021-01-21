//
//  LRU_Cache_CPP.cpp
//  LeetCode
//
//  Created by 58 on 2021/1/21.
//

#include "LRU_Cache_CPP.hpp"



LRU_Cache_CPP::LRU_Cache_CPP(int capacity):m_capacity(capacity),m_size(0){
    
}
LRU_Cache_CPP::~LRU_Cache_CPP(){
    
}
void LRU_Cache_CPP::put(int key, int value){
    auto itor = m_map.find(key);
    if (itor != m_map.end()) { // 有值
        DLinkedNode* node = m_map[key];
        node->value=value;
        moveToHead(node);
    }else{ // 新key
        if (m_size == m_capacity) {
            DLinkedNode* del_node = removeLast();
            m_map.erase(del_node->key);
            m_size--;
        }
        DLinkedNode* new_node = new DLinkedNode(key,value);
        m_map[key] = new_node;
        moveToHead(new_node);
        m_size++;
    }
}
int LRU_Cache_CPP::get(int key){
    
    // count 返回指定元素出现的次数
    if (!m_map.count(key)) {
        return -1;
    }
    // 如果 key 存在，先通过哈希表定位，再移到头部
    DLinkedNode* node = m_map[key];
    moveToHead(node);
    return node->value;
}
void LRU_Cache_CPP::moveToHead(DLinkedNode* node){
    if (m_size == 0) {
        m_head=node;
        m_tail=node;
        node->prev=nullptr;
        node->next=nullptr;
    }else{
        // 如果移动的本来就是头节点，不需要做任何事
        if (node != m_head) {
            DLinkedNode* pre = node->prev;
            DLinkedNode* nex = node->next;
            if (pre == nullptr && nex == nullptr) { // 新结点
                node->next=m_head;
                m_head->prev=node;
                m_head=node;
            }else if(node == m_tail){ // 尾节点
                m_tail->next=m_head;
                m_head->prev=m_tail;
                pre->next=nullptr;
                m_head=m_tail;
                m_tail=pre;
            }else{ // 中间节点
                pre->next=nex;
                nex->prev=pre;
                node->next=m_head;
                m_head->prev=node;
                m_head=node;
            }
        }
    }
}
DLinkedNode* LRU_Cache_CPP::removeLast(){
    DLinkedNode* last_node=m_tail;
    if (m_size == 1) {
        m_head=nullptr;
        m_tail=nullptr;
        return last_node;
    }else{
        DLinkedNode* pre_node=last_node->prev;
        pre_node->next=nullptr;
        m_tail=pre_node;
    }
    return  last_node;
}
void LRU_Cache_CPP::printLRU(){
    
    //auto自动识别为迭代器类型unordered_map<int,int>::iterator
//    auto iter = m_map.begin();
//    while (iter != m_map.end()){ // 便利map，无顺序
//        cout << iter->first << "," << iter->second << endl;
//        iter++;
//    }
    auto node = m_head;
    while (node != nullptr) { // 便利双向链表
        cout << node->key << "," << node->value << endl;
        node=node->next;
    }
}


void LRU_Cache_CPP::LRU_Cache_CPP_Test(){
    
    LRU_Cache_CPP *LRU=new LRU_Cache_CPP(2);
    LRU->put(1, 1);
    LRU->put(2, 2);
    LRU->printLRU();
    cout << LRU->get(1) <<endl;
    LRU->printLRU();
    LRU->put(3, 3);
    LRU->printLRU();
    cout << LRU->get(2) <<endl;
    LRU->put(4, 4);
    LRU->printLRU();
    cout << LRU->get(1) <<endl;
    cout << LRU->get(3) <<endl;
    cout << LRU->get(4) <<endl;
    LRU->printLRU();
    
    
    delete LRU;
}

/**
 map的基本操作函数：
      C++ maps是一种关联式容器，包含“关键字/值”对
      begin()         返回指向map头部的迭代器
      clear(）        删除所有元素
      count()         返回指定元素出现的次数
      empty()         如果map为空则返回true
      end()           返回指向map末尾的迭代器
      equal_range()   返回特殊条目的迭代器对
      erase()         删除一个元素
      find()          查找一个元素
      get_allocator() 返回map的配置器
      insert()        插入元素
      key_comp()      返回比较元素key的函数
      lower_bound()   返回键值>=给定元素的第一个位置
      max_size()      返回可以容纳的最大元素个数
      rbegin()        返回一个指向map尾部的逆向迭代器
      rend()          返回一个指向map头部的逆向迭代器
      size()          返回map中元素的个数
      swap()           交换两个map
      upper_bound()    返回键值>给定元素的第一个位置
      value_comp()     返回比较元素value的函数
 */
