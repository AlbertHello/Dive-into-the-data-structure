//
//  _232_Implement_Queue_using_Stacks.m
//  LeetCode
//
//  Created by 58 on 2020/11/10.
//

#import "_232_Implement_Queue_using_Stacks.h"


@interface _232_Implement_Queue_using_Stacks()

@property(nonatomic,strong)NSMutableArray *stack1;
@property(nonatomic,strong)NSMutableArray *stack2;

@end

@implementation _232_Implement_Queue_using_Stacks

-(instancetype)init{
    if (self=[super init]) {
        self.stack1=[NSMutableArray array];
        self.stack2=[NSMutableArray array];
    }
    return self;
}

/**
 232. 用栈实现队列
 请你仅使用两个栈实现先入先出队列。队列应当支持一般队列的支持的所有操作（push、pop、peek、empty）：

 实现 MyQueue 类：

 void push(int x) 将元素 x 推到队列的末尾
 int pop() 从队列的开头移除并返回元素
 int peek() 返回队列开头的元素
 boolean empty() 如果队列为空，返回 true ；否则，返回 false
  

 说明：

 你只能使用标准的栈操作 —— 也就是只有 push to top, peek/pop from top, size, 和 is empty 操作是合法的。
 你所使用的语言也许不支持栈。你可以使用 list 或者 deque（双端队列）来模拟一个栈，只要是标准的栈操作即可。
  
 进阶：
 
 你能否实现每个操作均摊时间复杂度为 O(1) 的队列？换句话说，执行 n 个操作的总时间复杂度为 O(n) ，即使其中一个操作可能花费较长时间。
  

 示例：

 输入：
 ["MyQueue", "push", "push", "peek", "pop", "empty"]
 [[], [1], [2], [], [], []]
 输出：
 [null, null, null, 1, 1, false]

 解释：
 MyQueue myQueue = new MyQueue();
 myQueue.push(1); // queue is: [1]
 myQueue.push(2); // queue is: [1, 2] (leftmost is front of the queue)
 myQueue.peek(); // return 1
 myQueue.pop(); // return 1, queue is [2]
 myQueue.empty(); // return false
 
 提示：

 1 <= x <= 9
 最多调用 100 次 push、pop、peek 和 empty
 假设所有操作都是有效的 （例如，一个空的队列不会调用 pop 或者 peek 操作）
 

 */

/**
 这几个操作的时间复杂度是多少呢？ peek 操作，调用它时可能触发 while 循环，这样的话时间复杂度是 O(N)，但 while 循环并不是每次调用peek都被触发。由于 pop 操作调用了 peek，它的时间复杂度和 peek 相同。
 
 像这种情况，可以说它们的最坏时间复杂度是 O(N)，因为包含 while 循环，可能需要从 s1 往 s2 搬移元素。
 但是它们的均摊时间复杂度是 O(1)，这个要这么理解：对于一个元素，最多只可能被搬运一次，也就是说 peek 操作平均到每个元素的时间复杂度是 O(1)。
 */
/** 添加元素到队尾 */
-(void)push:(int)val{
    //当调用 push 让元素入队时，只要把元素压入 s1 即可
    [self.stack1 addObject:@(val)];
}

/** 删除队头的元素并返回
 对于 pop 操作，只要操作 s2 就可以了。
 */
-(int)pop{
    // 先调用 peek 保证 s2 非空
    int top = [self peek];
    [self.stack2 removeLastObject];
    return top;
}
/** 返回队头元素
 peek 查看队头的元素怎么办呢？按道理队头元素应该是 1，但是在 s1 中 1 被压在栈底，现在就要轮到 s2 起到一个中转的作用了：当 s2 为空时，可以把 s1 的所有元素取出再添加进 s2，这时候 s2 中元素就是先进先出顺序了。
 */
-(int)peek{
    if (self.stack2.count != 0) {
        // s2 不空就直接在s2中返回对头元素
        NSNumber *top=(NSNumber *)self.stack2.lastObject;
        return top.intValue;
    }else{
        // s2空时：
        while (self.stack1.count != 0) {
            [self.stack2 addObject:self.stack1.lastObject];
            [self.stack1 removeLastObject];
        }
        NSNumber *top=(NSNumber *)self.stack2.lastObject;
        return top.intValue;
    }
}
/** 判断队列是否为空
 如果两个栈都为空的话，就说明队列为空：
 */
-(BOOL)empty{
    return self.stack1.count==0 && self.stack2.count==0;
}





@end
