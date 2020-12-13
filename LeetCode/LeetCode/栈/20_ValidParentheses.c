//
//  20_ValidParentheses.c
//  链表
//
//  Created by 58 on 2020/10/15.
//  Copyright © 2020 58. All rights reserved.
//

#include "20_ValidParentheses.h"

/**
 20. 有效的括号
 给定一个只包括 '('，')'，'{'，'}'，'['，']' 的字符串，判断字符串是否有效。

 有效字符串需满足：

 左括号必须用相同类型的右括号闭合。
 左括号必须以正确的顺序闭合。
 注意空字符串可被认为是有效字符串。

 示例 1:

 输入: "()"
 输出: true
 示例 2:

 输入: "()[]{}"
 输出: true
 示例 3:

 输入: "(]"
 输出: false
 示例 4:

 输入: "([)]"
 输出: false
 示例 5:

 输入: "{[]}"
 输出: true

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/valid-parentheses
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */


//算法思想：
// 利用栈的思想，只要是左侧括号就入栈，然后遍历到右边括号，则取出来栈顶元素，
// 和这个右侧括号看能不能组成一个完成的括号，能组成则把栈顶元素删除。接着往下遍历
// 每次需要比较时代表碰到了右侧括号，如果此时栈空了，则false。因为没有左侧的括号比较了。
// 如果栈还没空，字符串都遍历完了，代表栈中剩下了一个或多个左侧括号，也是false

/**
 复杂度分析
 时间复杂度：O(n)，其中 n 是字符串 s 的长度。
 空间复杂度：O(n+∣Σ∣)，其中 Σ 表示字符集，本题中字符串只包含6种括号，∣Σ∣=6。栈中的字符数量为O(n)，
 而哈希映射使用的空间为O(∣Σ∣)，相加即可得到总空间复杂度。
 */


char pairs(char a) {
    if (a == '}') return '{';
    if (a == ']') return '[';
    if (a == ')') return '(';
    return 0;
}

bool isValid(char* s) {
    size_t n = strlen(s);
    if (n % 2 == 1) {
        //如果字符串程度是奇数，则肯定是false
        return false;
    }
    int stk[n + 1]; // 数组当做栈使用
    //因为这里是数组，top索引可以表示为栈顶指针。
    //取栈顶元素时并没有删除栈顶元素,只是索引减一，也代表了栈顶指针下移
    //再有元素入栈是top+1后直接覆盖原来的值，相当于新的元素入栈了
    int top = 0;
    for (int i = 0; i < n; i++) {
        char ch = pairs(s[i]);
        if (ch) { // ch 有值，代表s[i]是又括号
            //索引为0代表栈空了，如若占空了还有字符需要比较则false
            //如果栈不为空，则取出栈顶元素和这个右括号相匹配的左括号比较
            //相等则这俩是一对
            if (top == 0 || stk[top - 1] != ch) {
                return false;
            }
            //同事栈顶指针往下走一个。
            top--; // 碰到配对儿的出栈
        } else {
            //遇到左括号就入栈
            stk[top++] = s[i];
        }
    }
    return top == 0;  // 如果栈还没空，字符串都遍历完了，代表栈中剩下了一个或多个左侧括号，也是false
}


void validParenthesesTest(){
    char *str="}}{}{()()";
    bool res=isValid(str);
    printf("res= %d\n",res);
}
