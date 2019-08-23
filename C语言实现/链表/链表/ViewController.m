//
//  ViewController.m
//  Demo
//
//  Created by 58 on 2019/6/26.
//  Copyright © 2019 58. All rights reserved.
//

#import "ViewController.h"
#include "SingleLink.h"





@interface ViewController ()

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor=[UIColor redColor];
    
    //单链表
    [self testSingleLink];
    
}

-(void)testSingleLink{
    Link head;//头指针
    Status ret = init_link(&head);
    if (ret!=Success) {
        printf("linklist init error \n");
    }
    
    insert_element(20,head);
    insert_element(30,head);
    insert_element(50,head);
    insert_element(60,head);
    insert_element(70,head);
    insert_element(80,head);
    printLink(head);
    insert_element_at_index(40, 2, head);
    printLink(head);
    //删除
    int data;
    delete_element(2, &data, head);
    printLink(head);
    
    //根据index查找ele
    Link node;
    node_of_index(4, head, &node);
    printf("查找的第四个元素是：%d\n",node->data);
    
    //修改
    update_ele(5, 90, head);
    printLink(head);
    
    //查找
    int index=locate_ele_with_element(30, head);
    printf("30是在第%d个节点\n",index+1);
    int index1=locate_ele_with_element(55, head);
    printf("55是在第%d个节点\n",index1);
    
    clearLink(head);
}





@end
