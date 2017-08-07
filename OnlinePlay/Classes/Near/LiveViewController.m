//
//  LiveViewController.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/21.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "LiveViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "ShareView.h"
#import "CodewordView.h"
#import "GiftView.h"
#import "NewsView.h"
#import "UsersModel.h"
#import "UserInfoView.h"
#import "ToastView.h"

@interface LiveViewController ()

//@property (atomic, strong) NSURL *url;
@property (atomic, retain) id <IJKMediaPlayback> player;
@property (weak, nonatomic) UIView *PlayerView;
@property(nonatomic,strong)NSMutableArray *usersArr;
@end

@implementation LiveViewController
{
    UIView *topView;
    UIScrollView *scroll;
    UIView *maskView;
    ShareView *shareView;
    UIView *bottomView;
    UIButton *chat;
    UIView *recordView;
    GiftView *giftView;
    NewsView *newsView;
    UserInfoView *infoView;
}

- (void)viewWillAppear:(BOOL)animated{
    
    if (![self.player isPlaying]) {
        [self.player prepareToPlay];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    [self initUI];
    
    [self sendRequestOnlineUsersData];
}
- (void)initUI{
    //直播视频
    _player = [[IJKFFMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:self.stream_addr] withOptions:nil];
    NSLog(@"%@",self.stream_addr);
    
    UIView *playerView = [self.player view];
    
    UIView *displayView = [[UIView alloc] initWithFrame:self.view.frame];
    self.PlayerView = displayView;
    //self.PlayerView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.PlayerView];
    
    playerView.frame = self.PlayerView.bounds;
    playerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.PlayerView insertSubview:playerView atIndex:1];
    [_player setScalingMode:IJKMPMovieScalingModeAspectFill];
   // [self installMovieNotificationObservers];
    
    
    if (![self.player isPlaying]) {
        [self.player play];
    }else{
        [self.player pause];
    }
    //顶部
    topView = [[UIView alloc]initWithFrame:CGRectMake(10, 20, 150, 40)];
    topView.backgroundColor = RGBAColor(0, 0, 0, 0.2);
    topView.layer.cornerRadius = 20;
    topView.layer.masksToBounds = YES;
    [self.PlayerView addSubview:topView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showUserInfoViewClick:)];
    topView.userInteractionEnabled = YES;
    [topView addGestureRecognizer:tapGesture];
    //头像
    UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    icon.layer.cornerRadius = 20;
    icon.layer.masksToBounds = YES;
    [icon sd_setImageWithURL:[NSURL URLWithString:self.portrait]];
    [topView addSubview:icon];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(45, 0, 55, 20)];
    //title.backgroundColor = [UIColor yellowColor];
    title.text = @"直播";
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont systemFontOfSize:12];
    [topView addSubview:title];
    
    UILabel *count = [[UILabel alloc]initWithFrame:CGRectMake(45, 20, 55, 20)];
    count.text = @"45557";
    count.textColor = [UIColor whiteColor];
    count.font = [UIFont systemFontOfSize:12];
    //count.backgroundColor = [UIColor purpleColor];
    [topView addSubview:count];
    
    scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(170, 20, ViewWidth-170, 40)];
    scroll.showsHorizontalScrollIndicator = NO;
    [self.PlayerView addSubview:scroll];
    
    UIButton *ticket = [UIButton buttonWithType:UIButtonTypeCustom];
    ticket.layer.cornerRadius = 13;
    ticket.layer.masksToBounds = YES;
    ticket.frame = CGRectMake(10, 70, 120, 25);
    ticket.backgroundColor = RGBAColor(0, 0, 0, 0.2);
    [ticket setTitle:@"映票:1823558>" forState:UIControlStateNormal];
    ticket.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.PlayerView addSubview:ticket];
    
    UIButton *attention = [UIButton buttonWithType:UIButtonTypeCustom];
    attention.frame = CGRectMake(100, 10, 40, 20);
    [attention setTitle:@"关注" forState:UIControlStateNormal];
    [attention setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    attention.titleLabel.font = [UIFont systemFontOfSize:12];
    attention.backgroundColor = [UIColor cyanColor];
    attention.layer.cornerRadius = 8;
    attention.layer.masksToBounds = YES;
    [attention addTarget:self action:@selector(attentionClick:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:attention];
    
    UILabel *no = [[UILabel alloc]initWithFrame:CGRectMake(ViewWidth-120, 70, 120, 25)];
    //no.backgroundColor = [UIColor yellowColor];
    no.textColor = [UIColor whiteColor];
    no.text = [NSString stringWithFormat:@"映客号:%@",self.uid];
    no.textAlignment = NSTextAlignmentCenter;
    no.font = [UIFont systemFontOfSize:12];
    [self.PlayerView addSubview:no];
    
    //底部按钮
    bottomView = [[UIView alloc]initWithFrame:CGRectMake(50, ViewHeight-60, ViewWidth-50, 40)];
    //bottomView.backgroundColor = [UIColor redColor];
    [self.PlayerView addSubview:bottomView];
    
    CGFloat bottomWidth = bottomView.frame.size.width;
    NSArray *iconArr = @[@"mg_room_btn_guan_h",@"mg_room_btn_fenxiang_h",@"mg_room_btn_liwu_h",@"mg_room_btn_xinxi_h"];
    for (NSInteger i = 4; i>0; i--) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:iconArr[i-1]] forState:UIControlStateNormal];
        btn.frame = CGRectMake(bottomWidth-50*i, 0, 40, 40);
        btn.tag = i+1;
        [btn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:btn];
    }
    
    chat = [UIButton buttonWithType:UIButtonTypeCustom];
    chat.frame = CGRectMake(10, ViewHeight-60, 40, 40);
    //chat.backgroundColor = [UIColor greenColor];
    [chat setBackgroundImage:[UIImage imageNamed:@"mg_room_btn_liao_h"] forState:UIControlStateNormal];
    [self.PlayerView addSubview:chat];
    //聊天界面
    UIView *chatView = [[UIView alloc]initWithFrame:CGRectMake(5, ViewHeight-270, ViewWidth, 200)];
    //chatView.backgroundColor = [UIColor yellowColor];
    [self.PlayerView addSubview:chatView];
}
//用户信息弹框
- (void)showUserInfoViewClick:(UITapGestureRecognizer *)gesture{
    maskView = [[UIView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:maskView];
    UITapGestureRecognizer *maskGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeShareView)];
    maskView.userInteractionEnabled = YES;
    [maskView addGestureRecognizer:maskGesture];
    
    infoView = [[UserInfoView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth-100, 400)];
    infoView.center = maskView.center;
    [infoView.icon sd_setImageWithURL:[NSURL URLWithString:self.portrait] placeholderImage:[UIImage imageNamed:@""]];
    infoView.name.text = self.nick;
    infoView.ID.text = [NSString stringWithFormat:@"映客号:%@ |",self.uid];
    [maskView addSubview:infoView];
}
//在线用户
- (void)initOnlineUsersView:(NSArray *)arr{
    scroll.contentSize = CGSizeMake(40*arr.count,0);
    for (NSInteger i=0; i<arr.count; i++) {
        UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(40*i, 5, 30, 30)];
        imv.layer.cornerRadius = 15;
        imv.layer.masksToBounds = YES;
        UsersModel *model = arr[i];
        [imv sd_setImageWithURL:[NSURL URLWithString:model.portrait] placeholderImage:[UIImage imageNamed:@""]];
        [scroll addSubview:imv];
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showUserInfoViewClick:)];
        imv.userInteractionEnabled = YES;
        [imv addGestureRecognizer:gesture];
    }
}
- (void)bottomBtnClick:(UIButton *)sender{
    NSLog(@"%ld",(long)sender.tag);
    maskView = [[UIView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:maskView];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeShareView)];
    maskView.userInteractionEnabled = YES;
    [maskView addGestureRecognizer:gesture];
    
    if (sender.tag == 5) {//私信
        newsView = [[NewsView alloc]initWithFrame:CGRectMake(0, ViewHeight-250, ViewWidth, 250)];
        newsView.portrait = self.portrait;
        newsView.nick = self.nick;
        [maskView addSubview:newsView];
    }else if (sender.tag == 4){//礼物
        NSLog(@"礼物");
        giftView = [[GiftView alloc]initWithFrame:CGRectMake(0, ViewHeight-300, ViewWidth, 300)];
        [maskView addSubview:giftView];
        
    }else if (sender.tag == 3){//分享
        shareView = [[ShareView alloc]initWithFrame:CGRectMake(0, ViewHeight-300, ViewWidth, 300)];
        [maskView addSubview:shareView];
        
        __weak typeof (self) weakSelf = self;
        shareView.btnBlock = ^(NSInteger tag) {
            [weakSelf shareToPlatform:tag];
        };
    }else{//关闭
        [self.player stop];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)removeShareView{
    [maskView removeFromSuperview];
}
- (void)attentionClick:(UIButton *)sender{
    [sender removeFromSuperview];
    [topView setFrame:CGRectMake(10, 20, 110, 40)];
    [scroll setFrame:CGRectMake(120, 20, ViewWidth-90, 40)];
}
- (void)shareToPlatform:(NSInteger)platformType{
    //创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:[NSString stringWithFormat:@"%@正在%@的直播间，你还不快来！",[userDefault valueForKey:@"nickname"],self.nick]
                                     images:@[self.portrait] //传入要分享的图片
                                        url:[NSURL URLWithString:self.share_addr]
                                      title:[NSString stringWithFormat:@"%@正在%@的直播间，你还不快来！",[userDefault valueForKey:@"nickname"],self.nick]
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
    }else if (platformType == 105){//映口令
        [shareView removeFromSuperview];
        CodewordView *codewordView = [[CodewordView alloc]initWithFrame:CGRectMake(0, 0, 250, 150)];
        codewordView.center = maskView.center;
        codewordView.btnBlock = ^{
            [ShareSDK share:SSDKPlatformTypeSinaWeibo parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                if (error) {
                    NSLog(@"%@",error);
                }
                
            }];
        };
        [maskView addSubview:codewordView];
        
    }else if (platformType == 106){//复制链接
        [shareView removeFromSuperview];
        [maskView removeFromSuperview];
        [UIPasteboard generalPasteboard].string = self.share_addr;
        ToastView *toastView = [[ToastView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, 64)];
        toastView.toast.text = @"复制链接成功，快去分享吧";
        [self.view addSubview:toastView];
    }else {//录屏
        [shareView removeFromSuperview];
        bottomView.hidden = YES;
        chat.hidden = YES;
        
        recordView = [[UIView alloc]initWithFrame:CGRectMake(0, ViewHeight-60, ViewWidth, 60)];
        recordView.backgroundColor = RGBAColor(0, 0, 0, 0.2);
        [maskView addSubview:recordView];
        
        UIButton *cancle = [UIButton buttonWithType:UIButtonTypeCustom];
        cancle.frame = CGRectMake(20, 15, 50, 30);
        [cancle setTitle:@"取消" forState:UIControlStateNormal];
        [cancle setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancle addTarget:self action:@selector(cancleClick:) forControlEvents:UIControlEventTouchUpInside];
        [recordView addSubview:cancle];
        
        UIButton *recordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //recordBtn.backgroundColor = [UIColor redColor];
        recordBtn.frame = CGRectMake(ViewWidth/2-20, 10, 40, 40);
        //recordBtn.center = recordView.center;
        [recordBtn setBackgroundImage:[UIImage imageNamed:@"replay_cover_unselected"] forState:UIControlStateNormal];
        [recordBtn addTarget:self action:@selector(recordClick:) forControlEvents:UIControlEventTouchUpInside];
        [recordView addSubview:recordBtn];
    }
}
- (void)recordClick:(UIButton *)sender{
    [sender setBackgroundImage:[UIImage imageNamed:@"ntalker_video_record"] forState:UIControlStateNormal];
}
- (void)cancleClick:(UIButton *)sender{
    bottomView.hidden = NO;
    chat.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        CGRect rect = recordView.frame;
        rect.origin.y = ViewHeight;
        recordView.frame = rect;
        
    } completion:^(BOOL finished) {
        
    }];
}
#pragma Selector func

