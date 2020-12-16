//
//  15_ThreeSum.m
//  LeetCode
//
//  Created by 58 on 2020/10/21.
//

#import "15_ThreeSum.h"
#import "QuickSort.h"

@implementation _5_ThreeSum




/**
 15. 三数之和
 https://leetcode-cn.com/problems/3sum/
 难度 中等
 给你一个包含 n 个整数的数组 nums，判断 nums 中是否存在三个元素 a，b，c ，使得 a + b + c = 0 ？请你找出所有满足条件且不重复的三元组。
 注意：答案中不可以包含重复的三元组。
 示例：
 给定数组 nums = [-1, 0, 1, 2, -1, -4]，
 满足要求的三元组集合为：
 [
   [-1, 0, 1],
   [-1, -1, 2]
 ]
 
 
 首先，先找一下它的简化版 2sum 来热热身。
 最简单的想法就是把每两个都拿出来加一下，看看结果是不是我们想要的。但是直觉告诉我们，这样子并不高效。举一个很实际的例子就能明白。
 比如这个周末你去参加线下相亲会，全场有且只有两个人才是真爱。于是我们每个人都要去找其他所有人聊天，去寻找 ta 是不是自己要找的另一半。每个人都要和每个人说话，这样时间复杂度很高，翻译成计算机的表示就是 O(n^2)。
 */
// 时间复杂度：O(n^2)
// 空间复杂度：O(1)
-(NSArray *)twoSum1:(NSArray *)nums target:(NSInteger)target{
    for (int i = 0; i < nums.count - 1; i++) { // 每个人 O(n)
        for (int j = i + 1; j < nums.count; j++) { // 都去问其他的人 O(n)
            int v1=[nums[i] intValue];
            int v2=[nums[j] intValue];
          if (v1+v2 == target) {
              return @[@(v1), @(v2)];
          }
        }
    }
    return @[];
}
/*
 怎么样可以更高效一点？
 这时候要引入哈希表，其实就是一个登记册，写上你的名字和你的要求。如果每个人都提前在主持人那里登记一遍，然后只要大家依次再报出自己名字，主持人就能够识别到，ta 就是你要找的人。
 此时复杂度O(2n)
 */
//
//
-(NSArray *)twoSum2:(NSArray *)nums target:(NSInteger)target{
    NSMutableDictionary *map= [NSMutableDictionary dictionary];
    for (int i = 0; i < nums.count; i++) { // O(n)
        NSInteger need=target-[nums[i] intValue];
        NSString *key=@(need).stringValue;
        map[key] = nums[i];// 每个人登记自己想要配对的人，让主持人记住
    }
    for (int j = 0; j < nums.count; j++) {
        NSInteger val=[nums[j] intValue];
        NSString *matchKey=@(val).stringValue;
        // 每个人再次报数的时候，主持人看一下名单里有没有他
        if (map[matchKey]) {
            return @[nums[j], map[matchKey]];
        }
    }
    return @[];
}
/**
 很容易看出来，上面的方案仍然可以优化。就是每个人都来问一下主持人，自己要找的人有没有来登记过，如果没有的话，就把自己的要求写下来，等着别人来找自己。
 此时
 时间复杂度是O(n)
 空间复杂度是O(n)
 
 2sum 问题最坏的情况是，第一个人和最后一个人配对，每个人都发了一次言。时间复杂度是 O(n)，空间复杂度也是 O(n)，因为主持人要用小本本记录下每个人的发言，最坏的时候，要把所有人的诉求都记一遍。

 */
-(NSArray *)twoSum3:(NSArray *)nums target:(NSInteger)target{
    NSMutableDictionary *map= [NSMutableDictionary dictionary];
    
    for (int j = 0; j < nums.count; j++) { // O(n)
        NSInteger val=[nums[j] intValue];
        NSString *matchKey=@(val).stringValue;
        // 看map里是否有需要的那个数
        if (map[matchKey]) {
            return @[nums[j], map[matchKey]];
        }else{
            //记住需求
            NSInteger need=target-val;
            NSString *key=@(need).stringValue;
            map[key] = nums[j];
        }
    }
    return @[];
}


-(NSInteger **)threeSum:(NSInteger *)nums
               numsSize:(NSInteger)numsSize
             returnSize:(NSInteger *)returnSize
      returnColumnSizes:(NSInteger **)returnColumnSizes{
    
    
    
    
    return NULL;
}
/**
 我们先想一个保底的办法，再去慢慢优化。最简单的办法是，每个人都去依次拉上另一个人一起去找第三个人，这个时间复杂度是O(n^3)。
 
 */
// 时间复杂度是O(n^3)
// 空间复杂度是O(1)
-(NSArray *)threeSum1:(NSArray *)nums target:(NSInteger)target{
    for (int i = 0; i < nums.count - 2; i++) { // 每个人 O(n)
        for (int j = i + 1; j < nums.count-1; j++) { // 都去问其他的人 每个人 O(n)
            for (int k=j+1; k<nums.count; k++) { //每个人 O(n)
                int v1=[nums[i] intValue];
                int v2=[nums[i] intValue];
                int v3=[nums[k] intValue];
                if (v1+v2+v3 == target) {
                  return @[@(v1), @(v2), @(v3)];
                }
            }
        }
    }
    return @[];
}

