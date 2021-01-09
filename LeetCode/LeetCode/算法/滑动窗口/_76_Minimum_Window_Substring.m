//
//  _76_Minimum_Window_Substring.m
//  LeetCode
//
//  Created by Albert on 2021/1/1.
//

#import "_76_Minimum_Window_Substring.h"

@implementation _76_Minimum_Window_Substring


/**
 76. 最小覆盖子串
 难度 困难
 https://leetcode-cn.com/problems/minimum-window-substring/
 给你一个字符串 s 、一个字符串 t 。返回 s 中涵盖 t 所有字符的最小子串。如果 s 中不存在涵盖 t 所有字符的子串，则返回空字符串 "" 。
 注意：如果 s 中存在这样的子串，我们保证它是唯一的答案。
 示例 1：
 输入：s = "ADOBECODEBANC", t = "ABC"
 输出："BANC"
 示例 2：
 输入：s = "a", t = "a"
 输出："a"
 
 进阶：你能设计一个在 o(n) 时间内解决此问题的算法吗？
 */

char * minWindow(char * s, char * t){
    return NULL;
}


/**
  滑动窗口算法框架
 void slidingWindow(string s, string t) {
     unordered_map<char, int> need, window;
     for (char c : t) need[c]++;

     int left = 0, right = 0;
     int valid = 0;
     while (right < s.size()) {
         // c 是将移入窗口的字符
         char c = s[right];
         // 右移窗口
         right++;
         // 进行窗口内数据的一系列更新
         ...

         // debug 输出的位置
         printf("window: [%d, %d)\n", left, right);
         // 判断左侧窗口是否要收缩
         while (window needs shrink) {
             // d 是将移出窗口的字符
             char d = s[left];
             // 左移窗口
             left++;
             // 进行窗口内数据的一系列更新
             ...
         }
     }
 }
 
 滑动窗口算法的思路是这样：
 1、我们在字符串 S 中使用双指针中的左右指针技巧，初始化 left = right = 0，把索引左闭右开区间 [left, right) 称为一个「窗口」。
 2、我们先不断地增加 right 指针扩大窗口 [left, right)，直到窗口中的字符串符合要求（包含了 T 中的所有字符）。
 3、此时，我们停止增加 right，转而不断增加 left 指针缩小窗口 [left, right)，直到窗口中的字符串不再符合要求（不包含 T 中的所有字符了）。同时，每次增加 left，我们都要更新一轮结果。
 4、重复第 2 和第 3 步，直到 right 到达字符串 S 的尽头。
 
 第 2 步相当于在寻找一个「可行解」，然后第 3 步在优化这个「可行解」，最终找到最优解，也就是最短的覆盖子串。
 左右指针轮流前进，窗口大小增增减减，窗口不断向右滑动，这就是「滑动窗口」这个名字的来历。
 
 步骤：
 1 初始化 window 和 need 两个哈希表，记录窗口中的字符和需要凑齐的字符，如下
 unordered_map<char, int> need, window;
 for (char c : t) need[c]++;
 2 使用 left 和 right 变量初始化窗口的两端，不要忘了，区间 [left, right) 是左闭右开的，所以初始情况下窗口没有包含任何元素：
 int left = 0, right = 0;
 int valid = 0;
 while (right < s.size()) {
     // 开始滑动
 }
 其中 valid 变量表示窗口中满足 need 条件的字符个数，如果 valid 和 need.size 的大小相同，则说明窗口已满足条件，已经完全覆盖了串 T。
 3 现在开始套模板，只需要思考以下四个问题：
 3.1、当移动 right 扩大窗口，即加入字符时，应该更新哪些数据？
 3.2、什么条件下，窗口应该暂停扩大，开始移动 left 缩小窗口？
 3.3、当移动 left 缩小窗口，即移出字符时，应该更新哪些数据？
 3.4、我们要的结果应该在扩大窗口时还是缩小窗口时进行更新？
 如果一个字符进入窗口，应该增加 window 计数器；如果一个字符将移出窗口的时候，应该减少 window 计数器；当 valid 满足 need 时应该收缩窗口；应该在收缩窗口的时候更新最终结果。
 
 */
-(NSString *)minWindow:(NSString *)source target:(NSString *)target{
    
    
    // 统计target中每个字符的个数
    NSMutableDictionary<NSString*,NSNumber*> *needMap=[NSMutableDictionary dictionary];
    // 统计[left, right)组成的窗口中满足target要求的
    // windowMap 不是窗口，[left, right)才是窗口，
    NSMutableDictionary<NSString*,NSNumber*>*windowMap=[NSMutableDictionary dictionary];

    // 统计target中每个字符的个数
    for (int i=0; i<target.length; i++) {
        NSString *key=[NSString stringWithFormat:@"%c",[target characterAtIndex:i]];
        int v = needMap[key].intValue;
        [needMap setObject:@(v+1) forKey:key];
    }
    NSLog(@"needMap: %@",needMap);
    int left = 0, right = 0;
    int valid = 0;
    // 记录最小覆盖子串的起始索引及长度
    int start = 0, len = INT_MAX;
    while (right < source.length) {
        // c 是将移入窗口的字符
        NSString *c=[source substringWithRange:NSMakeRange(right, 1)];
        // 窗口右侧扩大,继续扩大窗口[left, right)
        right++;
        // 进行窗口内数据的一系列更新
        if ([needMap.allKeys containsObject:c]) {
            int v = windowMap[c].intValue;
            [windowMap setObject:@(v+1) forKey:c]; // 统计窗口内符合的字符
            // 满足一个则valid+1
            if (windowMap[c].intValue == needMap[c].intValue) valid++;
        }
        // 判断左侧窗口是否要收缩
        while (valid == needMap.count) {
            NSLog(@"windowMap: %@",windowMap);
            // 在这里更新最小覆盖子串
            if (right - left < len) {
                start = left;
                len = right - left;
            }
            NSLog(@"start: %d, len: %d",start,len);
            // d 是将移出窗口的字符
            NSString *d = [source substringWithRange:NSMakeRange(left, 1)];
            // 窗口左边收紧，开始缩小窗口[left, right)
            left++;
            // 如果移除的字符d是有用的，才进行窗口内数据的一系列更新
            if ([needMap.allKeys containsObject:d]) {
                // 只有某个字符个数相等才valid-1，因为windowMap[d] 可能是大于等于1的
                if (windowMap[d].intValue == needMap[d].intValue) valid--;
                int v = windowMap[d].intValue;
                [windowMap setObject:@(v-1) forKey:d]; // 更新
            }
        }
    }
    // 返回最小覆盖子串
    return len == INT_MAX ? @"" : [source substringWithRange:NSMakeRange(start, len)];
}

+(void)minWindowTest{
    _76_Minimum_Window_Substring *minWind=[[_76_Minimum_Window_Substring alloc]init];
    NSLog(@"min: %@",[minWind minWindow:@"ADOBECODEBANC" target:@"ABC"]);
}



@end
