//
//  4_MedianofTwoSortedArrays.c
//  链表
//
//  Created by 58 on 2020/10/14.
//  Copyright © 2020 58. All rights reserved.
//

#include "4_MedianofTwoSortedArrays.h"

/*
 4. 寻找两个正序数组的中位数 ¥¥¥¥¥
 难度 困难
 给定两个大小为 m 和 n 的正序（从小到大）数组 nums1 和 nums2。请你找出并返回这两个正序数组的中位数。

 进阶：你能设计一个时间复杂度为 O(log (m+n)) 的算法解决此问题吗？

  

 示例 1：

 输入：nums1 = [1,3], nums2 = [2]
 输出：2.00000
 解释：合并数组 = [1,2,3] ，中位数 2
 示例 2：

 输入：nums1 = [1,2], nums2 = [3,4]
 输出：2.50000
 解释：合并数组 = [1,2,3,4] ，中位数 (2 + 3) / 2 = 2.5
 示例 3：

 输入：nums1 = [0,0], nums2 = [0,0]
 输出：0.00000
 示例 4：

 输入：nums1 = [], nums2 = [1]
 输出：1.00000
 示例 5：

 输入：nums1 = [2], nums2 = []
 输出：2.00000
  

 提示：

 nums1.length == m
 nums2.length == n
 0 <= m <= 1000
 0 <= n <= 1000
 1 <= m + n <= 2000
 -10^6 <= nums1[i], nums2[i] <= 10^6

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/median-of-two-sorted-arrays
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

/**
 给定两个有序数组，要求找到两个有序数组的中位数，最直观的思路有以下两种：

1 使用归并的方式，合并两个有序数组，得到一个大的有序数组。大的有序数组的中间位置的元素，即为中位数。

2 不需要合并两个有序数组，只要找到中位数的位置即可。由于两个数组的长度已知，
 因此中位数对应的两个数组的下标之和也是已知的。维护两个指针，初始时分别指向两个数组的下标0的位置，每次将指向较小值的指针后移一位（如果一个指针已经到达数组末尾，则只需要移动另一个数组的指针），直到到达中位数的位置。假设两个有序数组的长度分别为m 和n，上述两种思路的复杂度如何？

 第一种思路的时间复杂度是O(m+n)，空间复杂度是O(m+n)。
 第二种思路虽然可以将空间复杂度降到O(1)，但是时间复杂度仍是O(m+n)。题目要求时间复杂度是O(log(m+n))，
 因此上述两种思路都不满足题目要求的时间复杂度。

 如何把时间复杂度降低到O(log(m+n)) 呢？如果对时间复杂度的要求有log，通常都需要用到二分查找，这
 道题也可以通过二分查找实现。

 */

