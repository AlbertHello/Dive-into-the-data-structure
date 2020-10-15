//
//  ViewController.m
//  队列
//
//  Created by 58 on 2019/9/21.
//  Copyright © 2019 58. All rights reserved.
//

#import "ViewController.h"
#include "Queue.h"
#include "DoubleEndedQueue.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor redColor];
    
//    [self queueTest];
    [self d_queueTest];
    
}
-(void)d_queueTest{
    doubleEndedQueue_enQueueRear(1);
    doubleEndedQueue_enQueueRear(2);
    doubleEndedQueue_enQueueFront(3);
    doubleEndedQueue_enQueueFront(4);
    
    doubleEndedQueue_print();
    
    int ele1 = doubleEndedQueue_front();
    printf("此时对头元素是:%d\n",ele1);
    int ele2 = doubleEndedQueue_rear();
    printf("此时队尾元素是:%d\n",ele2);
    
    //队头队尾各出队
    doubleEndedQueue_deQueueRear();
    doubleEndedQueue_deQueueFront();
    
    int el3 = doubleEndedQueue_front();
    printf("此时对头元素是:%d\n",el3);
    int ele4 = doubleEndedQueue_rear();
    printf("此时队尾元素是:%d\n",ele4);
    
    doubleEndedQueue_print();
    
    doubleEndedQueue_clear();
}



-(void)queueTest{
    enQueue(20);
    enQueue(30);
    enQueue(40);
    enQueue(50);
    
    printQueue();
    
    deQueue();
    printQueue();
    int data=front();
    printf("此时对头元素是:%d\n",data);
    
    int length=size();
    printf("此时队列长度是:%d\n",length);
    
    clear();
}


@end
