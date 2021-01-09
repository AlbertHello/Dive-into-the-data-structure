//
//  _460_LFU_Cache.m
//  LeetCode
//
//  Created by 58 on 2021/1/7.
//

#import "_460_LFU_Cache.h"




@interface LFU_Node : NSObject
@property(nonatomic,copy  )NSString *key;
@property(nonatomic,assign)int val;
@property(nonatomic,assign)int freq;
@property(nonatomic,strong)LFU_Node *prev;
@property(nonatomic,strong)LFU_Node *next;
@end

@implementation LFU_Node
-(instancetype)init{
    if (self=[super init]) {
        self.key=@"";
        self.val=0;
        self.freq=1;
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
-(LFU_Node *)removeNode:(LFU_Node *)node;

@end

@implementation DLink
-(void)addFront:(LFU_Node *)node{
    if (self.size == 0) { //链表为空时
        self.first=node;
        self.last=node;
        self.size++;
    }else{ // 不空
        if (self.first != node) { // 如果查询的是头节点，不需要任何操作，因为头节点本来就是第一个。
            // 获取该节点的前后节点
            LFU_Node *prev_node=node.prev;
            LFU_Node *next_node=node.next;
            // 新节点：
            if (prev_node == nil && prev_node == nil) {
                self.size++; // 只有是新节点时size才加一
            }else{ // 原有节点
                if (self.last == node) {// 判断该node是不是最后一个节点
                    // 是最后一个节点
                    // 那么修改self.last，让其指向原本倒数第二的节点，它也就成了最后一个节点
                    self.last=self.last.prev;
                    // 本来倒数第二的节点成了最后一个节点，它的next是指向null的
                    self.last.next=nil;
                }else{
                    //不是最后一个节点
                    // 这就好办了
                    prev_node.next=next_node;
                    next_node.prev=prev_node;
                }
            }
            // 最终该节点node成为了头节点，所以它的next要指向当前第一个节点，那么当前第一个节点就变成了第二个节点
            node.next=self.first;
            // 该node成了第一个节点，那么它的pre就是null
            node.prev=nil;
            // 原先的头节点self.first不是头节点了，那么它的pre就要指向新头节点node了。
            self.first.prev=node;
            // 最后让self.first再指向第一个节点node
            self.first=node;
        }
    }
}
-(LFU_Node *)removeNode:(LFU_Node *)node{
    if (node == self.last) {
        return [self removeLast];
    }else if(node == self.first){
        self.first=self.first.next;
        self.first.prev=nil;
    }else{
        LFU_Node *prev_node=node.prev;
        LFU_Node *next_node=node.next;
        
        prev_node.next=next_node;
        next_node.prev=prev_node;
    }
    return node;
}
-(LFU_Node *)removeLast{
    if (self.last) {
        LFU_Node *node=self.last;
        if (self.size == 1) {
            self.first=nil;
            self.last=nil;
        }else{
            //为什么要双向链表？因为要拿到前驱节点，单链表还的遍历才能拿到前驱节点
            self.last=node.prev;
            self.last.next=nil;
        }
        self.size--;
        return node;
    }
    return nil;
}



@end


@interface _460_LFU_Cache ()

@property(nonatomic,strong)NSMutableDictionary<NSString *, LFU_Node*> *key_value_map;
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
    LFU_Node *node=self.key_value_map[key_s];
    return node.val;
}
-(void)put:(int)key value:(int)val{
    if (self.capacity <= 0) return;
    /* 若 key 已存在，修改对应的 val 即可 */
    NSString *key_s=@(key).stringValue;
    if (self.key_value_map[key_s]) {
        LFU_Node *node=self.key_value_map[key_s];
        node.val=val;
        // key 对应的 freq 加一
        [self increaseFreq:key];
        return;
    }
    
    /* key 不存在，需要插入 */
    /* 容量已满的话需要淘汰一个 freq 最小的 key */
    if (self.capacity == self.key_value_map.count) {
        [self removeMinFreqKey];
    }

    // 新建node
    LFU_Node *new=[[LFU_Node alloc]init];
    new.val=val;
    /* 插入 key 和 val，对应的 freq 为 1 */
    // 插入 KV 表
    [self.key_value_map setObject:new forKey:key_s];
    
    // 插入 FK 表
    NSString *freq_key=@(1).stringValue;
    DLink *dl=self.freq_keys_map[freq_key];
    if (!dl) {
        dl=[[DLink alloc]init];
        [self.freq_keys_map setObject:dl forKey:freq_key];
    }
    [dl addFront:new];
    // 插入新 key 后最小的 freq 肯定是 1
    self.minFreq = 1;
}
-(void)increaseFreq:(int)key{
    NSString *key_s=@(key).stringValue;
    LFU_Node *cur_node=self.key_value_map[key_s];
    NSNumber *freq=@(cur_node.freq);
    NSString *old_freq_key=freq.stringValue;
    NSString *new_freq_key=@(freq.intValue+1).stringValue;
    cur_node.freq+=1;
    
    DLink *dl_old=self.freq_keys_map[old_freq_key];
    DLink *dl_new=self.freq_keys_map[new_freq_key];
    
    [dl_old removeNode:cur_node];
    
    if (!dl_new) {
        dl_new=[[DLink alloc] init];
        [self.freq_keys_map setObject:dl_new forKey:new_freq_key];
    }
    [dl_new addFront:cur_node];
}
-(void)removeMinFreqKey{
    NSString *freq_key=@(self.minFreq).stringValue;
    DLink *dl=self.freq_keys_map[freq_key];
    
    LFU_Node *delete_node = [dl removeLast];
    NSString *key=delete_node.key;
    
    [self.key_value_map removeObjectForKey:key];
}

@end
