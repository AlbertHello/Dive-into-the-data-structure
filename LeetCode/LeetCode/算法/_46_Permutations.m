//
//  _46_Permutations.m
//  LeetCode
//
//  Created by 58 on 2020/11/20.
//

#import "_46_Permutations.h"

@interface _46_Permutations()

@property(nonatomic,strong)NSMutableArray *res;
@end

@implementation _46_Permutations

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.res=[NSMutableArray array];
    }
    return self;
}
/**
 46. 全排列
 给定一个 没有重复 数字的序列，返回其所有可能的全排列。
 示例:
 输入: [1,2,3]
 输出:
 [
   [1,2,3],
   [1,3,2],
   [2,1,3],
   [2,3,1],
   [3,1,2],
   [3,2,1]
 ]
 
 https://leetcode-cn.com/problems/permutations/
 */
/**
 「全排列」和「N 皇后问题」是两个经典的回溯算法问题
 解决一个回溯问题，实际上就是一个决策树的遍历过程。你只需要思考 3 个问题：
 1、路径：也就是已经做出的选择的记录。
 2、选择列表：也就是你当前可以做的选择。
 3、结束条件：也就是到达决策树底层，无法再做选择的条件。
 
 怎么穷举全排列的呢？比方说给三个数 [1,2,3]，你肯定不会无规律地乱穷举，一般是这样：
 先固定第一位为 1，然后第二位可以是 2，那么第三位只能是 3；然后可以把第二位变成 3，第三位就只能是 2 了；然后就只能变化第一位，变成 2，然后再穷举后两位……
「路径」，就是记录你已经做过的选择；
 [1,3] 就是「选择列表」，表示你当前可以做出的选择；
「
 结束条件」就是遍历到树的底层，在这里就是选择列表为空的时候。
 
 多叉树的遍历框架就是这样：
 void traverse(TreeNode root) {
     for (TreeNode child : root.childern)
         // 前序遍历需要的操作
         traverse(child);
         // 后序遍历需要的操作
 }
 而所谓的前序遍历和后序遍历，他们只是两个很有用的时间点，前序遍历的代码在进入某一个节点之前的那个时间点执行，后序遍历代码在离开某个节点之后的那个时间点执行。
 那么核心框架：
 for 选择 in 选择列表:
     # 做选择
     将该选择从选择列表移除
     路径.add(选择)
     backtrack(路径, 选择列表)
     # 撤销选择
     路径.remove(选择)
     将该选择再加入选择列表
 我们只要在递归之前做出选择，在递归之后撤销刚才的选择，就能正确得到每个节点的选择列表和路径。
 
 得出一组路径后，数组元素的拷贝：0（n）
 containsObject判断：O（n）
 递归调用次数：o（n!）
 其实可以通过交换元素达到目的替换containsObject的操作，但操作麻烦。
 无论怎么优化时间复杂度都不可能低于O(n!)，因为穷举整棵决策树是无法避免的。这也是回溯算法的一个特点，
 不像动态规划存在重叠子问题可以优化，回溯算法就是纯暴力穷举，复杂度一般都很高。
 */

-(NSArray *)permute:(NSArray *)nums{
    // 记录「路径」
    NSMutableArray *track=[NSMutableArray array];
    [self backtrack:nums recordTrack:track];
    return self.res;
}

// 路径：记录在 track 中
// 选择列表：nums 中不存在于 track 的那些元素
// 结束条件：nums 中的元素全都在 track 中出现
-(void)backtrack:(NSArray *)nums recordTrack:(NSMutableArray *)track{
    // 触发结束条件
    // 这里的结束条件可以判断选择列表是否空了，也可以判断路径列表长度是否等于选择列表长度了
    // 如果选择后者，那么进入下一层决策树时就不需要选择列表nums删除刚刚选出的那个选择了
    if (track.count == nums.count) {
        NSMutableArray *arr=[NSMutableArray arrayWithArray:track]; //O（n）
        [self.res addObject:arr];
        return;
    }
    for (int i = 0; i < nums.count; i++) {
        // 排除不合法的选择
        if ([track containsObject:nums[i]]) continue; //O（n）
        // 做选择
        [track addObject:nums[i]];
        // 进入下一层决策树
        // 上面把路径列表长度是否等于选择列表长度作为结束条件
        // 所以这不需要先[nums removeObjectAtIndex:i];
        [self backtrack:nums recordTrack:track];
        // 取消选择
        [track removeLastObject];
    }
}














@end
