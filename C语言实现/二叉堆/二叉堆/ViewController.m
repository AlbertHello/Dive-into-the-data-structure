//
//  ViewController.m
//  二叉堆
//
//  Created by 58 on 2020/10/27.
//

#import "ViewController.h"
#import "BinaryHeap.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor redColor];
    
//    [self test3];
    [self test4];

}
-(void)test1{
    BinaryHeap *heap=[[BinaryHeap alloc]init];
    [heap add:68];
    [heap add:43];
    [heap add:50];
    [heap add:38];
    [heap add:72];
    [heap add:69];
    [heap add:91];
    [heap add:35];
    [heap printHeap];
    [heap removeEle];
    [heap printHeap];
}
//批量建堆
-(void)test2{
    BinaryHeap *heap=[[BinaryHeap alloc]init];
    NSArray *arrrrr=@[@(88), @(44), @(53), @(41), @(16), @(6), @(70), @(18), @(85), @(98), @(81), @(23), @(36), @(43), @(37)];
    [heap heapifyWith:arrrrr];
    [heap printHeap];
}
//小堆
-(void)test3{
    BinaryHeap *heap=[[BinaryHeap alloc]init];
    heap.bigHeap=NO;
    NSArray *arrrrr=@[@(88), @(44), @(53), @(41), @(16), @(6), @(70), @(18), @(85), @(98), @(81), @(23), @(36), @(43), @(37)];
    [heap heapifyWith:arrrrr];
    [heap printHeap];
}

//面试题
//在大量数据中找出最大的前k个数
//采用小顶堆
-(void)test4{
    int k=5;
    BinaryHeap *heap=[[BinaryHeap alloc]init];
    heap.bigHeap=NO;//小顶堆
    NSArray *arrrrr=@[@(88), @(44), @(53), @(41), @(16), @(6), @(70), @(18), @(85), @(98), @(81), @(23), @(36), @(43), @(37)];
    for (int i=0; i<arrrrr.count; i++) {
        if ([heap size] < k) {
            //把先遍历到的前k个数按照小顶堆逻辑添加到二叉堆
            //那么[heap getElement]堆定元素最小
            [heap add:[arrrrr[i] intValue]];
        }else{
            NSNumber *num=arrrrr[i];
            //然后拿后面的每个数跟对顶元素比较，如果大于堆顶元素，则替换
            //最后剩下的都是最大的几个数
            if (num.intValue > [heap getElement]) {
                [heap replace:num.intValue];
            }
        }
    }
    [heap printHeap];
}


@end
