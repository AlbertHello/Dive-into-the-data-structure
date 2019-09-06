//
//  ViewController.m
//  Demo
//
//  Created by 58 on 2019/6/26.
//  Copyright © 2019 58. All rights reserved.
//

#import "ViewController.h"
#include "SingleLink.h"
#include "CircleSingleLink.h"
#include "DoubleLink.h"
#include "CircleDoubleLink.h"




@interface ViewController ()

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor=[UIColor redColor];
    
    //单链表
//    [self testSingleLink];
    //单向循环链表
//    [self testCircleSingleLink];
    //双向链表
//    [self testDoubleLink];
    //双向循环链表
    [self testCircleDoubleLink];
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

-(void)testCircleSingleLink{
    CircleSingleLink head_ptr = NULL;//头指针
     Status ret = circleSingleLink_init_link(&head_ptr);
     if (ret!=Success) {
         printf("linklist init error \n");
     }
     if (circleSingleLink_is_empty(head_ptr)) {
         NSLog(@"链表为空");
     }else{
         NSLog(@"链表不是空");
     }
     NSLog(@"此时链表长度：%d",circleSingleLink_get_link_length());
     
     //追加元素
     circleSingleLink_insert_element(20,head_ptr);
     circleSingleLink_insert_element(30,head_ptr);
     circleSingleLink_insert_element(50,head_ptr);
     circleSingleLink_insert_element(60,head_ptr);
     circleSingleLink_insert_element(70,head_ptr);
     circleSingleLink_insert_element(80,head_ptr);
     circleSingleLink_printLink(head_ptr);
     //在指定位置添加元素
     if(circleSingleLink_insert_element_at_index(40,0, head_ptr)){
         circleSingleLink_printLink(head_ptr);
     }
     //删除
     int data=0;
     if(circleSingleLink_delete_element(0, &data, head_ptr)){
         circleSingleLink_printLink(head_ptr);
         NSLog(@"删除的元素是：%d",data);
     }

     //根据index查找ele
     CircleSingleLink node;
     if(circleSingleLink_node_of_index(6, head_ptr, &node)==Error){
         NSLog(@"查找第7个节点元素时越界");
     }

     //修改指定位置元素
     if(circleSingleLink_update_ele(5, 90, head_ptr)== Success){
         NSLog(@"第6个节点元素被修改成功");
         circleSingleLink_print_node_at_index(head_ptr,5);
     }
    
     //根据元素查找下标
     int index=circleSingleLink_locate_ele_with_element(30, head_ptr);
     NSLog(@"30是在第%d个节点",index+1);
     int index1=circleSingleLink_locate_ele_with_element(55, head_ptr);
     if (index1==-1) {
         NSLog(@"链表中没有元素是55的节点");
     }

     circleSingleLink_clearLink(head_ptr);
     if (circleSingleLink_is_empty(head_ptr)) {
         NSLog(@"链表为空");
     }else{
         NSLog(@"链表不是空");
     }
     NSLog(@"此时链表长度：%d",circleSingleLink_get_link_length());
}

