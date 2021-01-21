//
//  Sort.hpp
//  C++ Algorithm
//
//  Created by 58 on 2021/1/21.
//

#ifndef Sort_hpp
#define Sort_hpp

#include <stdio.h>
#include <iostream>
#include <vector>
#include <cstdlib>

using namespace std;

class Sort {
private:
    
public:
    Sort();
    ~Sort();
    void bubble_sort(vector<int> &nums);
    void quick_sort(int *nums);
    void merge_sort(int *nums);
    static void SortTest(void);
};

#endif /* Sort_hpp */
