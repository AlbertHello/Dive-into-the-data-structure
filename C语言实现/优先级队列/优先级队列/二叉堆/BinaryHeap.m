//
//  BinaryHeap.m
//  二叉堆
//
//  Created by 58 on 2020/10/27.
//

#import "BinaryHeap.h"

/**
 二叉堆的逻辑结构就是一棵完全二叉树，所以也叫完全二叉堆
 ◼ 鉴于完全二叉树的一些特性， 二叉堆的底层（物理结构）一般用数组实现即可
 索引 i 的规律（ n 是元素数量）
 如果 i = 0 ，它是根节点
 如果 i > 0 ，它的父节点的索引为 floor( (i – 1) / 2 )
 如果 2i + 1 ≤ n – 1，它的左子节点的索引为 2i + 1
 如果 2i + 1 > n – 1 ，它无左子节点
 如果 2i + 2 ≤ n – 1 ，它的右子节点的索引为 2i + 2
 如果 2i + 2 > n – 1 ，它无右子节点
 */
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
/**
 添加操作：
 循环执行以下步骤
 如果 node ＞ 父节点
 ✓ 与父节点交换位置
 如果 node ≤ 父节点，或者 node 没有父节点
 ✓ 退出循环
 ◼ 这个过程，叫做上滤（Sift Up）
 时间复杂度： O(logn)
 */
-(void)add:(int)ele{
    [self ensureCapacity:(int)self.size+1];
    self.array[self.size++]=@(ele); // 添加到数组最后
    [self shiftUp:self.size-1];// 把刚添加的这个最后一个元素上滤
}
/**
 获取堆顶值。O（1）
 */
