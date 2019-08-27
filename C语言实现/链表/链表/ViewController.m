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
    Link head_ptr = NULL;//头指针
    Status ret = init_link(&head_ptr);
    if (ret!=Success) {
        printf("linklist init error \n");
    }
    if (is_empty(head_ptr)) {
        NSLog(@"链表为空");
    }else{
        NSLog(@"链表不是空");
    }
    NSLog(@"此时链表长度：%d",get_link_length());
    
    //追加元素
    insert_element(20,head_ptr);
    insert_element(30,head_ptr);
    insert_element(50,head_ptr);
    insert_element(60,head_ptr);
    insert_element(70,head_ptr);
    insert_element(80,head_ptr);
    printLink(head_ptr);
    //在指定位置添加元素
    if(insert_element_at_index(40,0, head_ptr)){
        printLink(head_ptr);
    }
    //删除
    int data=0;
    if(delete_element(0, &data, head_ptr)){
        printLink(head_ptr);
        NSLog(@"删除的元素是：%d",data);
    }

    //根据index查找ele
    Link node;
    if(node_of_index(0, head_ptr, &node)){
        NSLog(@"查找的第0个节点元素是：%d 地址是：%p",node->data,node);
    }

    //修改指定位置元素
    if(update_ele(6, 90, head_ptr)){
        NSLog(@"第6个节点元素被修改后是：%d 地址是：%p",node->data,node);
        printLink(head_ptr);
    }
   
    
    //根据元素查找下标
    int index=locate_ele_with_element(30, head_ptr);
    NSLog(@"30是在第%d个节点",index+1);
    int index1=locate_ele_with_element(55, head_ptr);
    if (index1==-1) {
        NSLog(@"链表中没有元素是55的节点");
    }

    clearLink(head_ptr);
    if (is_empty(head_ptr)) {
        NSLog(@"链表为空");
    }else{
        NSLog(@"链表不是空");
    }
    NSLog(@"此时链表长度：%d",get_link_length());
}





@end
