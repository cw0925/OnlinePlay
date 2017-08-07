//
//  BaseViewController.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/17.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)customNavigationBar:(BOOL)haveLeft leftImage:(NSString *)leftImage right:(BOOL)haveRight rightImage:(NSString *)rightImage{
    if (haveLeft) {
        UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
        left.frame = CGRectMake(0, 0,25, 25);
        [left setBackgroundImage:[UIImage imageNamed:leftImage] forState:UIControlStateNormal];
        [left addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:left];
    }
    if (haveRight) {
        UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
        right.frame = CGRectMake(0, 0, 25, 25);
        [right setBackgroundImage:[UIImage imageNamed:rightImage] forState:UIControlStateNormal];
        [right addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:right];
    }
}
- (void)leftClick:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightClick:(UIButton *)sender{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
