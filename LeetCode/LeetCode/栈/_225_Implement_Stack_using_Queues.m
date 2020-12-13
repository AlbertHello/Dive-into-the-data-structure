//
//  _225_Implement_Stack_using_Queues.m
//  LeetCode
//
//  Created by 58 on 2020/11/10.
//

#import "_225_Implement_Stack_using_Queues.h"
#import "MyQueue.h"

//@interface Node : NSObject
//
//@property(nonatomic,assign)int val;
//@property(nonatomic,strong)Node *next;
//
//@end
//@implementation Node
//
//-(instancetype)init{
//    if (self=[super init]) {
//        self.val=-1;
//        self.next=nil;
//    }
//    return self;
//}
//
//@end
//
//@interface Link : NSObject
//
//@property(nonatomic,assign)int size;
//@property(nonatomic,strong)Node *first;
//
//@end
//@implementation Link
//
//-(instancetype)init{
//    if (self=[super init]) {
//        self.size=0;
//        self.first=nil;
//    }
//    return self;
//}
//-(void)push:(int)val{
//
//}
//-(void)pop{
//
//}
//
//@end


@interface _225_Implement_Stack_using_Queues()

// 用数组实现
@property(nonatomic,strong)NSMutableArray *array;

@end

@implementation _225_Implement_Stack_using_Queues


-(instancetype)init{
    if (self=[super init]) {
        self.array=[NSMutableArray array];
    }
    return self;
}
/**
 225. 用队列实现栈
 使用队列实现栈的下列操作：

 push(x) -- 元素 x 入栈
 pop() -- 移除栈顶元素
 top() -- 获取栈顶元素
 empty() -- 返回栈是否为空
 注意:

 你只能使用队列的基本操作-- 也就是 push to back, peek/pop from front, size, 和 is empty 这些操作是合法的。
 你所使用的语言也许不支持队列。 你可以使用 list 或者 deque（双端队列）来模拟一个队列 , 只要是标准的队列操作即可。
 你可以假设所有操作都是有效的（例如, 对一个空的栈不会调用 pop 或者 top 操作）。
 */
/** 添加元素到栈顶 */
//先说 push API，直接将元素加入队列，同时记录队尾元素，因为队尾元素相当于栈顶元素，
-(void)push:(int)val{
    [self.array addObject:@(val)];
}

/** 删除栈顶的元素并返回
 我们的底层数据结构是先进先出的队列，每次 pop 只能从队头取元素；但是栈是后进先出，也就是说 pop API 要从队尾取元素。
 
 解决方法简单粗暴，把队列前面的都取出来再加入队尾，让之前的队尾元素排到队头，这样就可以取出了：
 */
-(int)pop{
    int top = [self top];
    [self.array removeLastObject];
    return top;
}
/** 返回栈顶元素 */
//如果要 top 查看栈顶元素的话可以直接返回
-(int)top{
    return [self.array.lastObject intValue];
}

/** 判断栈是否为空 */
//API empty 就很容易实现了，只要看底层的队列是否为空即可：
-(BOOL)empty;{
    return self.array.count==0;
}
@end