-(int)getElement{
    if ([self isEmpty]){
        NSLog(@"Binary heap is empty");
        return -1;
    }
    return [self.array[0] intValue];
}
/**
 删除操作：
 1. 用最后一个节点覆盖根节点
 2. 删除最后一个节点
 3. 循环执行以下操作
 如果 node < 最大的子节点
 ✓ 与最大的子节点交换位置
 如果 node ≥ 最大的子节点， 或者 node 没有子节点
 ✓ 退出循环
 ◼ 这个过程，叫做下滤（Sift Down），时间复杂度： O(logn)
 */
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
    int ele=[self.array[index] intValue]; // 获取index下这个值
    while (index>0) {
        // 获取该index对应的父节点 p_index =（index-1）/ 2
        NSUInteger p_index=(index-1) >> 1;
        int p_ele=[self.array[p_index] intValue];
        
        if (self.comparator(ele,p_ele) < 0) break; //加入的值比父节点小，不需要上虑
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
    int half = (int)self.size >> 1;//除2，这是第一个叶子结点的索引。
    // 第一个叶子节点的索引 == 非叶子节点的数量
    // index < 第一个叶子节点的索引
    while (index < half) { // 必须保证index位置是非叶子节点
        // index的节点有2种情况
        // 1.只有左子节点
        // 2.同时有左右子节点
        // 默认为左子节点跟它进行比较
        //左子节点下标
        int leftChildIndex = (int)(index << 1) + 1; // 左孩子：2*i + 1
        //左子节点值
        int leftChild = [self.array[leftChildIndex] intValue];
        // 右子节点下标
        int rightIndex = leftChildIndex + 1; // // 右孩子：2*i + 2
        
        // 选出左右子节点最大的那个
        if (rightIndex < self.size && self.comparator([self.array[rightIndex]intValue],leftChild) > 0) {
            //如果右节点值大于左节点值，就把右节点值取出来
            leftChild = [self.array[leftChildIndex = rightIndex] intValue];
        }
        //element和leftChild比较大小，此处的leftChild其实已经挑出了左右节点最大的值
        if (self.comparator(element,leftChild) >= 0) break;
        
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
-(void)printHeap{
    NSLog(@"Binary heap: %@",self.array);
//    [MJBinaryTrees print:self];
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


//************************* C语言 实现二叉堆 *************************************
int nums_size=0;
int *nums_heap=NULL;
int heap_capacity=0;
bool is_big_heap=true;
void create_heap(int capacity, bool big){
    if (nums_heap) {
        free(nums_heap);
        nums_size=0;
    }
    nums_heap=(int *)malloc(sizeof(int)*capacity);
    heap_capacity=capacity;
    is_big_heap=big;
}
int get_heap_size(){
    return nums_size;
}
void add_top(int ele){
    if (heap_capacity == nums_size) {
        NSLog(@"Binary heap is full");
        return;
    }
    nums_heap[nums_size++]=ele;// 添加到数组最后
    if (is_big_heap) {
        shiftUp_C_for_big_heap(nums_size-1);// 把刚添加的这个最后一个元素上滤
    }else{
        shiftUp_C_for_small_heap(nums_size-1);// 把刚添加的这个最后一个元素上滤
    }
}
int remove_top(){
    if (nums_size == 0){
        NSLog(@"Binary heap is empty");
        return -1;
    }
    int ele = nums_heap[0];
    //拿最后一个元素直接覆盖根节点元素
    nums_heap[0]=nums_heap[nums_size-1];
    nums_size--;
    
    if (is_big_heap) {
        //此时根节点已经是最后一个元素了，再重新排序成大堆
        shiftdown_C_for_big_heap(0);
    }else{
        shiftdown_C_for_small_heap(0);
    }
    return ele;
}
int get_top(){
    if (nums_size == 0){
        NSLog(@"Binary heap is empty");
        return -1;
    }
    return nums_heap[0];
}
int *get_result(){
    return nums_heap;
}
// C 实现 大顶堆
void shiftUp_C_for_big_heap(int index){
    int ele=nums_heap[index]; // 获取index下这个值
    while (index>0) {
        // 获取该index对应的父节点 p_index =（index-1）/ 2
        int p_index=(index-1) >> 1;
        int p_ele=nums_heap[p_index];
        
        //加入的值比父节点小，不需要上虑
        if (ele <= p_ele) break;
        
        //否则将父节点的内容存储在index中
        //index一直往上找，最终这个最大的值一直找到根节点，直接替换根节点的值
        nums_heap[index]=p_ele;
        //index 重新复制，变成了刚才获取到的父节点的索引
        index=p_index;
    }
    //最终这个最大的值一直找到根节点，直接替换根节点的值
    nums_heap[index]=ele;
}
// C 实现 小顶堆
void shiftUp_C_for_small_heap(int index){
    int ele=nums_heap[index]; // 获取index下这个值
    while (index>0) {
        // 获取该index对应的父节点 p_index =（index-1）/ 2
        int p_index=(index-1) >> 1;
        int p_ele=nums_heap[p_index];
        
        //小顶堆 加入的值比父节点大，不需要上虑
        if (ele >= p_ele) break;
        
        //否则将父节点的内容存储在index中
        //index一直往上找，最终这个最大的值一直找到根节点，直接替换根节点的值
        nums_heap[index]=p_ele;
        //index 重新复制，变成了刚才获取到的父节点的索引
        index=p_index;
    }
    //最终这个最大的值一直找到根节点，直接替换根节点的值
    nums_heap[index]=ele;
}
// C 实现 大顶堆
void shiftdown_C_for_big_heap(int index){
    int element = nums_heap[index];
    int half = nums_size >> 1;//除2，这是第一个叶子结点的索引。
    // 第一个叶子节点的索引 == 非叶子节点的数量
    // index < 第一个叶子节点的索引
    while (index < half) { // 必须保证index位置是非叶子节点
        // index的节点有2种情况
        // 1.只有左子节点
        // 2.同时有左右子节点
        // 默认为左子节点跟它进行比较
        //左子节点下标
        int leftChildIndex = (index << 1) + 1; // 左孩子：2*i + 1
        //左子节点值
        int leftChild = nums_heap[leftChildIndex];
        // 右子节点下标
        int rightIndex = leftChildIndex + 1; // // 右孩子：2*i + 2
        
        // 左右孩子先比较选出最大的那个
        if (rightIndex < nums_size && nums_heap[rightIndex] > leftChild) {
            //如果右节点值大于左节点值，就把右节点值取出来
            leftChildIndex=rightIndex;
            leftChild = nums_heap[leftChildIndex];
        }
        //element和leftChild比较大小，此处的leftChild其实已经挑出了左右节点最大的值
        //如果是大顶堆，并且element > leftChild，则不需要动。
        if (element >= leftChild) break;
        
        //大顶堆，但element <= leftChild, 将子节点较大的值存放到index位置
        nums_heap[index] = leftChild;
        // 重新设置index，此处的leftChildIndex其实已经确定了了左右节点最大的值的index
        index = leftChildIndex;
    }
    //最终这个element呗放到了合适的index下
    nums_heap[index] = element;
}
// C 实现 小顶堆
void shiftdown_C_for_small_heap(int index){
    int element = nums_heap[index];
    int half = nums_size >> 1;//除2，这是第一个叶子结点的索引。
    // 第一个叶子节点的索引 == 非叶子节点的数量
    // index < 第一个叶子节点的索引
    while (index < half) { // 必须保证index位置是非叶子节点
        // index的节点有2种情况
        // 1.只有左子节点
        // 2.同时有左右子节点
        // 默认为左子节点跟它进行比较
        //左子节点下标
        int leftChildIndex = (index << 1) + 1; // 左孩子：2*i + 1
        //左子节点值
        int leftChild = nums_heap[leftChildIndex];
        // 右子节点下标
        int rightIndex = leftChildIndex + 1; // // 右孩子：2*i + 2
        
        // 左右孩子先比较选出最小的那个
        if (rightIndex < nums_size && nums_heap[rightIndex] < leftChild) {
            //如果右节点值大于左节点值，就把右节点值取出来
            leftChildIndex=rightIndex;
            leftChild = nums_heap[leftChildIndex];
        }
        //element和leftChild比较大小，此处的leftChild其实已经挑出了左右节点最小的值
        //小顶堆，并且element < leftChild，则不需要动。
        if (element <= leftChild) break;
        
        //小顶堆，但element >= leftChild, 将子节点较小的值存放到index位置
        nums_heap[index] = leftChild;
        // 重新设置index，
        index = leftChildIndex;
    }
    //最终这个element呗放到了合适的index下
    nums_heap[index] = element;
}


@end
