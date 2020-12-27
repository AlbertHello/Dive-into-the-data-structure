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
    left=head; // 左侧指针，指向第一个节点head
    return [self traverse:head];
}
/**
 这么做的核心逻辑是什么呢？实际上就是把链表节点放入一个栈，然后再拿出来，这时候元素顺序就是反的，只不过我们利用的是递归函数的堆栈而已。
 当然，无论造一条反转链表还是利用倒序遍历，算法的时间和空间复杂度都是 O(N)。下面我们想想，能不能不用额外的空间，解决这个问题呢？
 */
-(BOOL)traverse:(Node_234 *)right{
    if (right == nil) return true;
    // 这是代码递归就是一直把链表压栈，直到最后一个
    BOOL res =[self traverse:right.next];
    // 后序遍历代码
    // right到最后一个之后，left还是指向head的。
    // 这样就形成了首位双指针判断是否相等，随着递归往上回弹，首尾指针往中间靠拢
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
    //1 先通过「双指针技巧」中的快慢指针来找到链表的中点
    while (fast != nil && fast.next != nil) {
        slow = slow.next;
        fast = fast.next.next;
    }
    //2、如果fast指针没有指向null，说明链表长度为奇数，slow还要再前进一步：
    if (fast != nil) slow = slow.next;
    
    Node_234 *left = head;
    //3、从slow开始反转后面的链表，现在就可以开始比较回文串了
    Node_234 *right = [self reverseList_234:slow];
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
    while(cur_node != nil){
        Node_234* next_node=cur_node.next;
        cur_node.next=pre_node;
        pre_node=cur_node;
        cur_node=next_node;
    }
    return pre_node;
}


/**
 这种解法虽然高效，但破坏了输入链表的原始结构，能不能避免这个瑕疵呢？
 记下链表中点的前一个节点和后半部分反转后的头节点，在return之前把后半部分再reverse一遍，那后半部分就恢复原状了
 前半部分再把后半部分连起来整条链表就恢复原状了。
 */
-(BOOL)isPalindromeLink2AndSafe:(Node_234 *)head{
    Node_234 *slow=nil, *fast=nil, *mid_pre=nil;//定义mid_pre为链表中点的前一个节点
    slow = fast = head;
    //1 先通过「双指针技巧」中的快慢指针来找到链表的中点
    while (fast != nil && fast.next != nil) {
        mid_pre=slow;
        slow = slow.next;
        fast = fast.next.next;
    }
    //2、如果fast指针没有指向null，说明链表长度为奇数，slow还要再前进一步：
    if (fast != nil) {
        mid_pre=slow;
        slow = slow.next;
    }
    [self printLink:head];
    Node_234 *left = head;
    //3、从slow开始反转后面的链表，现在就可以开始比较回文串了
    Node_234 *right = [self reverseList_234:slow];
    Node_234 *last=right; //定义last为后半部分反转后的头节点
    [self printLink:last];
    BOOL flag = YES;
    while (right != nil) {
        if (left.val != right.val) {
            flag=NO;
            break;
        }
        left = left.next;
        right = right.next;
    }
    // 重新反转后面那一半，恢复链表原状
    mid_pre.next=[self reverseList_234:last];
    [self printLink:head];
    return flag;
}

-(void)printLink:(Node_234 *)head{
    if (head == nil) {
        return;
    }
    while (head != nil) {
        printf("%ld -> ",(long)head.val);
        head=head.next;
    }
    printf("null\n");
}
+(void)isPalindromeLinkTest{
    _234_Palindrome_Linked_List *ssss=[[_234_Palindrome_Linked_List alloc]init];
    Node_234 *head=[[Node_234 alloc]init];
    head.val=1;
    
    Node_234 *node2=[[Node_234 alloc]init];
    node2.val=2;
    
    Node_234 *node3=[[Node_234 alloc]init];
    node3.val=3;
    
    Node_234 *node4=[[Node_234 alloc]init];
    node4.val=2;
    
    Node_234 *node5=[[Node_234 alloc]init];
    node5.val=1;
    
//    Node_234 *node6=[[Node_234 alloc]init];
//    node6.val=1;
    
    head.next=node2;
    node2.next=node3;
    node3.next=node4;
    node4.next=node5;
    node5.next=nil;
    
    
    [ssss isPalindromeLink2AndSafe:head];
}
@end
