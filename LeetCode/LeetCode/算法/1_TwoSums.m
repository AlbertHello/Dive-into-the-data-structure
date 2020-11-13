//
//  1_TwoSums.m
//  LeetCode
//
//  Created by 58 on 2020/10/26.
//

#import "1_TwoSums.h"

@implementation __TwoSums

/**
 给定一个整数数组 nums 和一个目标值 target，请你在该数组中找出和为目标值的那 两个 整数，并返回他们的数组下标。

 你可以假设每种输入只会对应一个答案。但是，数组中同一个元素不能使用两遍。

  

 Example 1:

 给定 nums = [2, 7, 11, 15], target = 9

 因为 nums[0] + nums[1] = 2 + 7 = 9
 所以返回 [0, 1]
 
 Example 2:

 Input: nums = [3,2,4], target = 6
 Output: [1,2]
 
 Example 3:

 Input: nums = [3,3], target = 6
 Output: [0,1]

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/two-sum
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */


/**
 方法一：暴力枚举

 思路及算法
 
 最容易想到的方法是枚举数组中的每一个数 x，寻找数组中是否存在 target - x。
 当我们使用遍历整个数组的方式寻找 target - x 时，需要注意到每一个位于 x 之前的元素都已经和 x 匹配过，因此不需要再进行匹配。而每一个元素不能被使用两次，所以我们只需要在 x 后面的元素中寻找 target - x。

 */
int* twoSum(int* nums, int numsSize, int target, int* returnSize){
    for (int i = 0; i < numsSize; ++i) {
        for (int j = i + 1; j < numsSize; ++j) {
            if (nums[i] + nums[j] == target) {
                int* ret = malloc(sizeof(int) * 2);
                ret[0] = i;
                ret[1] = j;
                *returnSize = 2;
                return ret;
            }
        }
    }
    *returnSize = 0;
    return NULL;
}
/**
 思路及算法

 注意到方法一的时间复杂度较高的原因是寻找 target - x 的时间复杂度过高。因此，我们需要一种更优秀的方法，能够快速寻找数组中是否存在目标元素。如果存在，我们需要找出它的索引。

 使用哈希表，可以将寻找 target - x 的时间复杂度降低到从O(N) 降低到O(1)。
 这样我们创建一个哈希表，对于每一个 x，我们首先查询哈希表中是否存在 target - x，然后将 x 插入到哈希表中，即可保证不会让 x 和自己匹配。
 
 */


-(int *)twoSum:(int*)nums
          size:(int)numsSize
        target:(int)target
    returnSize:(int*) returnSize{
    //以字典当做哈希
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    for (int i=0; i<numsSize; i++) {
        int cmp=target-nums[i];
        NSString *key=@(cmp).stringValue;
        if ([dict.allKeys containsObject:key]) {
            int index=[dict[key] intValue];
            int *arr=(int *)malloc(sizeof(int)*2);
            arr[0]=index;
            arr[1]=i;
            return arr;
        }else{
            dict[key]=@(nums[i]);
        }
    }
    return NULL;
}



//struct hashTable {
//    int key;
//    int val;
//    UT_hash_handle hh;
//};
//
//struct hashTable* hashtable;
//
//struct hashTable* find(int ikey) {
//    struct hashTable* tmp;
//    HASH_FIND_INT(hashtable, &ikey, tmp);
//    return tmp;
//}
//
//void insert(int ikey, int ival) {
//    struct hashTable* it = find(ikey);
//    if (it == NULL) {
//        struct hashTable* tmp = malloc(sizeof(struct hashTable));
//        tmp->key = ikey, tmp->val = ival;
//        HASH_ADD_INT(hashtable, key, tmp);
//    } else {
//        it->val = ival;
//    }
//}
//int* twoSum(int* nums, int numsSize, int target, int* returnSize) {
//    hashtable = NULL;
//    for (int i = 0; i < numsSize; i++) {
//        struct hashTable* it = find(target - nums[i]);
//        if (it != NULL) {
//            int* ret = malloc(sizeof(int) * 2);
//            ret[0] = it->val, ret[1] = i;
//            *returnSize = 2;
//            return ret;
//        }
//        insert(nums[i], i);
//    }
//    *returnSize = 0;
//    return NULL;
//}


void twoSumTest(){
    int arr[]={2,7,11,15};
    int returnSize=0;
    int *result=twoSum(arr, 4, 9, &returnSize);
    if (result) {
        printf("%d %d\n",result[0], result[1]);
        free(result);
    }else{
        printf(" null \n");
    }
}

@end
