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
    
    add(9);
    add(8);
    add(5);
    add(10);
    add(7);
    add(15);
    add(13);
    add(3);
    add(1);
//    print_tree_preorder();
//    print_tree_inorder();
//    print_tree_backorder();
    print_tree_levelorder();
}


@end
