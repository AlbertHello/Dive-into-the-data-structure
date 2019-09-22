//
//  ViewController.m
//  队列
//
//  Created by 58 on 2019/9/21.
//  Copyright © 2019 58. All rights reserved.
//

#import "ViewController.h"
#include "Queue.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor redColor];
    
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
