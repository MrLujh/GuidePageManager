//
//  TBMessageViewController.m
//  GuidePageExample
//
//  Created by lujh on 2017/4/19.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "TBMessageViewController.h"

@interface TBMessageViewController ()

@end

@implementation TBMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"M" object:nil];
}

@end
