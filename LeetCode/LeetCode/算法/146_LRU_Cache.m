//
//  146_LRU_Cache.m
//  LeetCode
//
//  Created by 58 on 2020/10/27.
//

#import "146_LRU_Cache.h"

@interface Node : NSObject
@property(nonatomic,copy)NSString *key;
@property(nonatomic,assign)NSInteger value;
@property(nonatomic,strong)Node *prev;
@property(nonatomic,strong)Node *next;
-(instancetype)initWithKey:(NSString *)key walue:(NSInteger)value;
@end

@implementation Node
-(instancetype)initWithKey:(NSString *)key walue:(NSInteger)value{
    if (self=[super init]) {
        self.key=key;
        self.value=value;
        self.prev=nil;
        self.next=nil;
    }
    return self;
}
@end

@interface DoubleLink : NSObject
@property(nonatomic,strong)Node *first;
@property(nonatomic,strong)Node *last;
@property(nonatomic,assign)NSUInteger size;

// 在链表头部添加节点 x，时间 O(1)
-(void)addFront:(Node *)node;
// 删除链表中的 x 节点（x 一定存在）
// 删除链表中最后一个节点，并返回该节点，时间 O(1)
-(Node *)removeLast;
// 返回链表长度，时间 O(1)
-(NSUInteger)size;
@end

@implementation DoubleLink

