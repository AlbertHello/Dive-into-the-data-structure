//
//  Sort.cpp
//  C++ Algorithm
//
//  Created by 58 on 2021/1/21.
//

#include "Sort.hpp"



Sort::Sort(){
    cout << "Sort::Sort()" << endl;
}
Sort::~Sort(){
    cout << "Sort::~Sort()" << endl;
}
void Sort::bubble_sort(vector<int> &nums){
    if (nums.empty()) return;
    
    int len = static_cast<int>(nums.size());
    
    if (len == 0) return;
    for (int i=len-1; i>=0; i--) {
        bool flag = true;
        for (int j=0; j<i; j++) {
            if (nums[j] > nums[j+1]) {
                int temp = nums[j];
                nums[j] = nums[j+1];
                nums[j+1] = temp;
                flag = false;
            }
        }
        if (flag) break;
    }
}

void Sort::quick_sort(int *nums){
    
}
void Sort::merge_sort(int *nums){
    
}
void Sort::SortTest(void){
    Sort sort;
    
    vector<int> vec;
    for(int i=0; i<20; i++){
        int val = (rand()%20);
        vec.push_back(val);//10个元素依次进入，结果为10
    }
    for(auto it = vec.begin(); it!=vec.end(); it++){
        cout<< " " << *it;
    }
    cout<< endl;
    
    sort.bubble_sort(vec);
    
    for(auto it = vec.begin(); it!=vec.end(); it++){
        cout<< " " << *it;
    }
    
    cout<< endl;
}

