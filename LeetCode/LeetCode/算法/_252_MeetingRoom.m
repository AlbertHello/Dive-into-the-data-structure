//
//  _252_MeetingRoom.m
//  LeetCode
//
//  Created by 58 on 2020/12/9.
//

#import "_252_MeetingRoom.h"

@implementation _252_MeetingRoom

/**
 252 会议室
 给定一个会议时间安排的数组，每个会议时间都包括开始时间和结束时间
 [[s1,e1],[s2,e2],[s3,e3]](si < ei)
 请判断一个人是否能参加这里面的全部会议
 示例1:
 输入：[[0,30],[5,10],[15,20]]
 输出：false
 示例2:
 输入：[[7,10],[2,4]]
 输出：true
 */


+(BOOL)canAttendMeetings:(NSArray *)intervals{
    if (intervals == nil || intervals.count == 0) return true;
    // 按照会议的开始时间，从小到大排序
    NSArray *new=[intervals sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSArray *o1=(NSArray *)obj1;
        NSArray *o2=(NSArray *)obj2;
        NSInteger o1_val=[o1[0] integerValue];
        NSInteger o2_val=[o2[0] integerValue];
        if (o1_val < o2_val) {
            return NSOrderedAscending;
        }else{
            return NSOrderedDescending;
        }
    }];
    NSLog(@"%@",new);
    
    // 遍历每一个会议
    for (int i = 1; i < new.count; i++) {
        NSNumber *first_end=new[i-1][1];
        NSNumber *second_start=new[i][0];
        //第一个会议的结束时间如果大于第二个会议的开始时间，return false
        if (first_end.intValue > second_start.intValue) return false;
    }
    return true;
}

+(void)canAttendMeetingsTest{
//    NSArray *array=@[
//        @[@(15),@(20)],
//        @[@(0),@(30)],
//        @[@(5),@(10)]
//    ];
    NSArray *array=@[
        @[@(7),@(10)],
        @[@(2),@(4)]
    ];
    
    BOOL can = [self canAttendMeetings:array];
    NSLog(@"%d",can);
}





@end
