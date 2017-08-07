//
//  AppDelegate.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/17.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabBarViewController.h"
#import "RegisterViewController.h"
//ShareSDK
//#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//微信SDK头文件
#import "WXApi.h"
//新浪微博SDK头文件
#import "WeiboSDK.h"
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加”-ObjC”
#import <Hyphenate/Hyphenate.h>
#import "EaseUI.h"
//微信
#define WXAppID @"wxcdf48bdbdd0c4c6f"
#define WXAppSecret @"299ca35405233f0775c58c0634faec16"
//新浪
#define SinaAppKey @"1720522258"
#define SinaAppSecret @"8d4f2f58891bbf8f5c142c86a25914eb"
//QQ
#define QQAppID @"1104744025"
#define QQAppKey @"GdiLLicEWLWQWEaI"
//环信
#define HXKey @"cw0925#onlineplay"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //状态栏字体颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    if ([userDefault boolForKey:@"logined"]) {
        self.window.rootViewController = [[BaseTabBarViewController alloc]init];
    }else{
        RegisterViewController *regist = StoryBoard(@"Login", @"register")
        self.window.rootViewController = regist;
    }
    //ShareSDK
    [ShareSDK registerActivePlatforms:@[
                                        @(SSDKPlatformTypeSinaWeibo),
                                        @(SSDKPlatformTypeWechat),
                                        @(SSDKPlatformTypeQQ)] onImport:^(SSDKPlatformType platformType) {
                                            switch (platformType)
                                            {
                                                case SSDKPlatformTypeWechat:
                                                    [ShareSDKConnector connectWeChat:[WXApi class]];
                                                    break;
                                                case SSDKPlatformTypeQQ:
                                                    [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                                                    break;
                                                case SSDKPlatformTypeSinaWeibo:
                                                    [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                                                    break;
                                                default:
                                                    break;
                                            }
                                        } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
                                            switch (platformType)
                                            {
                                                case SSDKPlatformTypeSinaWeibo:
                                                    //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                                                    [appInfo SSDKSetupSinaWeiboByAppKey:SinaAppKey
                                                                              appSecret:SinaAppSecret
                                                                            redirectUri:@"http://www.sharesdk.cn"
                                                                               authType:SSDKAuthTypeBoth];
                                                    break;
                                                case SSDKPlatformTypeWechat:
                                                    [appInfo SSDKSetupWeChatByAppId:WXAppID
                                                                          appSecret:WXAppSecret];
                                                    break;
                                                case SSDKPlatformTypeQQ:
                                                    [appInfo SSDKSetupQQByAppId:QQAppID
                                                                         appKey:QQAppKey
                                                                       authType:SSDKAuthTypeBoth];
                                                    break;
                                                default:
                                                    break;
                                            }
                                        }];
    //环信AppKey:注册的AppKey
    //apnsCertName:推送证书名（不需要加后缀）
    EMOptions *options = [EMOptions optionsWithAppkey:HXKey];
    //options.apnsCertName = @"istore_dev";
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    [[EaseSDKHelper shareHelper] hyphenateApplication:application
                        didFinishLaunchingWithOptions:launchOptions
                                               appkey:HXKey
                                         apnsCertName:nil
                                          otherConfig:@{kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:YES]}];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

// APP进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     [[EMClient sharedClient] applicationDidEnterBackground:application];
}

// APP将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
