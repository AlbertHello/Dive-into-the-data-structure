//
//  HeapSort.m
//  LeetCode
//
//  Created by 58 on 2020/10/28.
//

#import "HeapSort.h"

static id object=NULL;
static int * g_array=NULL;

@interface HeapSort (){
    
}

@property(nonatomic,assign)NSUInteger size;
@property(nonatomic,assign)NSUInteger bigHeap;//是否是大顶堆，默认是YES
@property(nonatomic,strong)NSMutableArray *array;

@end

@implementation HeapSort
-(instancetype)init{
    if (self=[super init]) {
        object=self;
    }
    return self;
}

/**
 堆排序可以认为是对选择排序的一种优化
 
 ① 对序列进行原地建堆（heapify）
 ② 重复执行以下操作，直到堆的元素数量为 1
 ✓ 交换堆顶元素与尾元素
 ✓ 堆的元素数量减 1
 ✓ 对 0 位置进行 1 次 siftDown 操作
 
 最好、最坏、平均时间复杂度： O(nlogn)，空间复杂度： O(1)，属于不稳定排序
 
 */

-(void)heapifyWith:(NSMutableArray *)array{
    self.time=CFAbsoluteTimeGetCurrent();
    // 原地建堆,直接把外部传入的数组进行排列。不需要额外申请空间拷贝
    self.array=array;
    self.size = array.count;
    // 从非叶子节点开始 i = (self.size >> 1) - 1
    //自下而上的下虑
    for (int i = (int)(self.size >> 1) - 1; i >= 0; i--) {
        [self shiftDown:i];
    }//这样处理完后只是建立了一个局部有序的大顶堆。还需要继续排序
    
    while (self.size > 1) {
        // 交换堆顶元素和尾部元素
        --self.size;
        NSNumber *top=self.array[0];
        self.array[0]=self.array[self.size];
        self.array[self.size]=top;
//        [self swapObj:self.array[0] with:self.array[self.size]];
        // 对0位置进行siftDown（恢复堆的性质）
        //因为此时size已经减一，再进行下虑不会再把最后一个最大的值给弄上去
        //只会把第二大的值弄到堆顶
        [self shiftDown:0];
    }
    self.time=CFAbsoluteTimeGetCurrent()-self.time;
}
-(void)shiftDown:(int)index{
    int ele  = [self.array[index] intValue];
    
    int half = (int) self.size >> 1;
    while (index < half) { // index必须是非叶子节点
        // 默认是左边跟父节点比
        int childIndex = (index << 1) + 1;
        int child = [self.array[childIndex] intValue];
        
        int rightIndex = childIndex + 1;
        // 右子节点比左子节点大
        if (rightIndex < self.size && [self cmp:[self.array[rightIndex]intValue] to:child] > 0) {
            child = [self.array[childIndex = rightIndex] intValue];
        }
        
        // 大于等于子节点
        if ([self cmp:ele to:child] >= 0) break;
        
        self.array[index] = @(child);
        index = childIndex;
    }
    self.array[index] = @(ele);
}
-(NSString *)description{
    NSString *class=NSStringFromClass([self class]);
    NSString *time=[NSString stringWithFormat:@"%f",self.time];
    NSString *cmpCount=[NSString stringWithFormat:@"%ld",self.cmpCount];
    NSString *swapCount=[NSString stringWithFormat:@"%ld",self.swapCount];
    NSString *str=[NSString stringWithFormat:@"\n Sort: %@\n 耗时：%@\t 比较次数：%@\t 交换次数：%@\t",class,time,cmpCount,swapCount];
    printf("************************************************\n");
    return str;
}


//************************** C 语言实现 ***************************************
-(void)heapifyWith:(int *)arr length:(int)len{
    self.time=CFAbsoluteTimeGetCurrent();
    // 原地建堆,直接把外部传入的数组进行排列。不需要额外申请空间拷贝
    g_array=arr;
    self.size=len;
    // 从非叶子节点开始 i = (self.size >> 1) - 1
    //自下而上的下虑
    for (int i = (len >> 1) - 1; i >= 0; i--) {
        shiftDown(i);
    }//这样处理完后只是建立了一个局部有序的大顶堆。还需要继续排序
    while (len > 1) {
        // 交换堆顶元素和尾部元素
        --len;
        [self swap:&g_array[0] with:&g_array[len]];
//        [self swapObj:self.array[0] with:self.array[self.size]];
        // 对0位置进行siftDown（恢复堆的性质）
        //因为此时size已经减一，再进行下虑不会再把最后一个最大的值给弄上去
        //只会把第二大的值弄到堆顶
        shiftDown(0);
    }
    self.time=CFAbsoluteTimeGetCurrent()-self.time;
}
void shiftDown(int index){
    HeapSort *obj=(HeapSort *)object;
    int ele = g_array[index];
    int half = (int) obj.size >> 1;
    while (index < half) { // index必须是非叶子节点
        // 默认是左边跟父节点比
        int childIndex = (index << 1) + 1;
        int child = g_array[childIndex];
        
        int rightIndex = childIndex + 1;
        // 右子节点比左子节点大
        if (rightIndex < obj.size && [obj cmp:g_array[rightIndex] to:child] > 0) {
            child = g_array[childIndex = rightIndex];
        }
        // 大于等于子节点
        if ([obj cmp:ele to:child] >= 0) break;
        g_array[index] = child;
        index = childIndex;
    }
    g_array[index] = ele;
}
@end
