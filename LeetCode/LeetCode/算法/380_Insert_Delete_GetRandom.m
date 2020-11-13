//
//  380_Insert_Delete_GetRandom.m
//  LeetCode
//
//  Created by 58 on 2020/10/29.
//

#import "380_Insert_Delete_GetRandom.h"


@interface _80_Insert_Delete_GetRandom ()

@property(nonatomic,strong)NSMutableDictionary *map;
@property(nonatomic,strong)NSMutableArray *array;
@end


@implementation _80_Insert_Delete_GetRandom

-(instancetype)init{
    if (self=[super init]) {
        self.map=[NSMutableDictionary dictionary];
        self.array=[NSMutableArray array];
    }
    return self;
}

/**
 380. 常数时间插入、删除和获取随机元素

 设计一个支持在平均 时间复杂度 O(1) 下，执行以下操作的数据结构。

 insert(val)：当元素 val 不存在时，向集合中插入该项。
 remove(val)：元素 val 存在时，从集合中移除该项。
 getRandom：随机返回现有集合中的一项。每个元素应该有相同的概率被返回。
 示例 :

 // 初始化一个空的集合。
 RandomizedSet randomSet = new RandomizedSet();

 // 向集合中插入 1 。返回 true 表示 1 被成功地插入。
 randomSet.insert(1);

 // 返回 false ，表示集合中不存在 2 。
 randomSet.remove(2);

 // 向集合中插入 2 。返回 true 。集合现在包含 [1,2] 。
 randomSet.insert(2);

 // getRandom 应随机返回 1 或 2 。
 randomSet.getRandom();

 // 从集合中移除 1 ，返回 true 。集合现在包含 [2] 。
 randomSet.remove(1);

 // 2 已在集合中，所以返回 false 。
 randomSet.insert(2);

 // 由于 2 是集合中唯一的数字，getRandom 总是返回 2 。
 randomSet.getRandom();
 
 
 作者：LeetCode
 链接：https://leetcode-cn.com/problems/insert-delete-getrandom-o1/solution/chang-shu-shi-jian-cha-ru-shan-chu-he-huo-qu-sui-j/
 来源：力扣（LeetCode）
 */


/**
 我们需要在平均复杂度为O(1) 实现以下操作：
 insert
 remove
 getRadom
 
 从 insert 开始，我们具有两个平均插入时间为O(1) 的选择：
 哈希表：Java 中为 HashMap，Python 中为 dictionary。
 动态数组：Java 中为 ArrayList，Python 中为 list。

 让我们一个个进行思考，虽然哈希表提供常数时间的插入和删除，但是实现 getRandom 时会出现问题。

 getRandom 的思想是选择一个随机索引，然后使用该索引返回一个元素。而哈希表中没有索引，因此要获得真正的随机值，则要将哈希表中的键转换为列表，这需要线性时间。解决的方法是用一个列表存储值，并在该列表中实现常数时间的 getRandom。

 列表有索引可以实现常数时间的 insert 和 getRandom，则接下来的问题是如何实现常数时间的 remove。

 删除任意索引元素需要线性时间，这里的解决方案是总是删除最后一个元素。

 将要删除元素和最后一个元素交换。
 将最后一个元素删除。
 为此，必须在常数时间获取到要删除元素的索引，因此需要一个哈希表来存储值到索引的映射。

 综上所述，我们使用以下数据结构：

 动态数组存储元素值
 哈希表存储存储值到索引的映射。
 方法：哈希表 + 动态数组
 
 */

/**
 Insert:

 添加元素到动态数组。
 在哈希表中添加值到索引的映射
 */
-(BOOL)insert:(int)val {
    NSString *key=[NSString stringWithFormat:@"%d",val];
    if ([self.map.allKeys containsObject:key]) return false;
    self.map[key]=@(self.array.count);
    [self.array addObject:@(val)];
    return true;
}

/**
 remove:

 在哈希表中查找要删除元素的索引。
 将要删除元素与最后一个元素交换。
 删除最后一个元素。
 更新哈希表中的对应关系。
 */
-(BOOL)remove:(int)val {
    NSString *key=[NSString stringWithFormat:@"%d",val];
    if (![self.map.allKeys containsObject:key]) return false;
    
    int lastElement=[self.array[self.array.count-1] intValue];
    int delete_ele_index=[self.map[key] intValue];
    
    [self.array replaceObjectAtIndex:delete_ele_index withObject:@(lastElement)];
    
    NSString *new_key=[NSString stringWithFormat:@"%d",lastElement];
    self.map[new_key]=@(delete_ele_index);
    
    [self.array removeLastObject];
    [self.map removeObjectForKey:key];
    
    return true;
}

/**
 getRandom
 借助arc
 */
-(int)getRandom{
    if (self.array.count==0) return -1;
    int random_index=arc4random()%self.array.count;
    return [self.array[random_index] intValue];
}

/**
 复杂度分析
 时间复杂度：getRandom 时间复杂度为O(1)，insert 和 remove 平均时间复杂度为O(1)，
 在最坏情况下为O(N): 当元素数量超过当前分配的动态数组和哈希表的容量导致空间重新分配时。
 空间复杂度：O(N): 在动态数组和哈希表分别存储了N 个元素的信息。
 
 */
@end
