//
//  _232_Implement_Queue_using_Stacks.h
//  LeetCode
//
//  Created by 58 on 2020/11/10.
//

#import <Foundation/Foundation.h>
#include <iostream>
#include <stack>
using namespace std;

NS_ASSUME_NONNULL_BEGIN

@interface _232_Implement_Queue_using_Stacks : NSObject

@end

class Implement_MyQueue_using_Stacks_CPP {
public:
    stack<int> *stack1;
    stack<int> *stack2;
    
    Implement_MyQueue_using_Stacks_CPP();
    ~Implement_MyQueue_using_Stacks_CPP();
    
    void myQueue_enqueue(int val);
    int myQueue_dequeue(void);
    bool myQueue_empty(void);
    
};

NS_ASSUME_NONNULL_END
