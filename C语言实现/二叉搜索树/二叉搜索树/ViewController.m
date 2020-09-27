//
//  ViewController.m
//  二叉搜索树
//
//  Created by 王启正 on 2019/9/17.
//  Copyright © 2019 58. All rights reserved.
//

#import "ViewController.h"
#include "BinarySearchTree.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor brownColor];
    
    
    [self testLowestCommonAncestor];
    
    
}

-(void)testLowestCommonAncestor{
    int num[]={6,2,8,0,4,7,9,3,5};
    int length=sizeof(num)/sizeof(int);
    for (int i = 0;i<length; i++) {
        add(num[i]);
    }
    BinarySearchNode *root=getNode(6);
    BinarySearchNode *p_node=getNode(2);
    BinarySearchNode *q_node=getNode(8);
    BinarySearchNode *ancestor=lowestCommonAncestor(root,
                                                    p_node,
                                                    q_node);
    printf("ancestor is: %d \n",ancestor->data);
}

@end
