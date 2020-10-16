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
#include "CircleQueue.h"
#include "CircleDoubleEndedQueue.h"




@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor redColor];
    

    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self queueTest];
//    [self d_queueTest];
    [self c_queueTest];
//    [self c_d_queueTest];
}
-(void)c_d_queueTest{
    // 头 8 7 6  5 4 3 2 1  100 101 102 103 104 105 106 107 108 109 null null 10 9 尾
    for (int i = 0; i < 10; i++) {
        circle_d_queue_enQueueFront(i+1);
        circle_d_queue_enQueueRear(i+100);
    }
    circle_d_queue_print();
    // 头 null 7 6  5 4 3 2 1  100 101 102 103 104 105 106 null null null null null null null 尾
    for (int i = 0; i < 3; i++) {
        circle_d_queue_deQueueFront();
        circle_d_queue_deQueueRear();
    }
    circle_d_queue_print();
    // 头 11 7 6  5 4 3 2 1  100 101 102 103 104 105 106 null null null null null null 12 尾
    circle_d_queue_enQueueFront(11);
    circle_d_queue_enQueueFront(12);
    circle_d_queue_print();
}
-(void)c_queueTest{
    // 1 2 3 4 5 6 7 8 9 10
    for (int i = 0; i < 10; i++) {
        circle_queue_enQueue(i+1);
    }
    circle_queue_print();
    // null null null null null 6 7 8 9 10
    for (int i = 0; i < 5; i++) {
        circle_queue_deQueue();
    }
    circle_queue_print();
    // 15 16 17 18 19 6 7 8 9 10
    for (int i = 15; i < 20; i++) {
        circle_queue_enQueue(i);
    }
    circle_queue_print();
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
