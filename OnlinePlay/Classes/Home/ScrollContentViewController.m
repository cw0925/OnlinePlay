//
//  ScrollContentViewController.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/20.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "ScrollContentViewController.h"
#import <WebKit/WebKit.h>
#import "ShareView.h"

@interface ScrollContentViewController ()

@end

@implementation ScrollContentViewController
{
    WKWebView *webView;
    ShareView *shareView;
    UIView *maskView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customNavigationBar:YES leftImage:@"title_button_back" right:YES rightImage:@"title_share"];
    [self initUI];
}
- (void)initUI{
    webView = [[WKWebView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:webView];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    
    NSLog(@"%@",self.url);
}
- (void)rightClick:(UIButton *)sender{
    maskView = [[UIView alloc]initWithFrame:self.view.frame];
    maskView.backgroundColor = [UIColor clearColor];
    [self.view.window addSubview:maskView];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disMissMaskView:)];
    maskView.userInteractionEnabled = YES;
    [maskView addGestureRecognizer:gesture];
    
    shareView = [[ShareView alloc]initWithFrame:CGRectMake(0, ViewHeight-300, ViewWidth, 300)];
    [maskView addSubview:shareView];
    
    __weak typeof (self) weakSelf = self;
    shareView.btnBlock = ^(NSInteger tag) {
        [weakSelf shareToPlatform:tag];
    };
}
- (void)disMissMaskView:(UITapGestureRecognizer *)gesture{
    [maskView removeFromSuperview];
}
- (void)shareToPlatform:(NSInteger)platformType{
    //创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:@""
                                     images:@[] //传入要分享的图片
                                        url:[NSURL URLWithString:self.url]
                                      title:@""
                                       type:SSDKContentTypeAuto];
    if (platformType == 100) {//朋友圈
        [ShareSDK share:SSDKPlatformSubTypeWechatTimeline parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            if (error) {
                NSLog(@"%@",error);
            }
            
        }];
    }else if (platformType == 101){//微信
        [ShareSDK share:SSDKPlatformSubTypeWechatSession parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            if (error) {
                NSLog(@"%@",error);
            }
            
        }];
    }else if (platformType == 102){//微博
        [ShareSDK share:SSDKPlatformTypeSinaWeibo parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            if (error) {
                NSLog(@"%@",error);
            }
            
        }];
    }else if (platformType == 103){//QQ
        NSLog(@"QQ");
        [ShareSDK share:SSDKPlatformSubTypeQQFriend parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            if (error) {
                NSLog(@"%@",error);
            }
            
        }];
    }else if (platformType == 104){//QQ空间
        NSLog(@"QZONE");
        [ShareSDK share:SSDKPlatformSubTypeQZone parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            if (error) {
                NSLog(@"%@",error);
            }
            
        }];
    }else if (platformType == 106){//复制链接
        [shareView removeFromSuperview];
        [UIPasteboard generalPasteboard].string = self.url;
        UILabel *paste = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, 64)];
        paste.backgroundColor = RGBColor(0, 164, 238);
        paste.text = @"复制链接成功，快去分享吧";
        paste.textColor = [UIColor whiteColor];
        paste.font = [UIFont systemFontOfSize:13];
        paste.textAlignment = NSTextAlignmentCenter;
        [maskView addSubview:paste];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [maskView removeFromSuperview];
        });
    }
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
     if ([keyPath isEqualToString:@"title"])
    {
        if (object == webView) {
            self.title = webView.title;
            
        }
        else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
            
        }
    }
    else {
        
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
- (void)dealloc{
    [webView removeObserver:self forKeyPath:@"title"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
