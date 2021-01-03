//
//  _42_Trapping_Rain_Water.m
//  LeetCode
//
//  Created by 58 on 2020/11/14.
//

#import "_42_Trapping_Rain_Water.h"

@implementation _42_Trapping_Rain_Water
/**
 42. 接雨水 $$$$$
 难度 困难
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

/**
 这就是本问题的核心思路，我们可以简单写一个暴力算法
 有之前的思路，这个解法应该是很直接粗暴的，时间复杂度 O(N^2)，空间复杂度 O(1)。但是很明显这种计算 r_max 和 l_max 的方式非常笨拙，一般的优化方法就是备忘录。
 */
int trap1(int *height, int heightSize){
    int res = 0;
    for (int i = 1; i < heightSize - 1; i++) {
        int l_max = 0, r_max = 0;
        // 找右边最高的柱子
        for (int j = i; j < heightSize; j++)
            r_max = max(r_max, height[j]);
        // 找左边最高的柱子
        for (int j = i; j >= 0; j--)
            l_max = max(l_max, height[j]);
        //结果
        res += min(l_max, r_max) - height[i];
    }
    return res;
}

/**
 之前的暴力解法，不是在每个位置 i 都要计算 r_max 和 l_max 吗？我们直接把结果都提前计算出来，别傻不拉几的每次都遍历，这时间复杂度不就降下来了嘛
 我们开两个数组 r_max 和 l_max 充当备忘录，l_max[i] 表示位置 i 左边最高的柱子高度，r_max[i] 表示位置 i 右边最高的柱子高度。预先把这两个数组计算好，避免重复计算
 
 优化其实和暴力解法思路差不多，就是避免了重复计算，把时间复杂度降低为 O(N)，已经是最优了，但是空间复杂度是 O(N)。下面来看一个精妙一些的解法，能够把空间复杂度降低到 O(1)。
 */
int trap2(int *height, int heightSize){
    if (height == NULL || heightSize <= 1) {
        return 0;
    }
    int res = 0;
    int *l_max=(int *)malloc(sizeof(int)*heightSize);
    int *r_max=(int *)malloc(sizeof(int)*heightSize);
    l_max[0] = height[0]; // 第一个元素的l_max就是他本身
    r_max[heightSize - 1]=height[heightSize-1]; // 最后一个元素的r_max就是他本身
    // 从左向右计算 l_max
    for (int i = 1; i < heightSize; i++){
        l_max[i]=max(height[i], l_max[i-1]);
    }
    // 从右向左计算 r_max
    for (int i = heightSize - 2; i >= 0; i--){
        r_max[i]=max(height[i], r_max[i+1]);
    }
    // 计算答案
    for (int i = 1; i < heightSize - 1; i++){
        int minH=min(l_max[i], r_max[i]);
        res += minH - height[i];
    }
    free(l_max);
    free(r_max);
    return res;
}

/**
 用双指针边走边算，节省空间复杂度,达到O（1）
 */
int trap3(int *height, int heightSize){
    if (height == NULL || heightSize <= 1) {
        return 0;
    }
    // 双指针--索引
    int left = 0, right = heightSize - 1;
    // l_max 默认是左边第一个柱子高度
    int l_max = height[0];
    // r_max 默认最后一个柱子高度
    int r_max = height[heightSize - 1];
    int res = 0;
    while (left <= right) {
        //l_max 是 height[0..left] 中最高柱子的高度
        l_max = max(l_max, height[left]);
        //r_max 是 height[right..end] 的最高柱子的高度
        r_max = max(r_max, height[right]);
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


+(void)trapTest{
    int a[]={4,2,0,3,5};
    printf("%d ",trap2(a,5));
}



@end
