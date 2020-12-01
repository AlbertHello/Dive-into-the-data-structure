//
//  _155_Min_Stack.m
//  LeetCode
//
//  Created by Albert on 2020/12/1.
//

#import "_155_Min_Stack.h"

@interface Node_155 : NSObject
@property(nonatomic,assign)NSInteger val;
@property(nonatomic,assign)NSInteger min;
@property(nonatomic,strong)Node_155 *next;

-(instancetype)initWithVal:(NSInteger)val min:(NSInteger)min next:(Node_155 *)node;
@end

@implementation Node_155
-(instancetype)initWithVal:(NSInteger)val min:(NSInteger)min next:(Node_155 *)node{
    if (self=[super init]) {
        self.val=val;
        self.min=min; // 记录下当前链表中最小的值。
        self.next=node; // 头插法 最新的节点永远在第一个，模仿栈的特性。
    }
    return self;
}


@end

@interface _155_Min_Stack ()

@property(nonatomic,strong)Node_155 *head;

@end

@implementation _155_Min_Stack
/**
 155. 最小栈
 设计一个支持 push ，pop ，top 操作，并能在常数时间内检索到最小元素的栈。
 push(x) —— 将元素 x 推入栈中。
 pop() —— 删除栈顶的元素。
 top() —— 获取栈顶元素。
 getMin() —— 检索栈中的最小元素。

 示例:

 输入：
 ["MinStack","push","push","push","getMin","pop","top","getMin"]
 [[],[-2],[0],[-3],[],[],[],[]]

 输出：
 [null,null,null,null,-3,null,0,-2]

 解释：
 MinStack minStack = new MinStack();
 minStack.push(-2);
 minStack.push(0);
 minStack.push(-3);
 minStack.getMin();   --> 返回 -3.
 minStack.pop();
 minStack.top();      --> 返回 0.
 minStack.getMin();   --> 返回 -2.
  

 提示：
 pop、top 和 getMin 操作总是在 非空栈 上调用。
 */

//此题基于链表完成。也可以使用两个栈完成：
//一个栈正常压入数据，另一个值压入min。



// 时间复杂度： O（1）
// 空间复杂度： O（1）
- (instancetype)init{
    self = [super init];
    if (self) {
        // 初始化head。最小值用INTMAX_MAX最大值
        self.head=[[Node_155 alloc]initWithVal:0 min:INTMAX_MAX next:nil];
    }
    return self;
}
// 时间复杂度： O（1）
// 空间复杂度： O（1）
-(void)push:(NSInteger)x{
    // 头插法。每个新push的值都在最前面。模仿栈的特性
    // 每个节点都保存着基于当前链表的最小值。
    self.head=[[Node_155 alloc] initWithVal:x min:MIN(x, self.head.min) next:self.head];
}
// 时间复杂度： O（1）
// 空间复杂度： O（1）
-(void)pop{
    self.head = self.head.next;
}
// 时间复杂度： O（1）
// 空间复杂度： O（1）
-(NSInteger)top{
    return self.head.val;
}
// 时间复杂度： O（1）
// 空间复杂度： O（1）
-(NSInteger)getMin{
    return self.head.min;
}






@end
