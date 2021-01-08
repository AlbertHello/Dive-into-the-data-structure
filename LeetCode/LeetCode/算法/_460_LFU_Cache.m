//
//  _460_LFU_Cache.m
//  LeetCode
//
//  Created by 58 on 2021/1/7.
//

#import "_460_LFU_Cache.h"




@interface LFU_Node : NSObject
@property(nonatomic,copy  )NSString *key;
@property(nonatomic,strong)LFU_Node *prev;
@property(nonatomic,strong)LFU_Node *next;
@end

@implementation LFU_Node
-(instancetype)init{
    if (self=[super init]) {
        self.key=@"";
        self.prev=nil;
        self.next=nil;
    }
    return self;
}
@end



@interface DLink : NSObject
@property(nonatomic,strong)LFU_Node *first;
@property(nonatomic,strong)LFU_Node *last;
@property(nonatomic,assign)NSUInteger size;
// 在链表头部添加节点 x，时间 O(1)，头节点代表最新的节点
-(void)addFront:(LFU_Node *)node;
// 删除链表中最后一个节点，最后一个节点代表最旧的节点
// 删除链表中最后一个节点，并返回该节点，时间 O(1)
-(LFU_Node *)removeLast;

@end

@implementation DLink
-(void)addFront:(LFU_Node *)node{
    
}
-(LFU_Node *)removeLast{
    return nil;
}



@end


@interface _460_LFU_Cache ()

@property(nonatomic,strong)NSMutableDictionary<NSString *, NSObject*> *key_value_map;
@property(nonatomic,strong)NSMutableDictionary<NSString *, NSObject*>*key_freq_map;
@property(nonatomic,strong)NSMutableDictionary<NSString *, DLink*> *freq_keys_map;
@property(nonatomic,assign)NSUInteger capacity;
@property(nonatomic,assign)NSUInteger minFreq;

@end

@implementation _460_LFU_Cache


/**
 460. LFU 缓存 $
 难度 困难
 https://leetcode-cn.com/problems/lfu-cache/
 请你为 最不经常使用（LFU）缓存算法设计并实现数据结构。
 实现 LFUCache 类：
 LFUCache(int capacity) - 用数据结构的容量 capacity 初始化对象
 int get(int key) - 如果键存在于缓存中，则获取键的值，否则返回 -1。
 void put(int key, int value) - 如果键已存在，则变更其值；如果键不存在，请插入键值对。当缓存达到其容量时，则应该在插入新项之前，使最不经常使用的项无效。在此问题中，当存在平局（即两个或更多个键具有相同使用频率）时，应该去除 最久未使用 的键。
 注意「项的使用次数」就是自插入该项以来对其调用 get 和 put 函数的次数之和。使用次数会在对应项被移除后置为 0 。
 
 进阶：
 你是否可以在 O(1) 时间复杂度内执行两项操作？
 示例：

 输入：
 ["LFUCache", "put", "put", "get", "put", "get", "get", "put", "get", "get", "get"]
 [[2], [1, 1], [2, 2], [1], [3, 3], [2], [3], [4, 4], [1], [3], [4]]
 输出：
 [null, null, null, 1, null, -1, 3, null, -1, 3, 4]

 解释：
 LFUCache lFUCache = new LFUCache(2);
 lFUCache.put(1, 1);
 lFUCache.put(2, 2);
 lFUCache.get(1);      // 返回 1
 lFUCache.put(3, 3);   // 去除键 2
 lFUCache.get(2);      // 返回 -1（未找到）
 lFUCache.get(3);      // 返回 3
 lFUCache.put(4, 4);   // 去除键 1
 lFUCache.get(1);      // 返回 -1（未找到）
 lFUCache.get(3);      // 返回 3
 lFUCache.get(4);      // 返回 4
  

 提示：

 0 <= capacity, key, value <= 10^4
 最多调用 10^5 次 get 和 put 方法
 */

-(int)get:(int)key{
    NSString *key_s=@(key).stringValue;
    if (!self.key_value_map[key_s]) {
        return -1;
    }
    // 增加 key 对应的 freq
    [self increaseFreq:key];
    NSNumber *value=(NSNumber *)self.key_value_map[key_s];
    return value.intValue;
}
-(void)put:(int)key value:(int)val{
    if (self.capacity <= 0) return;
    /* 若 key 已存在，修改对应的 val 即可 */
    NSString *key_s=@(key).stringValue;
    if (self.key_value_map[key_s]) {
        self.key_value_map[key_s]=@(val);
        // key 对应的 freq 加一
        [self increaseFreq:key];
        return;
    }

    /* key 不存在，需要插入 */
    /* 容量已满的话需要淘汰一个 freq 最小的 key */
    if (self.capacity == self.key_value_map.count) {
        [self removeMinFreqKey:key];
    }

    /* 插入 key 和 val，对应的 freq 为 1 */
    // 插入 KV 表
    [self.key_value_map setObject:@(val) forKey:key_s];
    
    // 插入 KF 表
    [self.key_freq_map setObject:@(1) forKey:key_s];
    
    // 插入 FK 表
//    freqToKeys.putIfAbsent(1, new LinkedHashSet<>());
//
//    freqToKeys.get(1).add(key);
    // 插入新 key 后最小的 freq 肯定是 1
    self.minFreq = 1;
}
-(void)increaseFreq:(int)key{
    
}
-(void)removeMinFreqKey:(int)key{
    
}

@end
