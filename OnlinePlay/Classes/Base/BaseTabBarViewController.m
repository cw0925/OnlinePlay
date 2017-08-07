//
//  BaseTabBarViewController.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/17.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "BaseTabBar.h"
#import "BaseNavigationViewController.h"
#import "HomeViewController.h"
#import "NearViewController.h"
#import "AttentionViewController.h"
#import "MyViewController.h"
#import "UIButton+ImageAndTitle.h"

@interface BaseTabBarViewController ()<BaseTabBarDelegate>

@end

@implementation BaseTabBarViewController
{
    UIView *view;
    UIView *maskView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 初始化子控制器
    HomeViewController *home = [[HomeViewController alloc]init];
    [self addChildViewController:home title:@"首页" image:@"tab_live" selectedImage:@"tab_live_p"];
    
    NearViewController *near = [[NearViewController alloc]init];
    [self addChildViewController:near title:@"附近" image:@"tab_near" selectedImage:@"tab_near_p"];
    
    AttentionViewController *news = [[AttentionViewController alloc]init];
    [self  addChildViewController:news title:@"关注" image:@"tab_following" selectedImage:@"tab_following_p"];
    
    MyViewController *mine = [[MyViewController alloc ]init];
    
    [self addChildViewController:mine title:@"我" image:@"tab_me" selectedImage:@"tab_me_p"];
    
    BaseTabBar *tabBar = [[BaseTabBar alloc]init];
    tabBar.tabbarDelegate = self;
    [self setValue:tabBar forKey:@"tabBar"];
}
-(void)addChildViewController:(UIViewController *)childController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    
    //childController.title = title;
    childController.tabBarItem.title = title;
    childController.tabBarItem.image = [UIImage imageNamed:image];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSDictionary *dicNor = @{
                            NSForegroundColorAttributeName:RGBColor(155, 155, 155)
                             
                             };
    [childController.tabBarItem setTitleTextAttributes:dicNor forState:UIControlStateNormal];
    
    NSDictionary *dicSelected = @{
                                  NSForegroundColorAttributeName:RGBColor(0, 223, 205)
                                  
                                  };
    
    [childController.tabBarItem setTitleTextAttributes:dicSelected forState:UIControlStateSelected];
    // 先把外面传进来的控制器包装成一个导航控制器
    BaseNavigationViewController *mainNav = [[BaseNavigationViewController alloc ]initWithRootViewController:childController];
    // 添加子控制器
    [self addChildViewController:mainNav];
}
#pragma mark - CLTabBarDelegate代理方法
- (void)tabBarDidClickPlusButton:(BaseTabBar *)tabBar{
    maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    maskView.backgroundColor = RGBAColor(0, 0, 0, 0.2);
    [self.view addSubview:maskView];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeClick:)];
    maskView.userInteractionEnabled = YES;
    [maskView addGestureRecognizer:gesture];
    
    view = [[UIView alloc]initWithFrame:CGRectMake(0, ViewHeight-250, ViewWidth, 250)];
    view.backgroundColor = [UIColor whiteColor];
    [maskView addSubview:view];
    
    UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    playBtn.frame = CGRectMake(0, 0, ViewWidth/2, 200);
    [playBtn setTitle:@"直播" forState:UIControlStateNormal];
    [playBtn setImage:[UIImage imageNamed:@"shortvideo_main_live"] forState:UIControlStateNormal];
    [playBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    playBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [playBtn verticalImageAndTitle:0];
    [view addSubview:playBtn];
    
    UIButton *videoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    videoBtn.frame = CGRectMake(ViewWidth/2, 0, ViewWidth/2, 200);
    [videoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [videoBtn setTitle:@"小视频" forState:UIControlStateNormal];
    [videoBtn setImage:[UIImage imageNamed:@"shortvideo_main_video"] forState:UIControlStateNormal];
    videoBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [videoBtn verticalImageAndTitle:0];
    [view addSubview:videoBtn];
    
    UIButton *disBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    disBtn.frame = CGRectMake(ViewWidth/2-25, 250-50, 50, 50);
    [disBtn setBackgroundImage:[UIImage imageNamed:@"shortvideo_launch_close"] forState:UIControlStateNormal];
    [disBtn addTarget:self action:@selector(dismissClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:disBtn];
}
- (void)removeClick:(UIButton *)sender{
    [maskView removeFromSuperview];
}
- (void)dismissClick:(UIButton *)sender{
    [view removeFromSuperview];
    [maskView removeFromSuperview];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
