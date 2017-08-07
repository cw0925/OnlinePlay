//
//  BaseViewController.h
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/17.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

- (void)customNavigationBar:(BOOL)haveLeft leftImage:(NSString *)leftImage right:(BOOL)haveRight rightImage:(NSString *)rightImage;

- (void)leftClick:(UIButton *)sender;
- (void)rightClick:(UIButton *)sender;

@end
