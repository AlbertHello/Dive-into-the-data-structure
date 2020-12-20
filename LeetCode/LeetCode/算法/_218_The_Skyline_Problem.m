//
//  _218_The_Skyline_Problem.m
//  LeetCode
//
//  Created by Albert on 2020/12/20.
//

#import "_218_The_Skyline_Problem.h"
#import "ListNode_C.h"



@implementation _218_The_Skyline_Problem


/**
 218. 天际线问题
 难度 困难
 https://leetcode-cn.com/problems/the-skyline-problem/
 城市的天际线是从远处观看该城市中所有建筑物形成的轮廓的外部轮廓。给你所有建筑物的位置和高度，请返回由这些建筑物形成的 天际线 。

 每个建筑物的几何信息由数组 buildings 表示，其中三元组 buildings[i] = [lefti, righti, heighti] 表示：

 lefti 是第 i 座建筑物左边缘的 x 坐标。
 righti 是第 i 座建筑物右边缘的 x 坐标。
 heighti 是第 i 座建筑物的高度。
 天际线 应该表示为由 “关键点” 组成的列表，格式 [[x1,y1],[x2,y2],...] ，并按 x 坐标 进行 排序 。关键点是水平线段的左端点。列表中最后一个点是最右侧建筑物的终点，y 坐标始终为 0 ，仅用于标记天际线的终点。此外，任何两个相邻建筑物之间的地面都应被视为天际线轮廓的一部分。

 注意：输出天际线中不得有连续的相同高度的水平线。例如 [...[2 3], [4 5], [7 5], [11 5], [12 7]...] 是不正确的答案；三条高度为 5 的线应该在最终输出中合并为一个：[...[2 3], [4 5], [12 7], ...]
 示例 1：
 输入：buildings = [[2,9,10],[3,7,15],[5,12,12],[15,20,10],[19,24,8]]
 输出：[[2,10],[3,15],[7,12],[12,0],[15,10],[20,8],[24,0]]
 解释：
 图 A 显示输入的所有建筑物的位置和高度，
 图 B 显示由这些建筑物形成的天际线。图 B 中的红点表示输出列表中的关键点。
 示例 2：
 输入：buildings = [[0,2,3],[2,5,3]]
 输出：[[0,3],[5,0]]
 提示：
 1 <= buildings.length <= 10^4
 0 <= lefti < righti <= 2^31 - 1
 1 <= heighti <= 2^31 - 1
 buildings 按 lefti 非递减排序
 */
-(NSMutableArray*)getSkyline:(NSMutableArray*)buildings{
    if(buildings.count == 0){
        return  [NSMutableArray array];
    }
    return [self merge:buildings start:0 end:(int)buildings.count-1];
}

