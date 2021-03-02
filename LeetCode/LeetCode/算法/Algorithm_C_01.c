//
//  Algorithm_C_01.c
//  LeetCode
//
//  Created by 58 on 2021/3/2.
//

#include "Algorithm_C_01.h"

int g_num = 1;
pthread_mutex_t mutex;
pthread_cond_t cond1,cond2;

void* thread1(void* arg){
    while(1){
        pthread_mutex_lock(&mutex);
        //如果需要交替打印一定范围(例如1-10)内的数字，那么可以加上下面两行代码
        if(g_num > 10) exit(1);
        printf("Thread1: %d \n",g_num);
        g_num ++;
        pthread_cond_signal(&cond2); // 通知另外一个线程
        pthread_cond_wait(&cond1,&mutex); // 本线程等待
        pthread_mutex_unlock(&mutex);
        sleep(1);
    }
    return NULL;
}

void* thread2(void* arg)
{
    while(1)
    {
        //这个sleep(1)加在前面是因为开启线程时有可能是线程2先打印，
        //导致变成thread2输出奇数，threa1输出偶数。为了避免这种情况，可以在延迟下线程2的打印。
        sleep(1);// 也可以放在后面，这样一来程序跑起来thread1和thread2方法几乎同时被调用。之后便每秒间隔调用
        pthread_mutex_lock(&mutex);
        printf("Thread2: %d \n",g_num);
        g_num++;
        pthread_cond_signal(&cond1);
        pthread_cond_wait(&cond2,&mutex);
        pthread_mutex_unlock(&mutex);
        
    }
    return NULL;
}

void test01(){
    pthread_t p1,p2;
    
    pthread_mutex_init(&mutex,NULL);
    pthread_cond_init(&cond1,NULL);
    pthread_cond_init(&cond2,NULL);
    
    pthread_create(&p1,NULL,thread1,NULL);
    pthread_create(&p2,NULL,thread2,NULL);
    
    pthread_join(p1,NULL);
    pthread_join(p2,NULL);
    
    pthread_mutex_destroy(&mutex);
    pthread_cond_destroy(&cond1);
    pthread_cond_destroy(&cond2);
}

