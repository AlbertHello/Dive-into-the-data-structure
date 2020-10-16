//
//  ViewController.m
//  动态数组
//
//  Created by 58 on 2020/10/16.
//

#import "ViewController.h"
#include "DynamicArray.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor redColor];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self DynamicArrayTest];
}
-(void)DynamicArrayTest{
    create_dynamic_array_list();
    add(1);
    add(3);
    add(4);
    add(5);
    print_array();
    add_element_at(0, 6);
    print_array();
    
    remove_element(0);
    print_array();
    
    bool con = contains(6);
    
    clear();
    print_array();
    
    add_element_at(0, 9);
    
    print_array();
}


@end
