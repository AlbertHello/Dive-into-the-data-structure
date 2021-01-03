//
//  _392_IsSubsequence.m
//  LeetCode
//
//  Created by Albert on 2021/1/3.
//

#import "_392_IsSubsequence.h"

@implementation _392_IsSubsequence


/**
 392. 判断子序列
 难度 简单
 https://leetcode-cn.com/problems/is-subsequence/
 给定字符串 s 和 t ，判断 s 是否为 t 的子序列
 字符串的一个子序列是原始字符串删除一些（也可以不删除）字符而不改变剩余字符相对位置形成的新字符串。（例如，"ace"是"abcde"的一个子序列，而"aec"不是）。
 进阶：
 如果有大量输入的 S，称作 S1, S2, ... , Sk 其中 k >= 10亿，你需要依次检查它们是否为 T 的子序列。在这种情况下，你会怎样改变代码？
 致谢：
 特别感谢 @pbrother 添加此问题并且创建所有测试用例。
 示例 1：
 输入：s = "abc", t = "ahbgdc"
 输出：true
 示例 2：
 输入：s = "axc", t = "ahbgdc"
 输出：false
 */
/**
 一个很简单的解法是这样的：利用双指针 i, j 分别指向 s, t，一边前进一边匹配子序列：
 
 时间复杂度只需 O(N)，N 为 t 的长度。
 */
bool isSubsequence(char *s, char *t) {
    int m = (int)strlen(s);
    int n = (int)strlen(t);
    if (m == 0) return true;
    if (n == 0) return false;
    int i=0,j=0;
    while (i < m && j < n){
        if (s[i] == t[j]) i++;
        j++;
    }
    // 只要i == strlen(s) 说明s串都已经匹配完了，否则就是没匹配完，while就结束了。
    return i == m;
}

// 查找左侧边界的二分查找
-(int)left_bound:(NSArray<NSNumber *> *)nums tat:(int)tar {
    int lo = 0, hi = (int)nums.count;
    while (lo < hi) {
        int mid = lo + (hi - lo) / 2;
        if (tar > nums[mid].intValue) {
            lo = mid + 1;
        } else {
            hi = mid;
        }
    }
    return lo;
}

/**
 处理多个S串
 */
-(BOOL)isSubsequence2:(NSString *)s t:(NSString *)t{
    int m = (int)s.length, n = (int)t.length;
    // 对 t 进行预处理
    NSMutableDictionary<NSString*,NSMutableArray<NSNumber *>*> *index_map=[NSMutableDictionary dictionary];
    for (int i = 0; i < n; i++) {
        NSString *c = [t substringWithRange:NSMakeRange(i, 1)];
        if (index_map[c] == nil){
            NSMutableArray *array=[NSMutableArray array];
            [index_map setObject:array forKey:c];
        }
        NSMutableArray *array=(NSMutableArray *)index_map[c];
        [array addObject:@(i)];
    }
    
    // 串 t 上的指针
    int j = 0;
    // 借助 index 查找 s[i]
    for (int i = 0; i < m; i++) {
        NSString *c = [s substringWithRange:NSMakeRange(i, 1)];
        // 整个 t 压根儿没有字符 c
        if (index_map[c] == nil) return false;
        NSMutableArray *nums=(NSMutableArray *)index_map[c];
        int pos = [self left_bound:nums tat:j];
        // 二分搜索区间中没有找到字符 c
        if (pos == index_map[c].count) return false;
        // 向前移动指针 j
        j = index_map[c][pos].intValue + 1;
    }
    return true;
}

@end