//第一种 合并数组，取中位数
//时间复杂度：遍历全部数组O(m+n)
//空间复杂度：开辟了一个数组，保存合并后的两个数组O(m+n)
double findMedianSortedArrays(int* nums1, int nums1Size, int* nums2, int nums2Size){
    
    int m = nums1Size;
    int n = nums2Size;
    int *nums=(int *)malloc(sizeof(int)*(m+n));
    
    if (m == 0) { // 数组1空
        if (n % 2 == 0) { //如果数组2的元素个数是偶数
            //则取数组中间两个数的平均数
            return (nums2[n / 2 - 1] + nums2[n / 2]) / 2.0;
        } else {
            //奇数个
            return nums2[n / 2];
        }
    }
    if (n == 0) { //数组2空
        if (m % 2 == 0) {//如果数组1的元素个数是偶数
            //则取数组中间两个数的平均数
            return (nums1[m / 2 - 1] + nums1[m / 2]) / 2.0;
        } else {
            //奇数个
            return nums1[m / 2];
        }
    }

    //准备合并俩数组
    int count = 0;
    int i = 0, j = 0;
    while (count != (m + n)) {
        if (i == m) {
//          此处表示数组1已经遍历完了。
            while (j != n) {
//                数组2剩下的元素直接快速装到nums数组中
                nums[count++] = nums2[j++];
            }
            break;
        }
        if (j == n) {
//          此处表示数组2已经遍历完了。
            while (i != m) {
//                数组1剩下的元素直接快速装到nums数组中
                nums[count++] = nums1[i++];
            }
            break;
        }
//        俩数组都还没遍历完时：
        if (nums1[i] < nums2[j]) {
//            nums累计添加nums1中的元素，然后nums1的下标i+1
//            同事nums2的下标j不动。
            nums[count++] = nums1[i++];
        } else {
//            nums累计添加nums2中的元素，然后nums1的下标j+1
//            同事nums1的下j不动。
            nums[count++] = nums2[j++];
        }
    }
//    合并完后的数组，取中位数
    if (count % 2 == 0) {
        return (nums[count / 2 - 1] + nums[count / 2]) / 2.0;
    } else {
        return nums[count / 2];
    }
}
/**
 思路：
 1、在有序数组中寻找中位数其实就是找一个边界线，边界线左边的数是左边数组中的最大值left_max，右边的数是右边数组的最小值right_min。奇数长度和偶数长度无非是一个数决定中位数还是两个数求平均的问题
 2 合适的边界线满足的条件：把两个数组的分界线右侧部分交换仍能满足两个数组是升序数组，
 也就是：nums1_left_max < nums2_right_min && num2_left_max < num1_right_min
 比如：
 nums1: 2 4 6 | 15
 nums2: 1 7 | 8 10 17
 交换分界线右侧部分:
 nums1: 2 4 6 | 8 10 17
 nums2: 1 7 | 15
 
 分界线条件：
 2.1 分界线左边所有的数都小于等于分界线右边所有的数；
 2.2 分界线左边所有元素的个数left_size和分界线右边所有元素个数right_size满足：
    2.2.1 m+n=奇数时：left_size=right_size+1；
    2.2.2 m+n=偶数时：left_size=right_size；
 比如：
 m+n=奇数，left_size=5， right_size=4
 nums1, m=4 : 2 4 6 | 15
 nums2, n=5 : 1 7 | 8 10 17
 
 m+n=偶数，left_size=5， right_size=5
 nums1, m=4 : 2 4 6 | 15
 nums2, n=6 : 1 7 | 8 10 17 20
 
 3. 边界条件
 3.1 num1长度短：
    3.1.1 数组1的分界线已经在最右侧：
    nums1, m=4 : 2 4 6 7 ｜
    nums2, n=6 : 8 ｜ 9 10 11 12 13
    这种情况相当于num1最右侧的数是INT_MAX，最终比较分界线右侧的值时取最小值，也就是取9
 
    3.1.2 数组1的分界线已经在最左侧：
    nums1, m=4 : ｜19 20 21 22
    nums2, n=8 : 8 9 10 11 12 13 ｜ 14 15
    这种情况相当于num1最左侧的数是INT_MIN，最终比较分界线左侧的值时取最大值，也就是取13
 
    
 3.2 num1长度长：
    3.1.1 数组2的分界线已经在最右侧：
    nums1, m=6 : 8 ｜ 9 10 11 12 13
    nums2, n=4 : 2 4 6 7 ｜
    这种情况相当于num2最右侧的数是INT_MAX，最终比较分界线右侧的值时取最小值，也就是取9
 
    3.1.2 数组2的分界线已经在最左侧：
    nums1, m=8 : 8 9 10 11 12 13 ｜ 14 15
    nums2, n=4 : ｜19 20 21 22
    这种情况相当于num2最左侧的数是INT_MIN，最终比较分界线左侧的值时取最大值，也就是取13
 
 4. 分界线的索引
 分界线也就是两个数组中的索引i和j，那么left_size=i+j
 当m+n=奇数时，left_size=(m+n+1)/2
 当m+n=偶数时，left_size=(m+n)/2
 
 其实无论m+n等于奇数还是偶数， left_size都等于(m+n+1)/2，所以(m+n+1)/2=i+j，所j=(m+n+1)/2-i
 所以索引j确定了，只关心索引i就行了
 
 5. 三种条件判断：
    5.1 num2[j-1] < num1[i]
    此时数组2左边的最大值比数组1右边的最小值要大，说明数组1左边部分要扩大（i+1）
 
    5.2 num1[i-1] > num2[j]
    数组1左边的最大值大于数组2左边的最小值，说明数组1左边部分要缩小 i-1
 
    5.3 nums1_left_max < nums2_right_min && num2_left_max < num1_right_min
    这种情况就是我们要找的i
 
 注意：
 1. 尽量让数组1的长度短，可以缩小二分查找的循环次数
 2. i 的取值范围 0 - m
 3. 处理边界情况
 
 时间复杂度： O(log(min(M,N)))，为了使得搜索更快，我们把更短的数组设置为 nums1 ，因为使用二分查找法，在它的长度的对数时间复杂度内完成搜索。
 空间复杂度：O(1)，只使用了常数个的辅助变量。
 
 参考：
 https://blog.csdn.net/lw_power/article/details/97184524
 */
