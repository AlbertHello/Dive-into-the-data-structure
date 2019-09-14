//
//  ViewController.m
//  栈
//
//  Created by 王启正 on 2019/9/13.
//  Copyright © 2019 58. All rights reserved.
//

#import "ViewController.h"
#include "Stack.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor=[UIColor redColor];
    
    push(10);
    push(11);
    push(12);
    push(13);
    push(14);
    
    
    peek();
    
    print_stack();
    
    
}


@end
