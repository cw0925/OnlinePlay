//
//  RegisterViewController.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/20.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "RegisterViewController.h"
#import "BaseTabBarViewController.h"
#import "MyHeaderView.h"

@interface RegisterViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *bgimv;
- (IBAction)weiboLogin:(UIButton *)sender;
- (IBAction)weixinLogin:(UIButton *)sender;
- (IBAction)phoneLogin:(UIButton *)sender;
- (IBAction)qqLogin:(UIButton *)sender;

@end

@implementation RegisterViewController
{
    UIImageView *imv1;
    UIImageView *imv2;
    UIImageView *imv3;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    
}
- (void)initUI{
    imv1 = [[UIImageView alloc]initWithFrame:CGRectMake(ViewWidth, 100, 130, 55)];
    imv1.image = [UIImage imageNamed:@"login_bg_cloud_1"];
    [self.bgimv addSubview:imv1];
    
    imv2 = [[UIImageView alloc]initWithFrame:CGRectMake(ViewWidth, 100+100, 78, 42)];
    imv2.image = [UIImage imageNamed:@"login_bg_cloud_2"];
    [self.bgimv addSubview:imv2];
    
    imv3 = [[UIImageView alloc]initWithFrame:CGRectMake(ViewWidth, 100+200, 78, 42)];
    imv3.image = [UIImage imageNamed:@"login_bg_cloud_2"];
    [self.bgimv addSubview:imv3];
    
    [self startAnimation1];
    [self startAnimation2];
    [self startAnimation3];
}
- (void)startAnimation1{
    [UIView animateWithDuration:30 animations:^{
        CGRect rect = imv1.frame;
        rect.origin.x = -130;
        imv1.frame = rect;
    } completion:^(BOOL finished) {
        [imv1 setFrame: CGRectMake(ViewWidth, 100, 130, 55)];
        [self startAnimation1];
    }];
}
- (void)startAnimation2{
    [UIView animateWithDuration:25 animations:^{
        CGRect rect = imv2.frame;
        rect.origin.x = -78;
        imv2.frame = rect;
    } completion:^(BOOL finished) {
        [imv2 setFrame: CGRectMake(ViewWidth, 200, 78, 42)];
        [self startAnimation2];
    }];
}
- (void)startAnimation3{
    [UIView animateWithDuration:20 animations:^{
        CGRect rect = imv3.frame;
        rect.origin.x = -78;
        imv3.frame = rect;
    } completion:^(BOOL finished) {
        [imv3 setFrame: CGRectMake(ViewWidth, 300, 78, 42)];
        [self startAnimation3];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)weiboLogin:(UIButton *)sender {
    [ShareSDK getUserInfo:SSDKPlatformTypeSinaWeibo
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error){
               if (state == SSDKResponseStateSuccess){
                   [userDefault setValue:user.icon forKey:@"icon"];
                   [userDefault setValue:user.nickname forKey:@"nickname"];
                   [userDefault setBool:YES forKey:@"logined"];
                   NSLog(@"nickname=%@",user.nickname);
                   
                   BaseTabBarViewController *root = [[BaseTabBarViewController alloc]init];
                   [UIApplication sharedApplication].keyWindow.rootViewController = root;
               }else{
                   NSLog(@"%@",error);
               }
               
           }];
}

- (IBAction)weixinLogin:(UIButton *)sender {
    [ShareSDK getUserInfo:SSDKPlatformTypeWechat
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error){
               if (state == SSDKResponseStateSuccess){
                   [userDefault setValue:user.icon forKey:@"icon"];
                   [userDefault setValue:user.nickname forKey:@"nickname"];
                   [userDefault setBool:YES forKey:@"logined"];
                   NSLog(@"nickname=%@",user.nickname);
                   
                   BaseTabBarViewController *root = [[BaseTabBarViewController alloc]init];
                   [UIApplication sharedApplication].keyWindow.rootViewController = root;
               }else{
                   NSLog(@"%@",error);
               }
               
           }];
}

- (IBAction)phoneLogin:(UIButton *)sender {
}
- (IBAction)qqLogin:(UIButton *)sender {
    //QQ的登录
    [ShareSDK getUserInfo:SSDKPlatformTypeQQ
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error){
         if (state == SSDKResponseStateSuccess){
             [userDefault setValue:user.icon forKey:@"icon"];
             [userDefault setValue:user.nickname forKey:@"nickname"];
             [userDefault setBool:YES forKey:@"logined"];
             NSLog(@"nickname=%@",user.nickname);
             
             BaseTabBarViewController *root = [[BaseTabBarViewController alloc]init];
             [UIApplication sharedApplication].keyWindow.rootViewController = root;
         }else{
             NSLog(@"%@",error);
         }
         
     }];
}
@end
