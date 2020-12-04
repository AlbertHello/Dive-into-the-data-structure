//
//  _151_Reverse_Words_in_a_String.m
//  LeetCode
//
//  Created by 58 on 2020/12/4.
//

#import "_151_Reverse_Words_in_a_String.h"

@implementation _151_Reverse_Words_in_a_String

/**
 151. 翻转字符串里的单词
 给定一个字符串，逐个翻转字符串中的每个单词。
 说明：
 无空格字符构成一个 单词 。
 输入字符串可以在前面或者后面包含多余的空格，但是反转后的字符不能包括。
 如果两个单词间有多余的空格，将反转后单词间的空格减少到只含一个。
 示例 1：
 输入："the sky is blue"
 输出："blue is sky the"
 示例 2：
 输入："  hello world!  "
 输出："world! hello"
 解释：输入字符串可以在前面或者后面包含多余的空格，但是反转后的字符不能包括。
 示例 3：
 输入："a good   example"
 输出："example good a"
 解释：如果两个单词间有多余的空格，将反转后单词间的空格减少到只含一个。
 示例 4：
 输入：s = "  Bob    Loves  Alice   "
 输出："Alice Loves Bob"
 示例 5：
 输入：s = "Alice does not even like bob"
 输出："bob like even not does Alice"
 提示：
 1 <= s.length <= 104
 s 包含英文大小写字母、数字和空格 ' '
 s 中 至少存在一个 单词
 进阶：
 请尝试使用 O(1) 额外空间复杂度的原地解法。
 */
/**
 思路：
 1 消除多余空格
 2 对整理完的字符串进行整体反转
 3 再对每个单词反转
 
 时间复杂度：O(n+len) n是原始字符串的长度，len是最终字符串的长度
 空间复杂度：O(n+len) n是原始字符串的长度，创建了一个temp字符串。len是最终返回的新创建的字符串
 */
// 将[li, ri)范围内的字符串进行逆序。 左闭右开
void reverse(char *chars, int li, int ri){
    ri--;
    while (li < ri) { // 头尾对调，即可完成反转
        char tmp = chars[li];
        chars[li] = chars[ri];
        chars[ri] = tmp;
        li++;
        ri--;
    }
}

char * reverseWords(char * s){
    if (s == NULL) return "";
    // 1 消除多余的空格
    // 长度
    size_t length=strlen(s);
    
    char *temp = (char *)malloc(sizeof(char)*length);
    memcpy(temp, s, length);
    // 字符串最终的有效长度
    int len = 0;
    // 当前用来存放字符的位置
    int cur = 0;
    // 前一个字符是否为空格字符
    bool space = true;
    for (int i = 0; i < length; i++) {
        if (s[i] != ' ') { // s[i]是非空格字符
            temp[cur++] = s[i];
            space = false;
        } else if (space == false) {
            // 来到此处代表s[i]是空格字符。chars[i - 1]是非空格字符
            temp[cur++] = ' ';
            space = true; // 添加一个空格后就设置为true，i再移动碰到一个连续的空格也不会再来这里。
        }
        // 到这里就是cur不动，i加一
    }
    // 到这里如果 space 为真，则最终字符串最后一个空格。最终字符串长度撇去这个空格。
    len = space ? (cur - 1) :cur;
    if (len <= 0){
        free(temp);
        return ""; // 愿输入字符串都是空格
    }
    
    // 2 对整一个有效字符串进行逆序
    reverse(temp, 0, len);
    
    // 3 对每一个单词进行逆序
    int prevSapceIdx = -1; // 前一个空格字符的位置，和后一个空格字符的位置相减就是俩空格之间的单词
    for (int i = 0; i < len; i++) {
        if (temp[i] != ' ') continue; // 如果不是空格，则继续i++
        // i是空格字符的位置
        // prevSapceIdx + 1 就是俩空格之间的单词的第一个字符的index
        // 左闭右开
        reverse(temp, prevSapceIdx + 1, i);
        prevSapceIdx = i;
    }
    // 翻转最后一个单词
    // 之所以在这里右单独处理最后一个单词，没有在上面的循环中设置 i <= len 进行处理是因为：
    // 我们求出的len是消除多余的空格得到的有效字符串的长度，字符串s的len长度之后就是剩下的多余的字符
    // 如果设置 i <= len ，for循环中第一个条件if (s[i] != ' ') continue，就有可能让i再次i++
    // 超过len，就跳出了循环，页处理不了最后一个单词。
    // 所以放在外面处理最合适
    reverse(temp, prevSapceIdx + 1, len);
    char *final = (char *)malloc(sizeof(char)*(len+1));
    memcpy(final, temp, len);
    free(temp);
    return final;
}

+(void)reverseWordsTest{
    char *original="a good   example";
    printf("原长度： %lu 原串: _%s_\n",strlen(original),original);
    char *final = reverseWords(original);
    printf("后长度： %lu 后串: _%s_\n",strlen(final),final);
}






@end
