//
//  BinaryHeap.m
//  二叉堆
//
//  Created by 58 on 2020/10/27.
//

#import "BinaryHeap.h"
#import "MJBinaryTrees.h"


@interface BinaryHeap ()

@property(nonatomic,assign)NSUInteger size;
@property(nonatomic,assign)NSUInteger capacity;
@property(nonatomic,strong)NSMutableArray *array;

@end

@implementation BinaryHeap

-(instancetype)init{
    if (self=[super init]) {
        self.capacity=10;
        self.size=0;
        self.array=[NSMutableArray array];
        self.bigHeap=YES;
    }
    return self;
}


-(NSUInteger)size{
    return _size;
}
-(BOOL)isEmpty{
    return self.size == 0;
}
-(void)clear{
//    for (NSObject *obj in self.array) {
//        obj=nil; //Fast enumeration variables cannot be modified in ARC by default
//    }
    for (int i=0;i<self.array.count; i++) {
        NSObject *obj=self.array[i];
        obj=nil;
    }
    self.size=0;
}
-(void)add:(int)ele{
    [self ensureCapacity:(int)self.size+1];
    self.array[self.size++]=@(ele);
    [self shiftUp:self.size-1];
}
-(int)getElement{
    if ([self isEmpty]){
        NSLog(@"Binary heap is empty");
        return -1;
    }
    return [self.array[0] intValue];
}
-(int)removeEle{
    if ([self isEmpty]){
        NSLog(@"Binary heap is empty");
        return -1;
    }
    int ele =[self.array[0] intValue];
    //拿最后一个元素直接覆盖根节点元素
    self.array[0]=self.array[self.size-1];
    //去除最后一个元素，释放
    NSNumber *num=self.array[self.size-1];
    num=nil;
    self.size--;
    //此时根节点已经是最后一个元素了，再重新排序成大堆
    [self shiftdown:0];
    return ele;
}
-(int)replace:(int)ele{
    int root_ele=-1;
    if (self.size==0) {
        self.array[0]=@(ele);
        self.size++;
    }else{
        root_ele=[self getElement];
        self.array[0]=@(ele);
        [self shiftdown:0];
    }
    return root_ele;
}
//上虑
//index 下标下的元素上虑
-(void)shiftUp:(NSUInteger)index{
    // 方式一
//    int ele=[self.array[index] intValue];
//    while (index>0) {
//        NSUInteger p_index=(index-1) >> 1;
//        int p_ele=[self.array[p_index] intValue];
//        if ([self cmp:ele to:p_ele] < 0) return; //加入的值比父节点小，不需要上虑
//
//        //交换index 和 p_index的内容
//        NSNumber *temp=self.array[index];
//        self.array[index]=self.array[p_index];
//        self.array[p_index]=temp;
//        //index 重新复制，变成了刚才获取到的父节点的索引
//        index=p_index;
//    }
    
    // 方式二
    int ele=[self.array[index] intValue]; // 备份这个值
    while (index>0) {
        NSUInteger p_index=(index-1) >> 1; // 父节点index
        int p_ele=[self.array[p_index] intValue]; // 父节点的值
        if ([self cmp:ele to:p_ele] < 0) break; //加入的值比父节点小，不需要上虑
        //将父节点的内容存储在index中
        //index一直往上找，最终这个最大的值一直找到根节点，直接替换根节点的值
        self.array[index]=@(p_ele);
        //index 重新复制，变成了刚才获取到的父节点的索引
        index=p_index;
    }
    //最终这个最大的值一直找到根节点，直接替换根节点的值
    self.array[index]=@(ele);
}
//下虑
//index下标下的元素下虑
-(void)shiftdown:(NSUInteger)index{
    int element = [self.array[index] intValue];
    int half = (int)self.size >> 1;//除2
    // 第一个叶子节点的索引 == 非叶子节点的数量
    // index < 第一个叶子节点的索引
    // 必须保证index位置是非叶子节点
    while (index < half) {
        // index的节点有2种情况
        // 1.只有左子节点
        // 2.同时有左右子节点
        // 默认为左子节点跟它进行比较
        //左子节点下标
        int leftChildIndex = (int)(index << 1) + 1;
        //左子节点值
        int leftChild = [self.array[leftChildIndex] intValue];
        // 右子节点下标
        int rightIndex = leftChildIndex + 1;
        
        // 选出左右子节点最大的那个
        if (rightIndex < self.size && [self cmp:[self.array[rightIndex]intValue] to:leftChild] > 0) {
            //如果右节点值大于左节点值，就把右节点值取出来
            leftChild = [self.array[leftChildIndex = rightIndex] intValue];
        }
        //element和leftChild比较大小，此处的leftChild其实已经挑出了左右节点最大的值
        if ([self cmp:element to:leftChild] >= 0) break;
        
        // 将子节点较大的值存放到index位置
        self.array[index] = @(leftChild);
        // 重新设置index，此处的leftChildIndex其实已经确定了了左右节点最大的值的index
        index = leftChildIndex;
    }
    //最终这个element呗放到了合适的index下
    self.array[index] = @(element);
}
-(void)ensureCapacity:(int)cur_size {
    int oldCapacity = (int)self.capacity;
    if (oldCapacity >= cur_size) return;
    // 新容量为旧容量的1.5倍
    int newCapacity = oldCapacity + (oldCapacity >> 1);
    NSMutableArray *new=[NSMutableArray arrayWithCapacity:newCapacity];
    for (int i=0; i<self.array.count; i++) {
        new[i] = self.array[i]; //把旧数组中的元素全部拷贝到新
    }
    self.array=nil; //释放旧数组
    self.array = new;
    self.capacity=newCapacity;
    printf("数组已扩容：oldSize: %lu, newSize: %d\n",(unsigned long)self.capacity,newCapacity);
}

-(int)cmp:(int)v1 to:(int)v2{
    if (self.bigHeap) {
        return v1-v2;
    }else{
        return v2-v1;
    }
}

-(void)printHeap{
//    NSLog(@"Binary heap: %@",self.array);
    [MJBinaryTrees print:self];
}

-(void)heapifyWith:(NSArray *)array{
    [self.array addObjectsFromArray:array];
    self.size=array.count;
    self.capacity=array.count;
    //from top to bottom, shift up
    //time complexity: O(nlogn)
//    for (int i=1; i<self.size; i++) { //不从根节点开始，从第二个节点开始上虑
//        [self shiftUp:i];
//    }
    
    //from bottom to top, shift down
    //time complexity: O(n)
    int start = (int)(self.size >>1 )-1;//从最后一个非叶子节点开始下虑
    for (int i=start; i>=0; i--) {
        [self shiftdown:i];
    }
}







/**
 * who is the root node
 */
- (id)root{
    return @(0);
}
/**
 * how to get the left child of the node
 */
- (id)left:(id)node{
    NSNumber *n=(NSNumber *)node;
    int index=n.intValue;
    index=(index<<1)+1;
    if (index>=self.size) {
        return NULL;
    }else{
        return @(index);
    }
}
/**
 * how to get the right child of the node
 */
- (id)right:(id)node{
    NSNumber *n=(NSNumber *)node;
    int index=n.intValue;
    index=(index<<1)+2;
    if (index>=self.size) {
        return NULL;
    }else{
        return @(index);
    }
}
/**
 * how to print the node
 */
- (id)string:(id)node{
    NSNumber *index=(NSNumber *)node;
    NSNumber *num=self.array[index.intValue];
    return num;
}


@end