/**
 排序 + 双指针

 本题的难点在于如何去除重复解。
 算法流程：

 1、特判，对于数组长度n，如果数组为null 或者数组长度小于3，返回[]。
 2、对数组进行排序。
 3、遍历排序后数组：
    1. 若nums[i]>0：因为已经排序好，所以后面不可能有三个数加和等于0，直接返回结果。
    2. 对于重复元素：跳过，避免出现重复解
    3. 令左指针L=i+1，右指针R=n−1，当L<R 时，执行循环：
        1. 当nums[i]+nums[L]+nums[R]==0，执行循环，判断左界和右界是否和下一位置重复，
 去除重复解。并同时将L,R移到下一位置，寻找新的解。
        2. 若和大于0，说明nums[R] 太大，R 左移
        3. 若和小于0，说明nums[L] 太小，L 右移

 复杂度分析
 1、时间复杂度：O(n^2)
 其中数组排序O(NlogN)，遍历数组O(n)，双指针遍历O(n)，总体O(NlogN)+O(n)∗O(n)，O(n^2)
 2、空间复杂度：O(1)
 */
+(NSArray *)threeSum2:(NSArray *)nums target:(NSInteger)target{
    //1 对于数组长度n，如果数组为null 或者数组长度小于3，返回[]。
    if (nums==nil || nums.count < 3) return @[];
    //2 对数组进行排序。升序
    NSArray *newArr=[nums sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSNumber *tNumber1 = (NSNumber *)obj1;
        NSNumber *tNumber2 = (NSNumber *)obj2;
        // 因为满足sortedArrayUsingComparator方法的默认排序顺序，则不需要交换
        if ([tNumber1 integerValue] < [tNumber2 integerValue]) return NSOrderedAscending;
        return NSOrderedDescending;
    }];
    // 3 遍历
    NSMutableArray *res=[NSMutableArray array];
    for (int i=0; i<newArr.count; i++) {
        //3.1 有开始大于0的出现了则直接返回
        if ([newArr[i] intValue] > 0) return res;
        //3.2 对于重复元素：跳过，避免出现重复解
        if (i>0 && [newArr[i] intValue] == [newArr[i-1] intValue]) continue;
        //3.3 左指针L=i+1，右指针R=n−1
        int L=i+1;
        NSInteger R=newArr.count-1;
        
        while (L<R) {
            int v1=[newArr[i] intValue];
            int v2=[newArr[L] intValue];
            int v3=[newArr[R] intValue];
            if (v1+v2+v3==0) {
                // 找到一个
                [res addObject:@[newArr[i],newArr[L],newArr[R]]];
                // 判断左界是否和下一位置重复，去除重复解。
                while(L<R && [newArr[L] intValue] == [newArr[L+1] intValue]){
                    L=L+1;
                }
                // 判断右界是否和下一位置重复，去除重复解。
                while(L<R && [newArr[R] intValue]==[newArr[R-1] intValue]){
                    R=R-1;
                }
                L=L+1;
                R=R-1;
            }else if (v1+v2+v3>0){
                //若和大于0，说明nums[R] 太大，R 左移
                R=R-1;
            }else{
                //若和小于0，说明nums[L] 太小，L 右移
                L=L+1;
            }
        }
    }
    return res;
}

int** threeSum(int* nums, int numsSize, int* returnSize, int** returnColumnSizes){
    // 1 对于数组长度n，如果数组为null 或者数组长度小于3，返回[]。
    if (nums==NULL || numsSize < 3) return NULL;
    // 2 排序
    quick_sort(nums, 0, numsSize);// 时间：nlogn 空间：logn
    int **res=(int**)malloc(sizeof(int *)*numsSize*numsSize);
    // int res[10][10]={0};
    int k=0;
    for (int i=0; i<numsSize; i++) {
        //又开始大于0的出现了则直接返回
        if (nums[i] > 0){
            if (k==0) {
                return NULL;
            }
            *returnSize=k;
            return res;
        }
        // 对于重复元素：跳过，避免出现重复解
        if (i>0 && nums[i] == nums[i-1]) continue;
        
        //左指针L=i+1，右指针R=n−1
        int L=i+1;
        NSInteger R=numsSize-1;
        
        while (L<R) {
            if (nums[i]+nums[L]+nums[R]==0) {
                //找到一个
                int r[3]={0};
                r[0]=nums[i];
                r[1]=nums[L];
                r[2]=nums[R];
                *(res+k)=r;
                k++;
                // 判断左界是否和下一位置重复，去除重复解。
                while(L<R && nums[L] == nums[L+1]){
                    L=L+1;
                }
                // 判断右界是否和下一位置重复，去除重复解。
                while(L<R && nums[R]==nums[R-1]){
                    R=R-1;
                }
                L=L+1;
                R=R-1;
            }else if (nums[i]+nums[L]+nums[R]>0){
                //若和大于0，说明nums[R] 太大，R 左移
                R=R-1;
            }else{
                //若和小于0，说明nums[L] 太小，L 右移
                L=L+1;
            }
        }
    }
    *returnSize=k;
    int **result=(int**)malloc(sizeof(int)*k*3);
    int m=0;
    for (k=k-1; k>=0; k--) {
        result[m++]=res[k];
    }
    return result;
}

+(void)threeSumTest{
    NSArray *arr=@[@(-1), @(0), @(1), @(2), @(-1), @(-4)];
    
    NSLog(@"%@",[self threeSum2:arr target:0]);
    
    
//    int nums[]={-1, 0, 1, 2, -1, -4};
//    int returnSize=0;
//    int returnColumnSizes=3;
//    int **res = threeSum(nums, 6, &returnSize, NULL);
//    for (int i=0; i<returnSize; i++) {
//        for (int j=0; j<returnColumnSizes; j++) {
//            printf("%d",res[i][j]);
//        }
//        printf("% \n");
//    }
}

@end
