//
//  _234_Palindrome_Linked_List.m
//  LeetCode
//
//  Created by 58 on 2020/11/10.
//

#import "_234_Palindrome_Linked_List.h"
@interface Node_234 : NSObject
@property(assign, nonatomic)NSInteger val;
@property(strong, nonatomic,nullable)Node_234 *next;
@end
@implementation Node_234
-(instancetype)init{
    if (self=[super init]) {
        self.next=nil;
    }
    return self;
}
@end


@implementation _234_Palindrome_Linked_List

/**
 234. 回文链表
请判断一个链表是否为回文链表。

 示例 1:

 输入: 1->2
 输出: false
 示例 2:

 输入: 1->2->2->1
 输出: true
 进阶：
 你能否用 O(n) 时间复杂度和 O(1) 空间复杂度解决此题？
 */

/**
 判断一个字符串是不是回文串就简单很多，不需要考虑奇偶情况，只需要「双指针技巧」，
 从两端向中间逼近即可：
 因为回文串是对称的，所以正着读和倒着读应该是一样的。
 bool isPalindrome(char *s) {
     size_t left = 0, right = strlen(s) - 1;
     while (left < right) {
         if (s[left] != s[right]) return false;
         left++; right--;
     }
     return true;
 }
 */
/**
 这道题的关键在于，单链表无法倒着遍历，无法使用双指针技巧。那么最简单的办法就是，把原始链表反转存入一条新的链表，然后比较这两条链表是否相同。
 
 其实，借助二叉树后序遍历的思路，不需要显式反转原始链表也可以倒序遍历链表，
 
 那么，链表其实也可以有前序遍历和后序遍历：
 
 void traverse(ListNode head) {
     // 前序遍历代码
     traverse(head.next);
     // 后序遍历代码
 }
 
 所以倒序打印单链表中的元素值
 void traverse(ListNode head) {
     if (head == null) return;
     traverse(head.next);
     // 后序遍历代码
     print(head.val);
 }
 
 */

// 左侧指针

Node_234* left=nil;

-(BOOL)isPalindromeLink:(Node_234 *)head{
    left=head;
    return [self traverse:head];
}

/**
 这么做的核心逻辑是什么呢？实际上就是把链表节点放入一个栈，然后再拿出来，这时候元素顺序就是反的，只不过我们利用的是递归函数的堆栈而已。
 
 当然，无论造一条反转链表还是利用倒序遍历，算法的时间和空间复杂度都是 O(N)。下面我们想想，能不能不用额外的空间，解决这个问题呢？
 */
-(BOOL)traverse:(Node_234 *)right{
    if (right == nil) return true;
    BOOL res =[self traverse:right.next];
    // 后序遍历代码
    res = res && (right.val == left.val);
    left = left.next;
    return res;
}


/**
 下面优化空间复杂度
 1 先通过「双指针技巧」中的快慢指针来找到链表的中点
 ListNode slow, fast;
 slow = fast = head;
 while (fast != null && fast.next != null) {
     slow = slow.next;
     fast = fast.next.next;
 }
 slow 指针现在指向链表中点
 2、如果fast指针没有指向null，说明链表长度为奇数，slow还要再前进一步：
 if (fast != null) slow = slow.next;
 3、从slow开始反转后面的链表，现在就可以开始比较回文串了
 ListNode left = head;
 ListNode right = reverse(slow);
 while (right != null) {
     if (left.val != right.val) return false;
     left = left.next;
     right = right.next;
 }
 return true;
 至此算法总体的时间复杂度 O(N)，空间复杂度 O(1)，已经是最优的了。
 */
-(BOOL)isPalindromeLink2:(Node_234 *)head{
    Node_234 *slow=nil, *fast=nil;
    slow = fast = head;
    while (fast != nil && fast.next != nil) {
        slow = slow.next;
        fast = fast.next.next;
    }
    if (fast != nil) slow = slow.next;
    
    Node_234 *left = head;
    Node_234 *right = [self reverseList_234:slow];;
    while (right != nil) {
        if (left.val != right.val) return false;
        left = left.next;
        right = right.next;
    }
    return true;
}
//反转链表
-(Node_234 *)reverseList_234:(Node_234 *)head{
    if (head == NULL || head.next == NULL) return head;
    Node_234* pre_node=nil;
    Node_234* cur_node=head;
    Node_234* next_node=nil;
    while(cur_node != nil){
        next_node=cur_node.next;
        cur_node.next=pre_node;
        pre_node=cur_node;
        cur_node=next_node;
    }
    return pre_node;
}

@end
