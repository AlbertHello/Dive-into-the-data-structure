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
#include "ReverseLink.h"
#include "141_LinkedListCycle.h"
#include "203_RemoveLinkedListElements.h"





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
//    [self testCircleDoubleLink];
    
    //逆置单链表
//    [self reverseLinkDemo];
    
    
    [self tempTest];
}



-(void)tempTest{
    SingleLink_C *link=(SingleLink_C *)malloc(sizeof(SingleLink_C));
    link->val=5;
    link->next=NULL;
    
    SingleLink_C *node0=(SingleLink_C *)malloc(sizeof(SingleLink_C));
    node0->val=4;
    node0->next=NULL;
//
    SingleLink_C *node1=(SingleLink_C *)malloc(sizeof(SingleLink_C));
    node1->val=3;
    node1->next=NULL;
    
    SingleLink_C *node2=(SingleLink_C *)malloc(sizeof(SingleLink_C));
    node2->val=2;
    node2->next=NULL;
    
    SingleLink_C *node3=(SingleLink_C *)malloc(sizeof(SingleLink_C));
    node3->val=1;
    node3->next=NULL;
    
    SingleLink_C *node4=(SingleLink_C *)malloc(sizeof(SingleLink_C));
    node4->val=1;
    node4->next=NULL;
    
    link->next=node0;
    node0->next=node1;
    node1->next=node2;
    node3->next=node4;
    node4->next=NULL;
    
    
    
//    bool circle = hasCycle(link->next);
    
    SingleLink_C *new_linl =  removeElements(link, 1);
    
    
    NSLog(@"222");
    
}

-(void)testSingleLink{
//    Link head_ptr = NULL;//头指针
//    Status ret = init_link(&head_ptr);
//    if (ret!=Success) {
//        printf("linklist init error \n");
//    }
    
    Link head_ptr = create_link();
    
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
//        printLink(head_ptr);
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
//    CircleSingleLink head_ptr = NULL;//头指针
//     Status ret = circleSingleLink_init_link(&head_ptr);
//     if (ret!=Success) {
//         printf("linklist init error \n");
//     }
//     if (circleSingleLink_is_empty(head_ptr)) {
//         NSLog(@"链表为空");
//     }else{
//         NSLog(@"链表不是空");
//     }
//     NSLog(@"此时链表长度：%d",circleSingleLink_get_link_length());
    
    CircleSingleLink head_ptr = create_single_circle_link();
     
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
    
    DoubleLink d_link=create_double_link();
     
     //追加元素
     doubleLinkNode_insert_element(20,d_link);
     doubleLinkNode_insert_element(30,d_link);
     doubleLinkNode_insert_element(50,d_link);
     doubleLinkNode_insert_element(60,d_link);
     doubleLinkNode_insert_element(70,d_link);
     doubleLinkNode_insert_element(80,d_link);
     doubleLinkNode_printLink(d_link);
     //在指定位置添加元素
     if(doubleLinkNode_insert_element_at_index(40,0, d_link)){
         doubleLinkNode_printLink(d_link);
     }
     //删除
     int data=0;
     if(doubleLinkNode_delete_element(0, &data, d_link)){
         NSLog(@"删除的元素是：%d",data);
         doubleLinkNode_printLink(d_link);
     }

     //根据index查找ele
     DoubleLinkNode node;
     if(doubleLinkNode_node_of_index(0, d_link, &node)){
         NSLog(@"查找的第0个节点元素是：%d 地址是：%p",node->data,node);
     }

     //修改指定位置元素
     if(doubleLinkNode_update_ele(6, 90, d_link)){
         NSLog(@"修改第7个节点元素越界");
     }else{
         if(doubleLinkNode_update_ele(5, 90, d_link)){
             NSLog(@"第6个节点元素被修改为90");
             doubleLinkNode_printLink(d_link);
         }
     }
     //根据元素查找下标
     int index=doubleLinkNode_locate_ele_with_element(30, d_link);
     NSLog(@"30是在第%d个节点",index+1);
     int index1=doubleLinkNode_locate_ele_with_element(55, d_link);
     if (index1==-1) {
         NSLog(@"链表中没有元素是55的节点");
     }

     doubleLinkNode_clearLink(d_link);
     if (doubleLinkNode_is_empty(d_link)) {
         NSLog(@"链表为空");
     }else{
         NSLog(@"链表不是空");
     }
     NSLog(@"此时链表长度：%d",doubleLinkNode_get_link_length(d_link));
}

-(void)testCircleDoubleLink{
    CircleDoubleLink cd_link=create_circle_double_link();
    
    //追加元素
    circleDoubleLinkNode_insert_element(20,cd_link);
    circleDoubleLinkNode_insert_element(30,cd_link);
    circleDoubleLinkNode_insert_element(50,cd_link);
    circleDoubleLinkNode_insert_element(60,cd_link);
    circleDoubleLinkNode_insert_element(70,cd_link);
    circleDoubleLinkNode_insert_element(80,cd_link);
    circleDoubleLinkNode_printLink(cd_link);
    //在指定位置添加元素
    if(circleDoubleLinkNode_insert_element_at_index(40,0, cd_link)){
        circleDoubleLinkNode_printLink(cd_link);
    }
    //删除
    int data=0;
    if(circleDoubleLinkNode_delete_element(0, &data, cd_link)){
        NSLog(@"删除的元素是：%d",data);
        circleDoubleLinkNode_printLink(cd_link);
    }
    
    //根据index查找ele
    CircleDoubleLinkNode node;
    if(circleDoubleLinkNode_node_of_index(0, cd_link, &node)){
        NSLog(@"查找的第0个节点元素是：%d 地址是：%p",node->data,node);
    }
    
    //修改指定位置元素
    if(circleDoubleLinkNode_update_ele(6, 90, cd_link)){
        NSLog(@"修改第7个节点元素越界");
    }else{
        if(circleDoubleLinkNode_update_ele(5, 90, cd_link)){
            NSLog(@"第6个节点元素被修改为90");
            circleDoubleLinkNode_printLink(cd_link);
        }
    }
    //根据元素查找下标
    int index=circleDoubleLinkNode_locate_ele_with_element(30, cd_link);
    NSLog(@"30是在第%d个节点",index+1);
    int index1=circleDoubleLinkNode_locate_ele_with_element(55, cd_link);
    if (index1==-1) {
        NSLog(@"双向循环链表中没有元素是55的节点");
    }
    
    circleDoubleLinkNode_clearLink(cd_link);
    if (circleDoubleLinkNode_is_empty(cd_link)) {
        NSLog(@"双向循环链表为空");
    }else{
        NSLog(@"双向循环链表不是空");
    }
    NSLog(@"此时双向循环链表长度：%d",circleDoubleLinkNode_get_link_length(cd_link));
}

-(void)reverseLinkDemo{
    Link head = NULL;//头节点
    Status ret = init_link(&head);
    if (ret!=Success) {
        printf("linklist init error \n");
        return;
    }
    //追加元素
    insert_element(20,head);
    insert_element(30,head);
    insert_element(50,head);
    insert_element(60,head);
    insert_element(70,head);
    insert_element(80,head);
    printf("链表逆置前 \n");
    printLink(head);
    
    ReverseLinkWithHeadNode(&head);
//    ReverseLinkWithoutHeadNode(&head);
    printf("链表逆置后 \n");
    printLink(head);
    
}

@end
