//
//  BinarySearch.m
//  LeetCode
//
//  Created by Albert on 2020/11/1.
//

#import "BinarySearch.h"

@implementation BinarySearch
// 大O排序
// O(1) < O(logn) < O(n) < O(nlogn) < O(n^2) < O(2^n) < O(n!)

//  名称    最好          最坏               平均            空间   in-place  稳定性
// 冒泡排序  O(n)         O(n^2)            O(n^2)          O(1)    ✅       ✅
// 选择排序  O(n^2)       O(n^2)            O(n^2)          O(1)    ✅       ❌
// 插入排序  O(n)         O(n^2)            O(n^2)          O(1)    ✅       ✅
// 归并排序  O(nlogn)     O(nlogn)          O(nlogn)        O(n)    ❌       ✅
// 快速排序  O(nlogn)     O(n^2)             O(nlogn)        O(logn) ✅       ❌
// 希尔排序  O(n)     O(n^(4/3))~O(n^2)   取决于步长序列       O(1)    ✅       ❌
// 堆排序    O(nlogn)     O(nlogn)         O(nlogn)         O(1)    ✅       ❌
// 计数排序  O(n + k)     O(n + k)          O(n + k)        O(n + k) ❌      ✅
// 基数排序  O(d∗(n+k))   O(d∗(n+k))       O(d∗(n+k))       O(n + k) ❌      ✅
// 桶排序    O(n + k)     O(n + k)          O(n + k)        O(n + m) ❌      ✅


//查找v在有序数组array（升序）中待插入位置
//如果要找的值在数组中存在多个，则此算法并不能确定找到的是哪个值
-(int)indexOf:(int *)array length:(int)len value:(int)v{
        if (array == NULL || len == 0) return -1;
        int begin = 0;
        int end = len;// end等于len，则数组长度正好等于len-begin
        while (begin < end) { //begin=end或者直接找到mid结束
            int mid = (begin + end) >> 1; //取中间索引
            if (v < array[mid]) { //当前值小于数组中间值
                end = mid; //则需要在前半部分查找，所以end=mid
            } else if (v > array[mid]) { //当前值大于数组中间值
                begin = mid + 1; //则需要在后半部分查找，所以begin=mid+1
            } else { //当前值等于数组中间值
                return mid;
            }
        }
        return -1;
    }

//查找val在有序数组array（升序）中待插入位置
//index: 0 1 2 3 4  5  6  7
//value: 2 4 8 8 8 12 14
//则开始时，begin=0，end=7
//里面存在相同的8，如果再插入8，我要找到第1个大于 v 的元素位置，则index=5
-(int)search:(int *)array length:(int)len value:(int)val{
    if (array == NULL || len == 0) return -1;
    int begin = 0;
    int end = len;
    while (begin < end) {
        int mid = (begin + end) >> 1;
        if (val < array[mid]) { //小于
            end = mid;
        } else { //大于等于
            //这里用作大于等于
            //如果数组中存在多个相同的val
            //则能保证插入的位置是最后一个相同的值的后一个索引
            
            begin = mid + 1;
        }
    }
    return begin;
}
@end
