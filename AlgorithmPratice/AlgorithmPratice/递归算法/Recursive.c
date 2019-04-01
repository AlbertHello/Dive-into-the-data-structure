//
//  Recursive.c
//  AlgorithmPratice
//
//  Created by 王启正 on 2019/3/29.
//  Copyright © 2019 隔壁老王. All rights reserved.
//

#include "Recursive.h"
//栈的很重要的一个应用：递归
//举例1、
//1+2+3+。。。100
//循环写法
void normalAlgorithm(){
    int sum=0;
    for (int i=1; i<=100; i++) {
        sum+=i;
    }
    printf("result = %d\n",sum);
}
//递归写法
int sumInRecursive(int num){
    if (num==1) {
        return 1;
    }else{
        return sumInRecursive(num-1)+num;
    }
}
//举例2、
//经典递归案例-斐波那契数列
//兔子出生两个月后有繁殖能力，一对兔子每个月生出一对小兔子，假设所有兔子不死，那么一年后有多少对兔子。
//月份 1  2   3   4   5   6   7   8   9   10  11  12
//对数 1  1   2   3   5   8   13  21  34  55  89  144
//很明显前两项之和构成了后一项，则通项公式：f(n)=f(n-1)+f(n-2), n>1

//常规写法，循环迭代
void normalFbi(){
    int i;
    int a[12];
    a[0]=0;
    a[1]=1;
    printf("%d ",a[0]);
    printf("%d ",a[1]);
    for (i=2; i<12; i++) {
        a[i]=a[i-1]+a[i-2];
        printf("%d ",a[i]);
    }
}
//递归写法
int recursiveFbi(int i){
    if (i<2) {
        return i==0 ? 0 : 1;
    }else{
        return recursiveFbi(i-1)+recursiveFbi(i-2);
    }
}
void callRecursiveFbi(){
    int i;
    for (i=0; i<12; i++) {
        printf("%d ",recursiveFbi(i));
    }
}
//迭代和递归的区别：
//迭代使用的是循环结构，递归使用的是选择结构，递归能是程序的结构更清晰，更简洁，减少阅读代码得时间，但是大量的递归调用会建立函数副本，会耗费大量的时间和内存。迭代，则不需要反复的调用函数和占用额外的内存，应视不同情况选择不同的代码实现方式。




