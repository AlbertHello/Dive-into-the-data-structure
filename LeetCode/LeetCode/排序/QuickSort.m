//
//  QuickSort.m
//  LeetCode
//
//  Created by Albert on 2020/11/1.
//

#import "QuickSort.h"

@interface QuickSort ()

@property(nonatomic,strong)NSMutableArray *array;

@end

@implementation QuickSort




// 大O排序
// O(1) < O(logn) < O(n) < O(nlogn) < O(n^2) < O(2^n) < O(n!)

//  名称    最好          最坏               平均            空间   in-place  稳定性
// 冒泡排序  O(n)         O(n^2)            O(n^2)          O(1)    ✅       ✅
// 选择排序  O(n^2)       O(n^2)            O(n^2)          O(1)    ✅       ❌
// 插入排序  O(n)         O(n^2)            O(n^2)          O(1)    ✅       ✅
// 归并排序  O(nlogn)     O(nlogn)          O(nlogn)        O(n)    ❌       ✅
// 快速排序  O(nlogn)     O(n^2)            O(nlogn)        O(logn) ✅       ❌
// 希尔排序  O(n)     O(n^(4/3))~O(n^2)   取决于步长序列       O(1)    ✅       ❌
// 堆排序    O(nlogn)     O(nlogn)         O(nlogn)         O(1)    ✅       ❌
// 计数排序  O(n + k)     O(n + k)          O(n + k)        O(n + k) ❌      ✅
// 基数排序  O(d∗(n+k))   O(d∗(n+k))       O(d∗(n+k))       O(n + k) ❌      ✅
// 桶排序    O(n + k)     O(n + k)          O(n + k)        O(n + m) ❌      ✅

/**
 
 快速排序的逻辑是若要对nums[lo..hi]进行排序，我们先找一个分界点p，通过交换元素使得nums[lo..p-1]都小于等于nums[p]，且nums[p+1..hi]都大于nums[p]，然后递归地去nums[lo..p-1]和nums[p+1..hi]中寻找新的分界点，最后整个数组就被排序了
 
 执行流程：
 
 1、从序列中选择一个轴点元素（pivot）
 ✓ 假设每次选择 0 位置的元素为轴点元素
 
 2、利用 pivot 将序列分割成 2 个子序列
 ✓ 将小于 pivot 的元素放在pivot前面（左侧）
 ✓ 将大于 pivot 的元素放在pivot后面（右侧）
 ✓ 等于pivot的元素放哪边都可以。
 
 3、对子序列进行 ① ② 操作
 ✓ 直到不能再分割（子序列中只剩下1个元素）
 
 快速排序的本质
 逐渐将每一个元素都转换成轴点元素
 
 在轴点左右元素数量比较均匀的情况下，同时也是最好的情况
 T(n) = 2 * T(n/2) + O(n) = O(nlogn)
 
 如果轴点左右元素数量极度不均匀，最坏情况
  T(n) = T(n-1) + O(n) = O(n^2)
 
 为了降低最坏情况的出现概率，一般采取的做法是
 随机选择轴点元素
 
 最好、平均时间复杂度： O(nlogn)
 ◼ 最坏时间复杂度： O(n2)
 ◼ 由于递归调用的缘故，空间复杂度： O(logn)，也就是递归深度
 ◼ 属于不稳定排序
 */
