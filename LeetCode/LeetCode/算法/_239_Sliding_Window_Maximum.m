//
//  _239_Sliding_Window_Maximum.m
//  LeetCode
//
//  Created by Albert on 2020/12/2.
//

#import "_239_Sliding_Window_Maximum.h"
@interface _239_Sliding_Window_Maximum ()
//用数组模拟双端队列。双端队列就是头尾均可加入元素和删除元素的队列
@property(nonatomic,strong)NSMutableArray *dequeue;
@end
@implementation _239_Sliding_Window_Maximum
/**
 239. 滑动窗口最大值
 https://leetcode-cn.com/problems/sliding-window-maximum/
 给定一个数组 nums，有一个大小为 k 的滑动窗口从数组的最左侧移动到数组的最右侧。你只可以看到在滑动窗口内的 k 个数字。滑动窗口每次只向右移动一位。
 返回滑动窗口中的最大值。
 进阶：
 你能在线性时间复杂度内解决此题吗？
 示例:

 输入: nums = [1,3,-1,-3,5,3,6,7], 和 k = 3
 输出: [3,3,5,5,6,7]
 解释:

   滑动窗口的位置                最大值
 ---------------               -----
 [1  3  -1] -3  5  3  6  7       3
  1 [3  -1  -3] 5  3  6  7       3
  1  3 [-1  -3  5] 3  6  7       5
  1  3  -1 [-3  5  3] 6  7       5
  1  3  -1  -3 [5  3  6] 7       6
  1  3  -1  -3  5 [3  6  7]      7

 提示：
 1 <= nums.length <= 10^5
 -10^4 <= nums[i] <= 10^4
 1 <= k <= nums.length
 */

/**
 解法一
 使用双端队列解决。
 思路：
 ① 如果 nums[ i ] >= nums[ 队尾 ]，不断删除队尾，直到 nums[ 队尾 ] > nums[ i ]
 ② 将 i 加入队尾
 ③ 如果 w > = 0
    • 删除失效的队头（队头 < w 就代表失效）
    • 更新 w 位置的窗口最大值为nums[ 队头 ]
 注意
 • 队列中存放的是索引
 • 从对头到对尾，nums[ 队列元素 ] ，是逐渐减小的
 
 */

-(NSArray *)maxSlidingWindow_deque:(NSArray *)nums windowSize:(int) k {
    if (nums == nil || nums.count == 0 || k < 1) return @[];
    if (k == 1) return nums;

    //创建最大值数组。数组的长度就是nums.count - k + 1
    NSMutableArray *maxes=[NSMutableArray arrayWithCapacity:nums.count - k + 1];
    
    // peek: 取值（偷偷瞥一眼）
    // poll: 删除（削）
    // offer: 添加（入队）
    //用数组模拟双端队列。双端队列就是头尾均可加入元素和删除元素的队列
    NSMutableArray *deque=[NSMutableArray array];//
    for (int ri = 0; ri < nums.count; ri++) {
        // 只要nums[队尾] <= nums[i]，就删除队尾
        while (deque.count != 0  && [nums[ri] intValue] >= nums[[deque.lastObject intValue]]) {
            // deque.pollLast();
//            deque.removeLast();
            [deque removeLastObject];
        }
        
        // 将i加到队尾
        // deque.offerLast(ri);
//        deque.addLast(ri);
        [deque addObject:@(ri)];
        
        // 检查窗口的索引是否合法
        int li = ri - k + 1;
        if (li < 0) continue;
        
        // 检查队头的合法性
        if ([deque.firstObject intValue] < li) {
            // 队头不合法（失效，不在滑动窗口索引范围内）
            // deque.pollFirst();
//            deque.removeFirst();
            [deque removeObjectAtIndex:0];
        }
        // 设置窗口的最大值
        int index = [deque.firstObject intValue];
        maxes[li] = nums[index];
    }
    return maxes;
}






@end
