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
        self.size--;
    }else{
        LFU_Node *prev_node=node.prev;
        LFU_Node *next_node=node.next;
        
        prev_node.next=next_node;
        next_node.prev=prev_node;
        
        self.size--;
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
-(instancetype)initWithCapacity:(NSUInteger)capacity{
    if (self=[super init]) {
        self.key_value_map=[NSMutableDictionary dictionary];
        self.freq_keys_map=[NSMutableDictionary dictionary];
        self.capacity=capacity;
        self.minFreq=0;
    }
    return self;
}

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
    // 获取当前K
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
    new.key=key_s;
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
// O（1）的时间复杂度
-(void)increaseFreq:(int)key{
    NSString *key_s=@(key).stringValue;
    LFU_Node *cur_node=self.key_value_map[key_s]; // 当前key对应的value：node
    NSNumber *freq=@(cur_node.freq); // 当前key的频率: node.freq
    NSString *old_freq_key=freq.stringValue;
    NSString *new_freq_key=@(freq.intValue+1).stringValue; // 这个key的频率要加一了
    cur_node.freq+=1; // 加一
    
    // 获取原频率对应的双向链表，要把这个node提出来，放到新频率对应的双向链表中
    DLink *dl_old=self.freq_keys_map[old_freq_key];
    // 新频率对应的链表
    DLink *dl_new=self.freq_keys_map[new_freq_key];
    // 在原先链表中删除那个node
    [dl_old removeNode:cur_node];
    // 如果删除这个node之后，这个链表就空了，则代表旧频率old_freq_key下没有其他的node了
    if (dl_old.size == 0) {
        // 也就是说整个数据结构中没有old_freq这个频率了。
        // freq_keys_map也要删除这个old_freq对应得空链表
        [self.freq_keys_map removeObjectForKey:old_freq_key];
        // 如果此时old_freq正好是minFreq，也意味着最低频率也要更新了。
        if (self.minFreq == freq.intValue) {
            // 因为前面cur_node.freq+=1;加一了，所以这李也是加一
            self.minFreq++;
        }
    }
    
    // 被删除的这个节点前后置空
    cur_node.prev=nil;
    cur_node.next=nil;
    
    if (!dl_new) {
        // 如果加一后的新频率对应的链表为空，则新建
        dl_new=[[DLink alloc] init];
        [self.freq_keys_map setObject:dl_new forKey:new_freq_key];
    }
    // 并把这个频率加了1的节点放最前面。
    [dl_new addFront:cur_node];
}
-(void)removeMinFreqKey{
    
    NSString *freq_key=@(self.minFreq).stringValue;
    DLink *dl=self.freq_keys_map[freq_key]; // 获取最小频率对应的链表
    
    // 删除链表最后一个节点，因为同频率下可能对应多个key，则要删除对旧的那个。
    LFU_Node *delete_node = [dl removeLast];
    // 节点里面存储着key，拿到key
    NSString *key=delete_node.key;
    // 才能在key_value_map里面同步删除。
    [self.key_value_map removeObjectForKey:key];
    
    if (dl.size == 0) {
        // 同样这个链表空了，也得删除
        [self.freq_keys_map removeObjectForKey:freq_key];
    }
}

+(void)LFU_Cache_Test{
    
    /**
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
     */
    
    _460_LFU_Cache *cache=[[_460_LFU_Cache alloc] initWithCapacity:2];
    [cache put:1 value:1];
    [cache put:2 value:2];
    int num = [cache get:1];
    NSLog(@"%d",num);
    [cache put:3 value:3];
    num = [cache get:2];
    NSLog(@"%d",num);
    num = [cache get:3];
    NSLog(@"%d",num);
    
    [cache put:4 value:4];
//
    num = [cache get:1];
    NSLog(@"%d",num);

    num = [cache get:3];
    NSLog(@"%d",num);

    num = [cache get:4];
    NSLog(@"%d",num);
    
//    [cache printCache];
}

@end
