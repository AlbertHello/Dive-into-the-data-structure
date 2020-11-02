//
//  66_Plus_One.m
//  LeetCode
//
//  Created by 58 on 2020/11/2.
//

#import "66_Plus_One.h"

@implementation _6_Plus_One

/**
 66. 加一
 给定一个由整数组成的非空数组所表示的非负整数，在该数的基础上加一。

 最高位数字存放在数组的首位， 数组中每个元素只存储单个数字。

 你可以假设除了整数 0 之外，这个整数不会以零开头。

 示例 1:

 输入: [1,2,3]
 输出: [1,2,4]
 解释: 输入数组表示数字 123。
 示例 2:

 输入: [4,3,2,1]
 输出: [4,3,2,2]
 解释: 输入数组表示数字 4321。
 
 Example 3:

 Input: digits = [0]
 Output: [1]
  

 Constraints:

 1 <= digits.length <= 100
 0 <= digits[i] <= 9

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/plus-one
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 
 **/

-(NSArray *)plusOne:(NSMutableArray *)array{
    int first = [array.firstObject intValue];
    if (first == 0) return @[@1];
    for (int i = array.count - 1; i >= 0; i--) {
        int num = [array[i] intValue];
        num+=1;
        array[i] = @(num % 10);
        //没有进位了就可以直接返回了
        if ([array[i] intValue] != 0) return array;
    }
    //这是处理类似于9 99 999 9999这样的数组
    NSMutableArray *aaa=[NSMutableArray arrayWithCapacity:array.count+1];
    aaa[0] = @1;//只有第一个是1，其他位置的默认是0
    return aaa;
    
}

int* plusOne(int* digits, int digitsSize, int* returnSize){
    
    for (int i = digitsSize - 1; i >= 0; i--) {
        //最后一位加一
        digits[i]++;
        //然后求余
        digits[i] = digits[i] % 10;
        //没有进位了就可以直接返回了
        if (digits[i] != 0){ //如果求余后还不等于0说明没有进位，久可以直接返回了。
            *returnSize=digitsSize;
            return digits;
        }
    }
    //这是处理类似于9 99 999 9999这样的数组
    int *array=(int *)malloc(sizeof(int)*(digitsSize + 1));
    memset(array, 0, digitsSize + 1);
    array[0] = 1;//只有第一个是1，其他位置的默认是0
    *returnSize=digitsSize + 1;
    return array;
}
+(void)plusOneTest{
    int a[]={9};
    int size=0;
    int *arr=plusOne(a, 1, &size);
    for (int i=0; i<size; i++) {
        printf("%d ",arr[i]);
    }
    printf("\n");
}
@end