-(instancetype)init{
    if (self=[super init]) {
        self.first=nil;
        self.last=nil;
        self.size=0;
    }
    return self;
}
-(void)addFront:(Node *)node{
    if (self.size == 0) { //链表为空时
        self.first=node;
        self.last=node;
        self.size++;
    }else{ // 不空
        if (self.first != node) { // 如果查询的是头节点，不需要任何操作，因为头节点本来就是第一个。
            // 获取该节点的前后节点
            Node *prev_node=node.prev;
            Node *next_node=node.next;
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
- (Node *)removeLast{
    if (self.last) {
        Node *node=self.last;
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
-(NSUInteger)size{
    return _size;
}


@end



@interface _46_LRU_Cache ()

@property(nonatomic,strong)NSMutableDictionary *map;
@property(nonatomic,strong)DoubleLink *d_link;
@property(nonatomic,assign)NSUInteger capacity;

@end


@implementation _46_LRU_Cache


/**
 146. LRU缓存机制 $$$$$
 难度 中等
 链接：https://leetcode-cn.com/problems/lru-cache
 运用你所掌握的数据结构，设计和实现一个  LRU (最近最少使用) 缓存机制。它应该支持以下操作： 获取数据 get 和 写入数据 put 。

 获取数据 get(key) - 如果关键字 (key) 存在于缓存中，则获取关键字的值（总是正数），否则返回 -1。
 写入数据 put(key, value) - 如果关键字已经存在，则变更其数据值；如果关键字不存在，则插入该组「关键字/值」。当缓存容量达到上限时，它应该在写入新数据之前删除最久未使用的数据值，从而为新的数据值留出空间。

 进阶:

 你是否可以在 O(1) 时间复杂度内完成这两种操作？
 
 示例:

 LRUCache cache = new LRUCache( 2  缓存容量 );

 cache.put(1, 1);
 cache.put(2, 2);
 cache.get(1);       // 返回  1
 cache.put(3, 3);    // 该操作会使得关键字 2 作废
 cache.get(2);       // 返回 -1 (未找到)
 cache.put(4, 4);    // 该操作会使得关键字 1 作废
 cache.get(1);       // 返回 -1 (未找到)
 cache.get(3);       // 返回  3
 cache.get(4);       // 返回  4
 */

/**
 思路：
 LRU 缓存淘汰算法就是一种常用策略。LRU 的全称是 Least Recently Used，也就是说我们认为最近使用过的数据应该是是「有用的」，很久都没用过的数据应该是无用的，内存满了就优先删那些很久没用过的数据。当然还有其他缓存淘汰策略，比如不要按访问的时序来淘汰，而是按访问频率（LFU 策略）来淘汰等等，各有应用场景
 
 LRU 算法实际上是让你设计数据结构：首先要接收一个 capacity 参数作为缓存的最大容量，然后实现两个 API，一个是 put(key, val) 方法存入键值对，另一个是 get(key) 方法获取 key 对应的 val，如果 key 不存在则返回 -1。

 注意哦，get 和 put 方法必须都是 O(1) 的时间复杂度
 
 要让 put 和 get 方法的时间复杂度为 O(1)，我们可以总结出 cache 这个数据结构必要的条件：查找快，插入快，删除快，有顺序之分。

 因为显然 cache 必须有顺序之分，以区分最近使用的和久未使用的数据；而且我们要在 cache 中查找键是否已存在；如果容量满了要删除最后一个数据；每次访问还要把数据插入到队头。

 那么，什么数据结构同时符合上述条件呢？哈希表查找快，但是数据无固定顺序；链表有顺序之分，插入删除快，但是查找慢。所以结合一下，形成一种新的数据结构：哈希+链表。

 LRU 缓存算法的核心数据结构就是哈希+链表，双向链表和哈希表的结合体。
 
 1。 为什么要双向链表？
 因为我们需要删除操作。删除一个节点不光要得到该节点本身的指针，也需要操作其前驱节点的指针，而双向链表才能支持直接查找前驱，保证操作的时间复杂度 O(1)。
 
 2. 为什么链表要存储key？
 
 当缓存容量已满，我们不仅仅要删除最后一个 Node 节点，还要把 map 中映射到该节点的 key 同时删除，而这个 key 只能由 Node 得到。如果 Node 结构中只存储 val，那么我们就无法得知 key 是什么，就无法删除 map 中的键，造成错误。
 */

-(instancetype)initWithCapacity:(NSUInteger)capacity{
    if (self=[super init]) {
        self.map=[NSMutableDictionary dictionary];
        self.d_link=[[DoubleLink alloc]init];
        self.capacity=capacity;
    }
    return self;
}

// map查找key是O（1）
// 双向链表删除/插入都是O（1）
//所以get操作时间复杂度O（1）
-(NSInteger)get:(NSString *)key{
    Node *node=self.map[key];
    if (node) { // 如果有这个key
        [self.d_link addFront:node]; //使用了就得往前调
        return node.value;
    }
    return -1;
}
// map查找key是O（1）
// 双向链表删除/插入都是O（1）
//所以put操作时间复杂度O（1）
-(void)put:(NSString *)key value:(NSInteger)value{
    Node *node=self.map[key];
    if (node) { // 如果有这个key
        node.value=value; //把更新它的值
        [self.d_link addFront:node]; //使用了就得往前调
    }else{  // 没有这个key
        //新建node
        Node *new_node=[[Node alloc]initWithKey:key walue:value];
        self.map[key]=new_node; //map记录这个node
        if (self.d_link.size == self.capacity) { // 如果超容量，删除最后一个
            Node *delete_node=[self.d_link removeLast]; // 删除
            //为什么链表要存储key？
            //存储了key，才能拿到链表删除的最后一个节点到底是哪个，map才能同步删除记录
            [self.map removeObjectForKey:delete_node.key]; //同时也要删除map中记录的
        }
        [self.d_link addFront:new_node]; // 新node往前放
    }
}

-(void)printCache{
    if (self.d_link.size>0) {
        Node *node=self.d_link.first;
        while (node != nil) {
            NSLog(@"(%@_%ld)",node.key,(long)node.value);
            node=node.next;
        }
    }
}


+(void)LRU_Cache_Test{
    
    /**
     cache.put(1, 1);
     cache.put(2, 2);
     cache.get(1);       // 返回  1
     cache.put(3, 3);    // 该操作会使得关键字 2 作废
     cache.get(2);       // 返回 -1 (未找到)
     cache.put(4, 4);    // 该操作会使得关键字 1 作废
     cache.get(1);       // 返回 -1 (未找到)
     cache.get(3);       // 返回  3
     cache.get(4);
     */
    _46_LRU_Cache *cache=[[_46_LRU_Cache alloc] initWithCapacity:2];
    [cache put:@"1" value:1];
    
    [cache put:@"2" value:2];
    
    NSInteger num = [cache get:@"1"];
    NSLog(@"%ld",(long)num);
    
    [cache put:@"3" value:3];
    
    num = [cache get:@"2"];
    NSLog(@"%ld",(long)num);
    
    [cache put:@"4" value:4];
    
    num = [cache get:@"1"];
    NSLog(@"%ld",(long)num);
    
    num = [cache get:@"3"];
    NSLog(@"%ld",(long)num);
    
    num = [cache get:@"4"];
    NSLog(@"%ld",(long)num);
    
    [cache printCache];
}





@end
