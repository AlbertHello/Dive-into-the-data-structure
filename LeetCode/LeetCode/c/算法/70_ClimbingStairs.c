//
//  70_ClimbingStairs.c
//  LeetCode
//
//  Created by 58 on 2020/10/15.
//

#include "70_ClimbingStairs.h"
#include <math.h>


/**
 70. 爬楼梯  其实也是斐波那契梳理
 假设你正在爬楼梯。需要 n 阶你才能到达楼顶。

 每次你可以爬 1 或 2 个台阶。你有多少种不同的方法可以爬到楼顶呢？

 注意：给定 n 是一个正整数。
 Example 1:

 Input: 2
 Output: 2
 Explanation: There are two ways to climb to the top.
 1. 1 step + 1 step
 2. 2 steps
 Example 2:

 Input: 3
 Output: 3
 Explanation: There are three ways to climb to the top.
 1. 1 step + 1 step + 1 step
 2. 1 step + 2 steps
 3. 2 steps + 1 step
  

 Constraints:

 1 <= n <= 45

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/climbing-stairs
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

//第一种思路
//如果观察数学规律，可知本题是斐波那契数列，那么用斐波那契数列的公式即可解决问题
//n =   1   2   3   4   5   6   7
//c =   1   2   3   5   8   13  21
//下面的就是斐波那契数列：这个数列从第3项开始，每一项都等于前两项之和。



//1、递归实现
//效率很低。当n>40时就开始出现需要长时间计算才能算出来的情况。
//n 比较小的时候，可以直接使用过递归法求解，不做任何记忆化操作，时间复杂度是O(2^n)，存在很多冗余计算。
int fib(int x){
    if(x == 1) return 1;
    if(x == 2) return 1;
    return fib(x-1) + fib(x-2);
}


//2、迭代（动态规划）
//时间复杂度：循环执行n 次，每次花费常数的时间代价，故渐进时间复杂度为O(n)。
//空间复杂度：这里只用了常数个变量作为辅助空间，故渐进空间复杂度为O(1)。
//用「滚动数组思想」把空间复杂度优化成O(1)
int fib2(int n){
    int first =1;
    int second=1;
//    具体原理就是第一个数加上第二个数就等于第三个数
    for (int i=0; i< n-1; i++) {
        int sum = first + second;
        //往下遍历是第一个数就变为了第二个数
        first=second;
        //第二个数就变为了刚才相加的和
        second=sum;
    }
    return second;
}
//3、 公式法：
//时间复杂度：O(logn)，pow 方法将会用去O(logn) 的时间。
//空间复杂度：O(1)。
int fib3(int n){
    double sqrt5 = sqrt(5);
    double fibn = pow((1 + sqrt5) / 2, n + 1) - pow((1 - sqrt5) / 2, n + 1);
    return (int)(fibn / sqrt5);
}
//4、矩阵快速幂



int climbStairs(int n){
    if (n==1) return 1;
    if (n==2) return 2;
    return fib3(n);
}

void climbStairsTest(){
    int res = climbStairs(30);
    printf("res = %d\n" , res);
}