double findMedianSortedArrays2(int* nums1, int nums1Size, int* nums2, int nums2Size){
    // 为了让搜索范围更小，我们始终让 num1 是那个更短的数组，PPT 第 9 张
    if (nums1Size > nums2Size) {
        int *temp = nums1;
        nums1 = nums2;
        nums2 = temp;
    }
    
    // 上述交换保证了 m <= n，在更短的区间 [0, m] 中搜索，会更快一些
    int m = sizeof(nums1);
    int n = sizeof(nums2);

    // 使用二分查找算法在数组 nums1 中搜索一个索引 i，PPT 第 9 张
    int left = 0;
    int right = m;
    // 这里使用的是最简单的、"传统"的二分查找法模板，使用"高级的"二分查找法模板在退出循环时候处理不方便
    while (left <= right) {
        // 尝试要找的索引，在区间里完成二分，为了保证语义，这里就不定义成 mid 了
        // 用加号和右移是安全的做法，即使在溢出的时候都能保证结果正确，但是 Python 中不存在溢出
        int i = (left + right) >> 1;
        // j 的取值在 PPT 第 7 张
        int j = ((m + n + 1) >> 1) - i;

        // 边界值的特殊取法的原因在 PPT 第 10 张
        int nums1LeftMax = i == 0 ? INT32_MIN : nums1[i - 1];
        int nums1RightMin = i == m ? INT32_MAX : nums1[i];

        int nums2LeftMax = j == 0 ? INT32_MIN : nums2[j - 1];
        int nums2RightMin = j == n ? INT32_MAX : nums2[j];

        // 交叉小于等于关系成立，那么中位数就可以从"边界线"两边的数得到，原因在 PPT 第 2 张、第 3 张
        if (nums1LeftMax <= nums2RightMin && nums2LeftMax <= nums1RightMin) {
            // 已经找到解了，分数组之和是奇数还是偶数得到不同的结果，原因在 PPT 第 2 张
            if (((m + n) & 1) == 1) { // (m + n) & 1 == (m + n) % 2
                return (nums1LeftMax > nums2LeftMax)? nums1LeftMax : nums2LeftMax;
            } else {
                int max=(nums1LeftMax > nums2LeftMax)? nums1LeftMax : nums2LeftMax;
                int min=(nums1RightMin<nums2RightMin)? nums1RightMin : nums2RightMin;
                
                return max+min / 2.0;
            }
        } else if (nums2LeftMax > nums1RightMin) {
            // 这个分支缩短边界的原因在 PPT 第 8 张
            left = i + 1;
        } else {
            // 这个分支缩短边界的原因在 PPT 第 8 张
            right = i - 1;
        }
    }
    
    return 0;
}


void findMedianSortedArraysTest(){
    int nums1[]={1,2,3};
    int nums2[]={2,4,1};
    
    double nums=findMedianSortedArrays(nums1, 3, nums2, 3);
    printf("aa\n");
}