-(void)quickSort:(NSMutableArray *)array{
    self.time=CFAbsoluteTimeGetCurrent();
    self.array=array;
    [self sort:0 end:(int)self.array.count];
    self.time=CFAbsoluteTimeGetCurrent()-self.time;
}
//对 [begin, end) 范围的数据进行归并排序
-(void)sort:(int)begin end:(int)end {
    if (end - begin < 2) return;
    // 确定轴点位置 O(n)
    int mid = [self pivotIndex:begin end:end];
    // 对子序列进行快速排序
    [self sort:begin end:mid];
    [self sort:mid+1 end:mid];
}
-(int)pivotIndex:(int)begin end:(int)end{
    // 随机选择一个元素跟begin位置进行交换，降低最坏情况出现的概率
    int randomIndex=(arc4random()%(end-begin)) + begin;
    NSNumber *temp=self.array[begin];
    self.array[begin]=self.array[randomIndex];
    self.array[randomIndex]=temp;
    
    // 备份begin位置的元素，还是取index=begin处的元素作为标准值判断，但是这个标准值已经是随机的了。
    int pivot = [self.array[begin] intValue];
    // end指向最后一个元素
    end--;
    
    while (begin < end) {
        // 左右begin end交替判断就可以用到这两个while来实现
        while (begin < end) {
            // 右边元素 > 轴点元素
            // 如果小于号改成小于等于号，则可能就会导致最坏情况发生
            if ([self cmp:pivot to:[self.array[end] intValue] ] < 0) {
                end--;
            } else { // 右边元素 <= 轴点元素
                self.array[begin++] = self.array[end];
                //一旦end处的值小于轴点元素了，把值替换后break，
                //下一轮就从begin处开始判断
                //begin end 交替判断
                break;
            }
        }
        while (begin < end) {
            // 左边元素 < 轴点元素
            // 如果大于号改成大于等于号，则可能就会导致最坏情况发生
            if ([self cmp:pivot to:[self.array[begin] intValue]] > 0) {
                begin++;
            } else { // 左边元素 >= 轴点元素
                self.array[end--] = self.array[begin];
                //一旦begin处的值大于等于轴点元素了，把值替换后break，
                //下一轮就从end处开始判断了
                //begin end 交替判断
                break;
            }
        }
    }
    //能来到这里说明begin=end了，也就找到了最中间的那个值的索引
    // 将轴点元素放入最终的位置
    self.array[begin] = @(pivot);
    // 返回轴点元素的位置
    return begin;
}
/// C 实现 快排 [ begin, end )
void quick_sort(int *nums, int begin, int end){
    if (end - begin < 2) return;
    // 在[begin,end)随机选择一个元素跟begin位置进行交换，降低最坏情况出现的概率
    int random_index=(arc4random()%(end-begin)) + begin;
    int temp_begin = nums[begin];
    nums[begin] = nums[random_index];
    nums[random_index]=temp_begin;
    
    int left = begin;
    int right = end;
    // 备份begin位置的元素，还是取index=begin处的元素作为标准值判断
    int pivot = nums[begin]; // 这个标准值已经是[begin， end)随机的了，降低最坏情况发生概率
    // end指向最后一个元素
    right--;
    
    while (left < right) {
        // 左右begin end交替判断就可以用到这两个while来实现
        while (left < right) {
            // 如果大于号改成大于等于号，则可能就会导致最坏情况发生
            if (nums[right] > pivot) { // 右边元素 > 轴点元素
                right--;
            } else { // 右边元素 <= 轴点元素 就得往轴点元素左边移动了
                //下一轮就从轴点左侧开始判断
                //begin end 交替判断
                nums[left++]=nums[right];
                break;
            }
        }
        while (left < right) {
            // 如果小于号改成小于等于号，则可能就会导致最坏情况发生
            if (nums[left] < pivot) { // 左边元素 < 轴点元素
                left++;
            } else { // 左边元素 >= 轴点元素 就得往轴点元素右边移动了
                //下一轮就从轴点右侧开始判断了
                //begin end 交替判断
                nums[right--]=nums[left];
                break;
            }
        }
    }
    
    //能来到这里说明left=right了，也就找到了最中间的那个值的索引
    // 将轴点元素放入最终的位置
    nums[left]=pivot;
    
    // 对子序列进行快速排序
    quick_sort(nums, begin, left); // [begin, left)
    quick_sort(nums, left+1, end); // [left+1, end)
}

/// C 实现 快排2 [begin, end] 闭区间
void quick_sort2(int* nums, int begin, int end){
    
    if (begin >= end) return;
    
    // 在[begin,end)随机选择一个元素跟begin位置进行交换，降低最坏情况出现的概率
    int random_index=(arc4random()%(end-begin + 1)) + begin;
    int temp_begin = nums[begin];
    nums[begin] = nums[random_index];
    nums[random_index]=temp_begin;
    
    int left = begin;
    int right = end;
    
    // 备份begin位置的元素，还是取index=begin处的元素作为标准值判断
    int pivot = nums[begin];
    while (left < right) {
        // 左右begin end交替判断就可以用到这两个while来实现
        while (left < right) {
            // 如果大于号改成大于等于号，则可能就会导致最坏情况发生
            if (nums[right] > pivot) { // 右边元素 > 轴点元素
                right--;
            } else { // 右边元素 <= 轴点元素 就得往轴点元素左边移动了
                //下一轮就从轴点左侧开始判断
                //begin end 交替判断
                nums[left++]=nums[right];
                break;
            }
        }
        while (left < right) {
            // 如果小于号改成小于等于号，则可能就会导致最坏情况发生
            if (nums[left] < pivot) { // 左边元素 < 轴点元素
                left++;
            } else { // 左边元素 >= 轴点元素 就得往轴点元素右边移动了
                //下一轮就从轴点右侧开始判断了
                //begin end 交替判断
                nums[right--]=nums[left];
                break;
            }
        }
    }
    //能来到这里说明left=right了，也就找到了最中间的那个值的索引
    // 将轴点元素放入最终的位置
    nums[left]=pivot;
    
    quick_sort2(nums, begin, left-1);
    quick_sort2(nums, left+1, end);
}




/*
 与轴点相等的元素
 如果序列中的所有元素都与轴点元素相等，利用目前的算法实现，轴点元素可以将序列分割成 2 个均匀的子序列
 如果不加等于号：
 比如：6𝑎 6𝑏 6c 6𝑑 6𝑒 六个数中，以6a当作标准值，
 排序完后：6𝑒 6𝑑 6𝑎 6𝑐 6𝑏
 如果加等于号，则排序完成：
 6𝑎 6𝑏 6c 6𝑑 6𝑒 则这歌情况轴点元素分割出来的子序列极度不均匀， 左子序列是0个元素，右子序列有n-1个元素，
 下一轮右边有n-2个元素。。。。。
 导致出现最坏时间复杂度 O(n^2)
 
 
 */
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
