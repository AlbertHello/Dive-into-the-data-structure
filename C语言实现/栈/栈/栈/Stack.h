//
//  Stack.h
//  栈
//
//  Created by 王启正 on 2019/9/13.
//  Copyright © 2019 58. All rights reserved.
//

#ifndef Stack_h
#define Stack_h

#include <stdio.h>
#include "SingleLink.h"

/// 压栈
void push(int);

/// 返回栈顶元素
int  peek(void);

/// 栈顶元素出栈
int  pop(void);

/// 栈大小
int  size(void);

/// 栈是否空
bool isEmety(void);

void print_stack(void);



#endif /* Stack_h */
