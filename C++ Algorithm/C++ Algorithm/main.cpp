//
//  main.cpp
//  C++ Algorithm
//
//  Created by 58 on 2021/1/21.
//

#include <iostream>
#include "LRU_Cache_CPP.hpp"
#include "Sort.hpp"
#include "ReverseLink.hpp"


void leetcodeTest(void);

int main(int argc, const char * argv[]) {
    
    leetcodeTest();
    
    return 0;
}

void leetcodeTest(void){
//    LRU_Cache_CPP::LRU_Cache_CPP_Test();
//    Sort::SortTest();
    ReverseLink::Solution::ReverseLinkTest();
    
    
}


// 自定义降序
bool down_cmp(const int &a,const int &b){
    return a>b;
}

/// Vector 的练习
void testVector(){
/**
 (1)头文件#include<vector>.
 
 (2)创建vector对象，vector<int> vec;
 
 (3)尾部插入数字：vec.push_back(a);
 
 (4)使用下标访问元素，cout<<vec[0]<<endl;记住下标是从0开始的。
 
 (5)使用迭代器访问元素.for(auto it=vec.begin();it!=vec.end();it++) cout<<*it<<endl;
 
 (6)插入元素：    vec.insert(vec.begin()+i,a);在第i个元素后面插入a;
 
 (7)删除元素：
 vec.erase(vec.begin()+2);删除第3个元素
 vec.erase(vec.begin()+i,vec.end()+j);删除区间[i,j-1];区间从0开始
 
 (8)向量大小:vec.size();
 
 (9)清空:vec.clear()　//清空之后，vec.size()为０
 
 (10).vector::rbegin() 反序的第一个元素的迭代器，也就是正序最后一个元素
 
 (11).vector::rend() 反序的最后一个元素的迭代器下一个位置，也相当于正序的第一个元素前一个位置
 
 (12) vector::capacity()返回vector的实际存储空间的大小，这个一般大于或等于vector元素个数，注意与size()函数的区别
 
 (13). vector::reserve()
 void reserve ( size_type n );
 重新分配空间的大小，不过这个n值要比原来的capacity()返回的值大，不然存储空间保持不变，
 
 (14). vector::at()
    const_reference at ( size_type n ) const;
    reference at ( size_type n );
    在函数的操作方面和下标访问元素一样，不同的是当这个函数越界时会抛出一个异常out_of_range
 
 (15). vector::front()
    reference front ( );
 const_reference front ( ) const;
 返回第一个元素的值，与begin()函数有区别，begin()函数返回的是第一个元素的迭代器
 
 (16). vector::back()
    reference back ( );
 const_reference back ( ) const;
 同样，返回最后一个元素的值，注意与end()函数的区别
 
 (17). vector::pop_back()
    void pop_back ( ); 删除最后一个元素
 
 (18). vector::insert() 插入新的元素，
 第一个函数，在迭代器指定的位置前插入值为x的元素
    iterator insert ( iterator position, const T& x );
 第二个函数，在迭代器指定的位置前插入n个值为x的元素
    void insert ( iterator position, size_type n, const T& x );
 第三个函数，在迭代器指定的位置前插入另外一个容器的一段序列迭代器first到last
 template <class InputIterator>
 void insert ( iterator position, InputIterator first, InputIterator last );
 
 (19). vector::erase()
 iterator erase ( iterator position );
 iterator erase ( iterator first, iterator last );
 删除元素或一段序列
 
 (20). vector::swap()
    void swap ( vector<T,Allocator>& vec );
    交换这两个容器的内容，这涉及到存储空间的重新分配
 

 若插入新的元素后总得元素个数大于capacity，则重新分配空间
 
 vector的元素不仅仅可以使int,double,string,还可以是结构体，但是要注意：结构体要定义为全局的，否则会出错。
 (1) 使用reverse将元素翻转：需要头文件#include<algorithm>
    reverse(vec.begin(),vec.end());将元素翻转(在vector中，如果一个函数中需要两个迭代器，一般后一个都不包含.)
 (2)使用sort排序：需要头文件#include<algorithm>，
 sort(vec.begin(),vec.end());(默认是按升序排列,即从小到大)
 
 1. vector容器的内存自增长
 与其他容器不同，其内存空间只会增长，不会减小。先来看看"C++ Primer"中怎么说：为了支持快速的随机访
 问，vector容器的元素以连续方式存放，每一个元素都紧挨着前一个元素存储。设想一下，当vector添加一个元素时，
 为了满足连续存放这个特性，都需要重新分配空间、拷贝元素、撤销旧空间，这样性能难以接受。因此STL实现者在对
 vector进行内存分配时，其实际分配的容量要比当前所需的空间多一些。就是说，vector容器预留了一些额外的存储
 区，用于存放新添加的元素，这样就不必为每个新元素重新分配整个容器的内存空间。
 关于vector的内存空间，有两个函数需要注意：size()成员指当前拥有的元素个数；capacity()成员指当前(容器必须分
 配新存储空间之前)可以存储的元素个数。reserve()成员可以用来控制容器的预留空间。vector另外一个特性在于它的
 内存空间会自增长，每当vector容器不得不分配新的存储空间时，会以加倍当前容量的分配策略实现重新分配。例如，
 当前capacity为50，当添加第51个元素时，预留空间不够用了，vector容器会重新分配大小为100的内存空间，作为新
 连续存储的位置。
 2. vector内存释放
 由于vector的内存占用空间只增不减，比如你首先分配了10,000个字节，然后erase掉后面9,999个，留下一个有效元素，但是内存占
 用仍为10,000个。所有内存空间是在vector析构时候才能被系统回收。empty()用来检测容器是否为空的，clear()可以清空所有元素。但是即使clear()，vector所占用的内存空间依然如故，无法保证内存的回收。
 如果需要空间动态缩小，可以考虑使用deque。如果非vector不可，可以用swap()来帮助你释放内存。具体方法如下：
 vector<int> nums;
 nums.push_back(1);
 nums.push_back(1);
 nums.push_back(2);
 nums.push_back(2);
 vector<int>().swap(nums);
 swap()是交换函数，使vector离开其自身的作用域，从而强制释放vector所占的内存空间，最简单的方法是vector<int>.swap(nums)。
 当时如果nums是一个类的成员，不能把vector<int>.swap(nums)写进类的析构函数中，否则会导致double free or corruption (fasttop)的错误，原因可能是重复释放内存，标准解决方案：
 void ClearVector( vector< T >& vt ){
     vector< T > vtTemp;
     veTemp.swap( vt );
}
 3. 利用vector释放指针
 如果vector中存放的是指针，那么当vector销毁时，这些指针指向的对象不会被销毁，那么内存就不会被释放。如下面这种情况，vector中的元素时由new操作动态申请出来的对象指针：
 for (vector<void *>::iterator it = v.begin(); it != v.end(); it ++)
     if (NULL != *it){
         delete *it;
         *it = NULL;
     }
 */
    
    int i=0;
    vector<int> vec;
    for(i=0; i<10; i++){
        vec.push_back(i); //10个元素依次进入，结果为10
    }
    //结果为：０，１，２，３，４，５，６，７，８，９
    for(unsigned int i=0; i<vec.size(); i++){
//        cout<<" "<< vec[i] ;
    }
    // 反序的第一个元素，返回的是迭代器
    cout << *(vec.rbegin())<<endl;
    cout << vec.back() <<endl;
    //结果为：０，１，２，３，４，５，６，７，８，９
    vector<int>::iterator it;
    for(it = vec.begin(); it!=vec.end(); it++){
//        cout<<" "<< *it ;
    }
    cout << endl;
    // 表示在index=4的索引下插入0，后面的元素以此往后挪
    vec.insert(vec.begin()+4, 12);
    
    // 反转
    reverse(vec.begin(), vec.end());
    
    // 排序.摸人升序
    sort(vec.begin(), vec.end());
    
    // 排序 自定义降序
    sort(vec.begin(), vec.end(), down_cmp);
    
    //vec.size() = 11
    //结果为：０，１，２，３，０，４，５，６，７，８，９
    for(unsigned int i=0; i<vec.size(); i++){
        cout<<"插入遍历："<< vec[i] <<endl;
    }
    
    // 删除index=2处的元素，后面的往前挪
    vec.erase(vec.begin()+2);
    
    //结果为：０，１，３，０，４，５，６，７，８，９
    for(unsigned int i=0; i<vec.size(); i++){
        cout<<"擦除遍历："<<vec[i]<<endl;
    }

    // 删除index=3 到 index = 5区间的元素
    vec.erase(vec.begin()+3,vec.begin()+5);
    
    for(vector<int>::iterator it = vec.begin(); it!=vec.end(); it++){
        cout<<"迭代遍历："<< *it <<endl;
    }
    
    
}
