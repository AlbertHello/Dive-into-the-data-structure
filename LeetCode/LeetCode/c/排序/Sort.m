//
//  Sort.m
//  LeetCode
//
//  Created by Albert on 2020/10/25.
//

#import "Sort.h"

@implementation Sort


-(int)cmp:(int)v1 to:(int)v2{
    self.cmpCount++;
    return v1-v2;
}
-(void)swap:(int *) v1 with:(int *) v2{
    self.swapCount++;
    int temp= *v1;
    *v1=*v2;
    *v2=temp;
}

@end
