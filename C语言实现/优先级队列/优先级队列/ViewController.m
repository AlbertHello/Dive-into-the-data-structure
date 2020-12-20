//
//  ViewController.m
//  优先级队列
//
//  Created by Albert on 2020/12/20.
//

#import "ViewController.h"
#import "PriorityQueue.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor redColor];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self test];
}

// 自定义比较器
int myComparator(int first,int second){
    return first - second;
}
-(void)test{
    PriorityQueue *pq=[[PriorityQueue alloc]initWith:myComparator];
    [pq enQueue:68];
    [pq enQueue:43];
    [pq enQueue:50];
    [pq enQueue:38];
    [pq enQueue:72];
    [pq enQueue:69];
    [pq enQueue:91];
    [pq enQueue:35];
    [pq printPQ];
}

@end
