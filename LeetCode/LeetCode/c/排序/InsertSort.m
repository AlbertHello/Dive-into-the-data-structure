//
//  InsertSort.m
//  LeetCode
//
//  Created by 58 on 2020/10/30.
//

#import "InsertSort.h"

@implementation InsertSort

/**
 插入排序非常类似于扑克牌的排序：在新抓到的牌中插入已经排好序的牌中。
 执行流程
 ① 在执行过程中，插入排序会将序列分为2部分
 ✓ 头部是已经排好序的，尾部是待排序的
 ② 从头开始扫描每一个元素
 ✓ 每当扫描到一个元素，就将它插入到头部合适的位置，使得头部数据依然保持有序
 
 ◼ 插入排序的时间复杂度与逆序对的数量成正比关系
 逆序对的数量越多，插入排序的时间复杂度越高
 最坏、平均时间复杂度： O(n2)
 ◼ 最好时间复杂度： O(n)
 ◼ 空间复杂度： O(1)
 ◼ 属于稳定排序
 
 当逆序对的数量极少时，插入排序的效率特别高
 甚至速度比 O nlogn 级别的快速排序还要快
 
 数据量不是特别大的时候，插入排序的效率也是非常好的
 */
-(void)insertSort:(int *)arr length:(int)len{
    self.time=CFAbsoluteTimeGetCurrent();
    for (int begin=1; begin<len; begin++) {
        int cur=begin;
        while (cur>0 && [self cmp:arr[cur] to:arr[cur-1]] < 0) {
            //只要[self cmp:arr[cur] to:arr[cur-1]]不小于0，那么久没必要再和arr[cur-2]比较
            //因为cur之前的都是已经排好序的了
            [self swap:&arr[cur] with:&arr[cur-1]];
            cur--;
        }
    }
    self.time=CFAbsoluteTimeGetCurrent()-self.time;
}
/**
 优化1
 思路是将【交换】 转为【挪动】
 ① 先将待插入的元素备份
 ② 头部有序数据中比待插入元素大的，都朝尾部方向挪动1个位置
 ③ 将待插入元素放到最终的合适位置
 
 如果使用“交换”策略，那么交换一次需要三行代码
 如果使用“挪动”策略，那么替换操作只需要一行代码， 虽然还有额外的一行备份代码int v = arr[cur]
 和arr[cur] = v;代码。但加入需要交换的数字比较多时，效率就能看出来了：
 比如有10个数需要交换，那么：
 交换：需要30行代码
 挪动：2+10*1=22行代码
 
 效率久出来了
 */
-(void)insertSort2:(int *)arr length:(int)len{
    self.time=CFAbsoluteTimeGetCurrent();
    for (int begin = 1; begin < len; begin++) {
        int cur = begin;
        int v = arr[cur];//备份当前要插入的值
        //拿当前的值和这个值前面的所有值比较大小
        while (cur > 0 && [self cmp:v to:arr[cur-1]] < 0) {
            //如果前面的值大于v，那么就让前面的值覆盖这个值，而不是他俩互相交换
            arr[cur] = arr[cur - 1];
            cur--;
        }
        //最终找到不大于v的值就把v放到此处
        arr[cur] = v;
    }
    self.time=CFAbsoluteTimeGetCurrent()-self.time;
}
/**
 优化2
 在元素 v 的插入过程中，可以先二分搜索出合适的插入位置，然后再将元素 v 插入
index:  0  1  2  3  4   5    6
value:  2  4  8  8  8  12  14
 要求二分搜索返回的插入位置：第1个大于 v 的元素位置
 如果 v 是 5，返回 2
 如果 v 是 1，返回 0
 如果 v 是 15，返回 7
 如果 v 是 8，返回 5
 
 假设在 [begin, end) 范围内搜索某个元素 v， mid == (begin + end) / 2
 ◼ 如果 v < m，去 [begin, mid) 范围内二分搜索
 ◼ 如果 v ≥ m，去 [mid + 1, end) 范围内二分搜索
 
 要注意的是，使用了二分搜索后，只是减少了比较次数，但插入排序的平均时间复杂度依然是 O(n2)
 */
-(void)insertSort3:(int *)arr length:(int)len{
    self.time=CFAbsoluteTimeGetCurrent();
    for (int begin = 1; begin < len; begin++) {
        int v = arr[begin]; //备份当前要插入的值
        //寻找当前值需要插入的索引为多少
        int insertIndex = [self search:begin arr:arr];
        // 将 [insertIndex, begin) 范围内的元素往右边挪动一个单位
        for (int i = begin; i > insertIndex; i--) {
            arr[i] = arr[i - 1];
        }
        arr[insertIndex] = v;//插入
    }
    self.time=CFAbsoluteTimeGetCurrent()-self.time;
}

/**
 * 利用二分搜索找到 index 位置元素的待插入位置
 * 已经排好序数组的区间范围是 [0, index)
 */
-(int)search:(int)index arr:(int *)arr {
    int begin = 0;
    int end = index;
    while (begin < end) {
        int mid = (begin + end) >> 1; //取中间索引
        //当前值和中间索引的值比较大小
        if ([self cmp:arr[index] to:arr[mid]] < 0) {
            //如果当前值小于中间值则end往左娜
            end = mid;
        } else {
            //当前值大于等于中间值时，begin往后挪，直到begin=end结束
            begin = mid + 1;
        }
    }
    return begin;
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
@end