-(void)testDoubleLink{
    DoubleLink head_ptr = NULL;//头指针
     Status ret = doubleLinkNode_init_link(&head_ptr);
     if (ret!=Success) {
         printf("linklist init error \n");
     }
     if (doubleLinkNode_is_empty(head_ptr)) {
         NSLog(@"双向链表为空");
     }else{
         NSLog(@"双向链表不是空");
     }
     NSLog(@"此时双向链表长度：%d",get_link_length());
     
     //追加元素
     doubleLinkNode_insert_element(20,head_ptr);
     doubleLinkNode_insert_element(30,head_ptr);
     doubleLinkNode_insert_element(50,head_ptr);
     doubleLinkNode_insert_element(60,head_ptr);
     doubleLinkNode_insert_element(70,head_ptr);
     doubleLinkNode_insert_element(80,head_ptr);
     doubleLinkNode_printLink(head_ptr);
     //在指定位置添加元素
     if(doubleLinkNode_insert_element_at_index(40,0, head_ptr)){
         doubleLinkNode_printLink(head_ptr);
     }
     //删除
     int data=0;
     if(doubleLinkNode_delete_element(0, &data, head_ptr)){
         NSLog(@"删除的元素是：%d",data);
         doubleLinkNode_printLink(head_ptr);
     }

     //根据index查找ele
     DoubleLink node;
     if(doubleLinkNode_node_of_index(0, head_ptr, &node)){
         NSLog(@"查找的第0个节点元素是：%d 地址是：%p",node->data,node);
     }

     //修改指定位置元素
     if(doubleLinkNode_update_ele(6, 90, head_ptr)){
         NSLog(@"修改第7个节点元素越界");
     }else{
         if(doubleLinkNode_update_ele(5, 90, head_ptr)){
             NSLog(@"第6个节点元素被修改为90");
             doubleLinkNode_printLink(head_ptr);
         }
     }
     //根据元素查找下标
     int index=doubleLinkNode_locate_ele_with_element(30, head_ptr);
     NSLog(@"30是在第%d个节点",index+1);
     int index1=doubleLinkNode_locate_ele_with_element(55, head_ptr);
     if (index1==-1) {
         NSLog(@"链表中没有元素是55的节点");
     }

     doubleLinkNode_clearLink(head_ptr);
     if (doubleLinkNode_is_empty(head_ptr)) {
         NSLog(@"链表为空");
     }else{
         NSLog(@"链表不是空");
     }
     NSLog(@"此时链表长度：%d",doubleLinkNode_get_link_length());
}

-(void)testCircleDoubleLink{
    CircleDoubleLink head_ptr = NULL;//头指针
    Status ret = circleDoubleLinkNode_init_link(&head_ptr);
    if (ret!=Success) {
        printf("linklist init error \n");
    }
    if (circleDoubleLinkNode_is_empty(head_ptr)) {
        NSLog(@"双向循环链表为空");
    }else{
        NSLog(@"双向循环链表不是空");
    }
    NSLog(@"此时双向循环链表长度：%d",get_link_length());
    
    //追加元素
    circleDoubleLinkNode_insert_element(20,head_ptr);
    circleDoubleLinkNode_insert_element(30,head_ptr);
    circleDoubleLinkNode_insert_element(50,head_ptr);
    circleDoubleLinkNode_insert_element(60,head_ptr);
    circleDoubleLinkNode_insert_element(70,head_ptr);
    circleDoubleLinkNode_insert_element(80,head_ptr);
    circleDoubleLinkNode_printLink(head_ptr);
    //在指定位置添加元素
    if(circleDoubleLinkNode_insert_element_at_index(40,0, head_ptr)){
        circleDoubleLinkNode_printLink(head_ptr);
    }
    //删除
    int data=0;
    if(circleDoubleLinkNode_delete_element(0, &data, head_ptr)){
        NSLog(@"删除的元素是：%d",data);
        circleDoubleLinkNode_printLink(head_ptr);
    }
    
    //根据index查找ele
    CircleDoubleLink node;
    if(circleDoubleLinkNode_node_of_index(0, head_ptr, &node)){
        NSLog(@"查找的第0个节点元素是：%d 地址是：%p",node->data,node);
    }
    
    //修改指定位置元素
    if(circleDoubleLinkNode_update_ele(6, 90, head_ptr)){
        NSLog(@"修改第7个节点元素越界");
    }else{
        if(circleDoubleLinkNode_update_ele(5, 90, head_ptr)){
            NSLog(@"第6个节点元素被修改为90");
            circleDoubleLinkNode_printLink(head_ptr);
        }
    }
    //根据元素查找下标
    int index=circleDoubleLinkNode_locate_ele_with_element(30, head_ptr);
    NSLog(@"30是在第%d个节点",index+1);
    int index1=circleDoubleLinkNode_locate_ele_with_element(55, head_ptr);
    if (index1==-1) {
        NSLog(@"双向循环链表中没有元素是55的节点");
    }
    
    circleDoubleLinkNode_clearLink(head_ptr);
    if (circleDoubleLinkNode_is_empty(head_ptr)) {
        NSLog(@"双向循环链表为空");
    }else{
        NSLog(@"双向循环链表不是空");
    }
    NSLog(@"此时双向循环链表长度：%d",circleDoubleLinkNode_get_link_length());
}



@end