- (void)loadStateDidChange:(NSNotification*)notification {
    IJKMPMovieLoadState loadState = _player.loadState;
    
    if ((loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        NSLog(@"LoadStateDidChange: IJKMovieLoadStatePlayThroughOK: %d\n",(int)loadState);
    }else if ((loadState & IJKMPMovieLoadStateStalled) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStateStalled: %d\n", (int)loadState);
    } else {
        NSLog(@"loadStateDidChange: ???: %d\n", (int)loadState);
    }
}

- (void)moviePlayBackFinish:(NSNotification*)notification {
    int reason =[[[notification userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
    switch (reason) {
        case IJKMPMovieFinishReasonPlaybackEnded:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackEnded: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonUserExited:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonUserExited: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonPlaybackError:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackError: %d\n", reason);
            break;
            
        default:
            NSLog(@"playbackPlayBackDidFinish: ???: %d\n", reason);
            break;
    }
}

- (void)mediaIsPreparedToPlayDidChange:(NSNotification*)notification {
    NSLog(@"mediaIsPrepareToPlayDidChange\n");
}

- (void)moviePlayBackStateDidChange:(NSNotification*)notification {
    switch (_player.playbackState) {
        case IJKMPMoviePlaybackStateStopped:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: stoped", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStatePlaying:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: playing", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStatePaused:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: paused", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStateInterrupted:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: interrupted", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStateSeekingForward:
        case IJKMPMoviePlaybackStateSeekingBackward: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: seeking", (int)_player.playbackState);
            break;
        }
            
        default: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: unknown", (int)_player.playbackState);
            break;
        }
    }
}
#pragma Install Notifiacation

- (void)installMovieNotificationObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadStateDidChange:)
                                                 name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                               object:_player];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackFinish:)
                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mediaIsPreparedToPlayDidChange:)
                                                 name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackStateDidChange:)
                                                 name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                               object:_player];
    
}

- (void)removeMovieNotificationObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                                  object:_player];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//在线用户
- (void)sendRequestOnlineUsersData{
    NSString *url = [NSString stringWithFormat:OnlineUsersURL,self.roomID];
    [AFNetHelper GET:url parameters:nil success:^(id responseObject) {
        NSData *data = (NSData *)responseObject;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if ([dic[@"error_msg"] isEqualToString:@"操作成功"]) {
            for (NSDictionary *item in dic[@"users"]) {
                UsersModel *model = [[UsersModel alloc]init];
                [model setValuesForKeysWithDictionary:item];
                [self.usersArr addObject:model];
            }
            [self initOnlineUsersView:self.usersArr];
        }
    } failure:^(NSError *error) {
        
    }];
}
- (NSMutableArray *)usersArr
{
    if (!_usersArr) {
        _usersArr = [NSMutableArray array];
    }
    return _usersArr;
}
@end
