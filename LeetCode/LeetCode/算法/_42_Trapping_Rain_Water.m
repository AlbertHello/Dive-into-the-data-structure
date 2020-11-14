//
//  _42_Trapping_Rain_Water.m
//  LeetCode
//
//  Created by 58 on 2020/11/14.
//

#import "_42_Trapping_Rain_Water.h"

@implementation _42_Trapping_Rain_Water
/**
 42. 接雨水
 难度
 输入：height = [0,1,0,2,1,0,1,3,2,1,2,1]
 输出：6
 解释：上面是由数组 [0,1,0,2,1,0,1,3,2,1,2,1] 表示的高度图，在这种情况下，可以接 6 个单位的雨水（蓝色部分表示雨水）。
 示例 2：

 输入：height = [4,2,0,3,2,5]
 输出：9

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/trapping-rain-water
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

/**
 不要考虑如何处理整个字符串，而是去思考应该如何处理每一个字符,具体来说，仅仅对于位置 i，能装下多少水呢？
 位置 i 能达到的水柱高度和其左边的最高柱子、右边的最高柱子有关，我们分别称这两个柱子高度为 l_max 和 r_max；位置 i 最大的水柱高度就是 min(l_max, r_max)。
 更进一步，对于位置 i，能够装的水为：
 water[i] = min(
                # 左边最高的柱子
                max(height[0..i]),
                # 右边最高的柱子
                max(height[i..end])
             ) - height[i] //  减去i自己的高度
 
 
 */

int max_42(int num1, int num2){
    return (num1 > num2) ? num1 : num2;
}
-(NSNumber *)max_42:(NSNumber *)num1 num2:(NSNumber *)num2{
    int v1=num1.intValue;
    int v2=num2.intValue;
    return (v1 > v2) ? num1 : num2;
}

int min_42(int num1, int num2){
    return (num1 < num2) ? num1 : num2;
}
-(NSNumber *)min_42:(NSNumber *)num1 num2:(NSNumber *)num2{
    int v1=num1.intValue;
    int v2=num2.intValue;
    return (v1 < v2) ? num1 : num2;
}

/**
 这就是本问题的核心思路，我们可以简单写一个暴力算法
 有之前的思路，这个解法应该是很直接粗暴的，时间复杂度 O(N^2)，空间复杂度 O(1)。但是很明显这种计算 r_max 和 l_max 的方式非常笨拙，一般的优化方法就是备忘录。
 */
int trap1(int *height){
    size_t n = sizeof(height);
    int res = 0;
    for (int i = 1; i < n - 1; i++) {
        int l_max = 0, r_max = 0;
        // 找右边最高的柱子
        for (int j = i; j < n; j++)
            r_max = max_42(r_max, height[j]);
        // 找左边最高的柱子
        for (int j = i; j >= 0; j--)
            l_max = max_42(l_max, height[j]);
        //结果
        res += min_42(l_max, r_max) - height[i];
    }
    return res;
}

/**
 之前的暴力解法，不是在每个位置 i 都要计算 r_max 和 l_max 吗？我们直接把结果都提前计算出来，别傻不拉几的每次都遍历，这时间复杂度不就降下来了嘛
 我们开两个数组 r_max 和 l_max 充当备忘录，l_max[i] 表示位置 i 左边最高的柱子高度，r_max[i] 表示位置 i 右边最高的柱子高度。预先把这两个数组计算好，避免重复计算
 
 优化其实和暴力解法思路差不多，就是避免了重复计算，把时间复杂度降低为 O(N)，已经是最优了，但是空间复杂度是 O(N)。下面来看一个精妙一些的解法，能够把空间复杂度降低到 O(1)。
 */
-(int)trap2:(NSArray *)height{
    NSUInteger count = height.count;
    int res = 0;
    NSMutableArray *l_max=[NSMutableArray array];
    NSMutableArray *r_max=[NSMutableArray array];
    l_max[0] = height[0];
    r_max[count - 1] = height[count - 1];
    // 从左向右计算 l_max
    for (int i = 1; i < count; i++){
        l_max[i]=[self max_42:height[i] num2:l_max[i - 1]];
    }
    // 从右向左计算 r_max
    for (NSUInteger i = count - 2; i >= 0; i--){
        r_max[i]=[self max_42:height[i] num2:r_max[i + 1]];
    }
    // 计算答案
    for (int i = 1; i < count - 1; i++){
        NSNumber *min_num = [self min_42:l_max[i] num2:r_max[i]];
        NSNumber *i_num = height[i];
        res += min_num.intValue - i_num.intValue;
    }
    return res;
}

/**
 用双指针边走边算，节省空间复杂度,达到O（1）
 */
int trap3(int *height){
    size_t n = sizeof(height);
    size_t left = 0, right = n - 1;
    int res = 0;
    int l_max = height[0];
    int r_max = height[n - 1];
    while (left <= right) {
        
        //l_max 是 height[0..left] 中最高柱子的高度
        l_max = max_42(l_max, height[left]);
        //r_max 是 height[right..end] 的最高柱子的高度
        r_max = max_42(r_max, height[right]);
        
        if (l_max < r_max) {
            res += l_max - height[left];
            left++;
        } else {
            res += r_max - height[right];
            right--;
        }
    }
    return res;
}



@end
