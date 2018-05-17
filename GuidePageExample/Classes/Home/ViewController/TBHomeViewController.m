
//
//  TBHomeViewController.m
//  GuidePageExample
//
//  Created by 卢家浩 on 2017/4/17.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "TBHomeViewController.h"
#import "TBMessageViewController.h"

@interface TBHomeViewController ()

@end

@implementation TBHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"TBHomeViewController");
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MS) name:@"M" object:nil];
    
    [self setCustomerTitle:@"首页"];
    
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(0, 0, 50, 50);
    btn.layer.cornerRadius = 25;
    btn.layer.masksToBounds = YES;
    btn.center = self.view.center;
    [btn setTitle:@"测试" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor cyanColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)MS {

    self.tabBarItem.badgeValue = nil;
    
}

- (void)btnClick {
    
    TBMessageViewController *messageVC = [[TBMessageViewController alloc] init];
    [self.navigationController pushViewController:messageVC animated:YES];
}

@end
