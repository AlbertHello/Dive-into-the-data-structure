//
//  _253_MeetingRoom_2.m
//  LeetCode
//
//  Created by 58 on 2020/12/9.
//

#import "_253_MeetingRoom_2.h"

@implementation _253_MeetingRoom_2

void quick_sort_meeting_room(int a[], int begin, int end);


/**
 253 会议室II
 给定一个会议时间安排的数组，每个会议时间都包括开始时间和结束时间
 [[s1,e1],[s2,e2],[s3,e3]](si < ei)
 为避免会议冲突，同时要考虑充分利用会议室资源，请你计算至少需要多少间会议室才能满足这些会议安排
 
 示例1:
 输入：[[0,30],[5,10],[15,20]]
 输出：2
 示例2:
 输入：[[7,10],[2,4]]
 输出：1
 
 */

/**
 解法1：分开排序
 
 */
+(NSInteger)minMeetingRoom_OC:(NSArray *)intervals{
    if (intervals == nil || intervals.count == 0) return 0;
    // 1 开始时间和结束时间分开装俩数组
    NSMutableArray *begins=[NSMutableArray array];
    NSMutableArray *ends=[NSMutableArray array];
    for (int i=0; i<intervals.count; i++) { //O(n)
        int begin = [[intervals[i] firstObject] intValue];
        int end = [[intervals[i] lastObject] intValue];
        [begins addObject:@(begin)];
        [ends addObject:@(end)];
    }
    // 2 升序排序 O(nlogn) + O(nlogn)
    [begins sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        int begin1=[(NSNumber *)obj1 intValue];
        int begin2=[(NSNumber *)obj2 intValue];
        if (begin1 < begin2) {
            return  NSOrderedAscending;
        }else{
            return NSOrderedDescending;
        }
    }];
    [ends sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        int end1=[(NSNumber *)obj1 intValue];
        int end2=[(NSNumber *)obj2 intValue];
        if (end1 < end2) {
            return  NSOrderedAscending;
        }else{
            return NSOrderedDescending;
        }
    }];
    
    NSLog(@"begins: %@",begins);
    NSLog(@"ends: %@",ends);
    
    // 比较begin和end
    // 开始时间如果小于结束时间，肯定得需要room++嘛
    int room = 0, endIndex = 0; // 这是ends数组的索引
    for (NSNumber *beginObj in begins) { // O(n)
        int begin = beginObj.intValue;
        int end = [ends[endIndex] intValue];
        if (begin >= end) { // 只要开始时间大于结束时间就能重复利用会议室
            endIndex++; // ends数组索引往后挪
        } else { // 否则需要新开一个会议室
            room++;
        }
    }
    return room;
}
// C 实现分开排序 2(O(nlogn) + O(n))
int minMeetingRooms_C(int (*intervals)[2], int intervalsSize) {
    if (intervals == NULL || intervalsSize == 0) return 0;
    // 1 存放所有会议的开始时间
    int *begins=(int *)malloc(sizeof(int)*intervalsSize);
    // 存放所有会议的结束时间
    int *ends=(int *)malloc(sizeof(int)*intervalsSize);
    for (int i = 0; i < intervalsSize; i++) { // O(n)
        begins[i] = intervals[i][0];
        ends[i] = intervals[i][1];
    }
    
    // 2 排序
    quick_sort_meeting_room(begins, 0, intervalsSize); // O(nlogn)
    quick_sort_meeting_room(ends, 0, intervalsSize); // O(nlogn)
    
    // 3 比较
    int room = 0, endIdx = 0;
    for (int i=0; i<intervalsSize; i++) { // O(n)
        int begin = begins[i];
        int end = ends[endIdx];
        if (begin >= end) { // 能重复利用会议室
            endIdx++;
        } else { // 需要新开一个会议室
            room++;
        }
    }
    return room;
}

/**
  解法2: 最小堆
 */
//int minMeetingRooms1(int[][] intervals) {
//    if (intervals == null || intervals.length == 0) return 0;
//
//    // 按照会议的开始时间，从小到大排序  nlogn
//    Arrays.sort(intervals, (m1, m2) -> m1[0] - m2[0]);
//
//    // 创建一个最小堆（存放每一个会议的结束时间）
//    PriorityQueue<Integer> heap = new PriorityQueue<>();
//    // 添加0号会议的结束时间
//    heap.add(intervals[0][1]);
//
//    // 堆顶的含义：目前占用的会议室中最早结束的时间
//    for (int i = 1; i < intervals.length; i++) { // nlogn
//        // i号会议的开始时间 >= 堆顶
//        if (intervals[i][0] >= heap.peek()) {
//            heap.remove();
//        }
//        // 将i号会议的结束时间加入堆中
//        heap.add(intervals[i][1]);
//    }
//
//    return heap.size();
//}



// 快速排序
// 时间复杂度：平均O（nlogn）
// 空间复杂度：O(logn)  递归
void quick_sort_meeting_room(int a[], int begin, int end){
    
    if (end - begin < 2) return;
    // 在[begin,end)随机选择一个元素跟begin位置进行交换，降低最坏情况出现的概率
    int random_index=(arc4random()%(end-begin)) + begin;
    int temp_begin = a[begin];
    a[begin] = a[random_index];
    a[random_index]=temp_begin;
    
    int left = begin;
    int right = end;
    // 备份begin位置的元素，还是取index=begin处的元素作为标准值判断
    int pivot = a[begin]; // 这个标准值已经是[begin， end)随机的了，降低最坏情况发生概率
    // end指向最后一个元素
    right--;
    
    // 左右交替比较
    while (left < right) {
        // 左右begin end交替判断就可以用到这两个while来实现
        while (left < right) {
            // 如果大于号改成大于等于号，则可能就会导致最坏情况发生
            if (a[right] > pivot) { // 右边元素 > 轴点元素
                right--;
            } else { // 右边元素 <= 轴点元素 就得往轴点元素左边移动了
                //下一轮就从轴点左侧开始判断
                //begin end 交替判断
                a[left++]=a[right];
                break;
            }
        }
        while (left < right) {
            // 如果小于号改成小于等于号，则可能就会导致最坏情况发生
            if (a[left] < pivot) { // 左边元素 < 轴点元素
                left++;
            } else { // 左边元素 >= 轴点元素 就得往轴点元素右边移动了
                //下一轮就从轴点右侧开始判断了
                //begin end 交替判断
                a[right--]=a[left];
                break;
            }
        }
    }
    
    //能来到这里说明left=right了，也就找到了最中间的那个值的索引
    // 将轴点元素放入最终的位置
    a[left]=pivot;
    
    // 对子序列进行快速排序
    quick_sort_meeting_room(a, begin, left); // [begin, left)
    quick_sort_meeting_room(a, left+1, end); // [left+1, end)
}

+(void)minMeetingRoomTest{
//    NSArray *intervals=@[
//        @[@5,@10],
//        @[@15,@20],
//        @[@0,@30]
//    ];
//    NSInteger room = [self minMeetingRoom_OC:intervals];
//    NSLog(@"room: %ld",room);
    
    
    int a[][2]={{5,10},{15,20},{0,30}};
    int (*b)[2]=a;
    int room = minMeetingRooms_C(b, 3);
    printf("room: %d\n",room);
}

@end
