//
//  _347_TopKFrequentElements.m
//  LeetCode
//
//  Created by 58 on 2020/12/22.
//

#import "_347_TopKFrequentElements.h"
#import "BinaryHeap.h"


@implementation _347_TopKFrequentElements
/**
 347. 前 K 个高频元素
 难度 中等
 https://leetcode-cn.com/problems/top-k-frequent-elements/
 给定一个非空的整数数组，返回其中出现频率前 k 高的元素。

 示例 1:

 输入: nums = [1,1,1,2,2,3], k = 2
 输出: [1,2]
 示例 2:

 输入: nums = [1], k = 1
 输出: [1]
  

 提示：

 你可以假设给定的 k 总是合理的，且 1 ≤ k ≤ 数组中不相同的元素的个数。
 你的算法的时间复杂度必须优于 O(n log n) , n 是数组的大小。
 题目数据保证答案唯一，换句话说，数组中前 k 个高频元素的集合是唯一的。
 你可以按任意顺序返回答案。
 */
int min_heap_comparator(int first,int second){
    return second - first;
}

/**
 具体操作为：
 1 借助 哈希表 来建立数字和其出现次数的映射，遍历一遍数组统计元素的频率
 2 维护一个元素数目为k 的最小堆
 3 每次都将新的元素与堆顶元素（堆中频率最小的元素）进行比较
 4 如果新的元素的频率比堆顶端的元素大，则弹出堆顶端的元素，将新的元素添加进堆中
 5 最终，堆中的 k 个元素即为前 k 个高频元素
 
 时间复杂度：O(nlogk)，n 表示数组的长度。首先，遍历一遍数组统计元素的频率，这一系列操作的时间复杂度是
 O(n)；接着，遍历用于存储元素频率的 map，如果元素的频率大于最小堆中顶部的元素，
 则将顶部的元素删除并将该元素加入堆中，这里维护堆的数目是k，所以这一系列操作的时间复杂度是
 O(nlogk) 的；因此，总的时间复杂度是O(nlog⁡k)。
 空间复杂度：O(n)，最坏情况下（每个元素都不同），map 需要存储n 个键值对，优先队列需要存储
 k 个元素，因此，空间复杂度是O(n)。
 */
-(NSMutableArray *)topKFrequent:(NSArray *)nums k:(int) k {
    
    // 使用字典，统计每个元素出现的次数，元素为键，元素出现的次数为值
    NSMutableDictionary *map=[NSMutableDictionary dictionary];
    for(NSNumber *num in nums){
        if (map[num.stringValue]) {
            NSNumber *count=map[num.stringValue];
            [map setObject:@(count.intValue+1) forKey:num.stringValue];
         } else {
             [map setObject:@(1) forKey:num.stringValue];
         }
    }
    // 遍历map，用最小堆保存频率最大的k个元素
    BinaryHeap *minHeap=[[BinaryHeap alloc]init];
    minHeap.comparator=min_heap_comparator;
    for (NSString *key in map.allKeys) {
        if ([minHeap size] < k) { // 不足k个时，直接添加
            [minHeap add:key.intValue];
        } else if (((NSNumber *)map[key]).intValue > ((NSNumber *)map[@([minHeap getElement]).stringValue]).intValue) {
            // 当第k+1个过来时先判断将要进的这个值对应的频率是否大于堆顶元素对应的频率
            // 如果大于，则删掉堆顶元素元素
            [minHeap removeEle];
            // 再加入这个新的元素
            [minHeap add:key.intValue];
        }
    }
    [minHeap printHeap];
    // 取出最小堆中的元素
    NSMutableArray *res=[NSMutableArray array];
    while (![minHeap isEmpty]) {
        int num = [minHeap removeEle];
        [res addObject:@(num)];
    }
    return res;
}

+(void)topKFrequentTest{
    _347_TopKFrequentElements *top=[[_347_TopKFrequentElements alloc]init];
    NSLog(@"%@",[top topKFrequent:@[@4,@4,@4,@10,@10,@3] k:2]);
}

@end
