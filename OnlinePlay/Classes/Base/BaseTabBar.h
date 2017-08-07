//
//  BaseTabBar.h
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/17.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseTabBar;

@protocol BaseTabBarDelegate <UITabBarDelegate>

- (void)tabBarDidClickPlusButton:(BaseTabBar *)tabBar;

@end

@interface BaseTabBar : UITabBar

@property (nonatomic, weak) id<BaseTabBarDelegate> tabbarDelegate;

@end
