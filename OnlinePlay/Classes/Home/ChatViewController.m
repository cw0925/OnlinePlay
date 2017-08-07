//
//  ChatViewController.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/8/3.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "ChatViewController.h"
#import "GiftView.h"

@interface ChatViewController ()<EaseMessageViewControllerDelegate, EaseMessageViewControllerDataSource,EaseChatBarMoreViewDelegate>

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"你看那个sg";
    [self customNavigationBar];
    [self loginHX];
    [self initUI];
}
//登录环信后台
- (void)loginHX{
    [[EMClient sharedClient] loginWithUsername:@"cw1225" password:@"cw1225" completion:^(NSString *aUsername, EMError *aError) {
        if (!aError) {
            NSLog(@"%@登录成功",aUsername);
        } else {
            NSLog(@"登录失败%@",aError.errorDescription);
        }
    }];

}
- (void)customNavigationBar{
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    left.frame = CGRectMake(0, 0,25, 25);
    [left setBackgroundImage:[UIImage imageNamed:@"title_button_back"] forState:UIControlStateNormal];
    [left addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:left];
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(0, 0, 25, 25);
    [right setBackgroundImage:[UIImage imageNamed:@"me_zhuye"] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:right];
}
- (void)leftClick:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightClick:(UIButton *)sender{
    
}
- (void)initUI{
    //自定义气泡
//    [[EaseBaseMessageCell appearance] setSendBubbleBackgroundImage:[[UIImage imageNamed:@"chat_message_lt_me_"] stretchableImageWithLeftCapWidth:5 topCapHeight:35]];
//    [[EaseBaseMessageCell appearance] setRecvBubbleBackgroundImage:[[UIImage imageNamed:@"chat_message_lt_other_"] stretchableImageWithLeftCapWidth:35 topCapHeight:35]];
    //聊天刷新
    self.showRefreshHeader = YES;
    //聊天界面背景颜色
    self.tableView.backgroundColor = RGBColor(243, 253, 252);
    self.delegate = self;
    self.dataSource = self;
    //隐藏对话时的昵称
    [EaseBaseMessageCell appearance].messageNameIsHidden = YES;
    //修改字体高度,这样在隐藏昵称的时候,可以让气泡对齐
    [EaseBaseMessageCell appearance].messageNameHeight = 10;
    //删除功能模块中的位置
    [self.chatBarMoreView removeItematIndex:1];
    //删除功能模块中的语音
    [self.chatBarMoreView removeItematIndex:2];
    //删除功能模块中的视频
    [self.chatBarMoreView removeItematIndex:2];
    //添加功能模块中的图片和文字
    [self.chatBarMoreView insertItemWithImage:[UIImage imageNamed:@"icon_liwu"] highlightedImage:[UIImage imageNamed:@"icon_liwu"] title:@"礼物"];
    self.chatBarMoreView.delegate = self;
}
#pragma mark - EaseChatBarMoreViewDelegate
- (void)moreView:(EaseChatBarMoreView *)moreView didItemInMoreViewAtIndex:(NSInteger)index{
    if (index == 2) {
//        GiftView *gift = [[GiftView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, 150)];
//        [self.chatBarMoreView addSubview:gift];
    }
}
#pragma mark - EaseMessageViewControllerDataSource

- (id<IMessageModel>)messageViewController:(EaseMessageViewController *)viewController
                           modelForMessage:(EMMessage *)message
{
    id<IMessageModel> model = nil;
    model = [[EaseMessageModel alloc] initWithMessage:message];
    model.avatarImage = [UIImage imageNamed:@"EaseUIResource.bundle/user"];
    model.avatarURLPath = [userDefault valueForKey:@"icon"];//头像网络地址
    model.nickname = [userDefault valueForKey:@"nickname"];//用户昵称
    model.failImageName = @"imageDownloadFail";
    return model;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