/**
 有些类似归并排序的思想，divide and conquer 。
 首先考虑，如果只给一个建筑 [x, y, h]，那么答案是多少？
 很明显输出的解将会是 [[x, h], [y, 0]]，也就是左上角和右下角坐标。
 接下来考虑，如果有建筑 A B C D E，我们知道了建筑 A B C 输出的解和 D E 输出的解，那么怎么把这两组解合并，得到 A B C D E 输出的解。
 合并方法采用归并排序中双指针的方法，将两个指针分别指向两组解的开头，然后进行比对。具体的，看下边的例子。
 每次选取 x 坐标较小的点，然后再根据一定规则算出高度，具体的看下边的过程。
 Skyline1 = {(1, 11),  (3, 13),  (9, 0),  (12, 7),  (16, 0)}
 Skyline2 = {(14, 3),  (19, 18), (22, 3), (23, 13),  (29, 0)}
 Skyline1 存储第一组的解。
 Skyline2 存储第二组的解。
 Result 存储合并后的解, Result = {}
 h1 表示将 Skyline1 中的某个关键点加入 Result 中时, 当前关键点的高度
 h2 表示将 Skyline2 中的某个关键点加入 Result 中时, 当前关键点的高度
 h1 = 0, h2 = 0
 i = 0, j = 0
 (1, 11),  (3, 13),  (9, 0),  (12, 7),  (16, 0)
    ^
    i
 (14, 3),  (19, 18), (22, 3), (23, 13),  (29, 0)
    ^
    j
 比较 (1, 11) 和 (14, 3)
 比较 x 坐标, 1 < 14, 所以考虑 (1, 11)
 x 取 1, 接下来更新 height
 h1 = 11, height = max(h1, h2) = max(11, 0) = 11
 将 (1, 11) 加入到 Result 中
 Result = {(1, 11)}
 i 后移, i = i + 1 = 2
 (1, 11),  (3, 13),  (9, 0),  (12, 7),  (16, 0)
              ^
              i
 (14, 3),  (19, 18), (22, 3), (23, 13),  (29, 0)
    ^
    j
 比较 (3, 13) 和 (14, 3)
 比较 x 坐标, 3 < 14, 所以考虑 (3, 13)
 x 取 3, 接下来更新 height
 h1 = 13, height = max(h1, h2) = max(13, 0) = 13
 将 (3, 13) 加入到 Result 中
 Result = {(1, 11), (3, 13)}
 i 后移, i = i + 1 = 3
 (9, 0) 和 (12, 7) 同理
 此时 h1 = 7
 Result 为 {(1, 11), (3, 13), (9, 0), (12, 7)}
 i = 4
 (1, 11),  (3, 13),  (9, 0),  (12, 7),  (16, 0)
                           ^
                           i
 (14, 3),  (19, 18), (22, 3), (23, 13),  (29, 0)
    ^
    j
 比较 (16, 0) 和 (14, 3)
 比较 x 坐标, 14 < 16, 所以考虑 (14, 3)
 x 取 14, 接下来更新 height
 h2 = 3, height = max(h1, h2) = max(7, 3) = 7
 将 (14, 7) 加入到 Result 中
 Result = {(1, 11), (3, 13), (9, 0), (12, 7), (14, 7)}
 j 后移, j = j + 1 = 2
      
 (1, 11),  (3, 13),  (9, 0),  (12, 7),  (16, 0)
                          ^
                          i
 (14, 3),  (19, 18), (22, 3), (23, 13),  (29, 0)
         ^
         j
 比较 (16, 0) 和 (19, 18)
 比较 x 坐标, 16 < 19, 所以考虑 (16, 0)
 x 取 16, 接下来更新 height
 h1 = 0, height = max(h1, h2) = max(0, 3) = 3
 将 (16, 3) 加入到 Result 中
 Result = {(1, 11), (3, 13), (9, 0), (12, 7), (14, 7), (16, 3)}
 i 后移, i = i + 1 = 5
     
 因为 Skyline1 没有更多的解了，所以只需要将 Skyline2 剩下的解按照上边 height 的更新方式继续加入到 Result 中即可
 Result = {(1, 11), (3, 13), (9, 0), (12, 7), (14, 7), (16, 3),
               (19, 18), (22, 3), (23, 13), (29, 0)}

 我们会发现上边多了一些解, (14, 7) 并不是我们需要的, 因为之前已经有了 (12, 7), 所以我们需要将其去掉。
 Result = {(1, 11), (3, 13), (9, 0), (12, 7), (16, 3), (19, 18),
               (22, 3), (23, 13), (29, 0)}
 
 
 需要注意地方1：
 long x1 = i < Skyline1 .size() ? Skyline1 .get(i).get(0) : Long.MAX_VALUE;
 long x2 = j < Skyline2 .size() ? Skyline2 .get(j).get(0) : Long.MAX_VALUE;
 当 Skyline1 或者 Skyline2 遍历完的时候，我们给他赋值为一个很大的数，这样的话我们可以在一个 while 循环中完成我们的算法，不用再单独考虑当一个遍历完的处理。
 这里需要注意的是，我们将 x1 和 x2 定义为 long，算是一个 trick，可以保证我们给 x1 或者 x2 赋的 Long.MAX_VALUE 这个值，后续不会出现 x1 == x2。因为原始数据都是 int 范围的。
 当然也可以有其他的处理方式，比如当遍历完的时候，给 x1 或者 x2 赋值成负数，不过这样的话就需要更改后续的 if 判断条件，不细说了。
 
 需要注意地方2：
 if (res.isEmpty() || height != res.get(res.size() - 1).get(1))
 我们在将当前结果加入的 res 中时，判断一下当前的高度是不是 res 中最后一个的高度，可以提前防止加入重复的点。
 */
-(NSMutableArray<NSMutableArray<NSNumber *>*> *)merge:(NSMutableArray*)buildings
                                                start:(int)start
                                                  end:(int)end{

    NSMutableArray<NSMutableArray<NSNumber *>*> *res=[NSMutableArray array];
    //只有一个建筑[x,y,h], 将 [x, h], [y, 0] 加入结果
    if (start == end) {
        NSMutableArray *temp=[NSMutableArray array];
        [temp addObject:buildings[start][0]];
        [temp addObject:buildings[start][2]];
        [res addObject:temp];
        
        temp = [NSMutableArray array];
        [temp addObject:buildings[start][1]];
        [temp addObject:@0];
        [res addObject:temp];
        return res;
    }
    int mid = (start + end) >> 1;
    //第一组解
    NSMutableArray<NSMutableArray<NSNumber *>*> *Skyline1  = [self merge:buildings start:start end:mid];
    //第二组解
    NSMutableArray<NSMutableArray<NSNumber *>*> *Skyline2  = [self merge:buildings start:mid+1 end:end];
    //下边将两组解合并
    int h1 = 0;
    int h2 = 0;
    int i = 0;
    int j = 0;
    while (i < Skyline1.count || j < Skyline2.count) {
        
        long x1 = i < Skyline1.count? Skyline1[i][0].longValue : LONG_MAX;
        long x2 = j < Skyline2.count? Skyline2[j][0].longValue : LONG_MAX;
        long x = 0;
        //比较两个坐标
        if (x1 < x2) {
            h1 = Skyline1[i][1].intValue;
            x = x1;
            i++;
        } else if (x1 > x2) {
            h2 = Skyline2[j][1].intValue;
            x = x2;
            j++;
        } else {
            h1 = Skyline1[i][1].intValue;
            h2 = Skyline2[j][1].intValue;
            x = x1;
            i++;
            j++;
        }
        //更新 height
        int height = max(h1, h2);
        //重复的解不要加入
        if (res.count == 0 || height != res[res.count - 1][1].intValue) {
            NSMutableArray<NSNumber *>*temp=[NSMutableArray array];
            [temp addObject:@((int)x)];
            [temp addObject:@(height)];
            [res addObject:temp];
        }
    }
    return res;
}

@end
