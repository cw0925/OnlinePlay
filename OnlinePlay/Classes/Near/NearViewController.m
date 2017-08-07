//
//  NearViewController.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/17.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "NearViewController.h"
#import "MLMSegmentManager.h"
#import "OnlineViewController.h"
#import "PersonViewController.h"
#import "SiftView.h"
#import "NewsViewController.h"

@interface NearViewController ()

@property (nonatomic, strong) MLMSegmentHead *segHead;
@property (nonatomic, strong) MLMSegmentScroll *segScroll;
@property(nonatomic,strong)SiftView *siftView;
@property(nonatomic,strong)UIView *maskView;

@end

@implementation NearViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self customNavigationBar:YES leftImage:@"filter_icon" right:YES rightImage:@"title_button_more"];
    [self initUI];
    
}
- (void)customNavigationBar:(BOOL)haveLeft leftImage:(NSString *)leftImage right:(BOOL)haveRight rightImage:(NSString *)rightImage{
    [super customNavigationBar:haveLeft leftImage:leftImage right:haveRight rightImage:rightImage];
    if (haveLeft) {
        UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
        left.frame = CGRectMake(0, 0,50, 25);
        [left setImage:[UIImage imageNamed:leftImage] forState:UIControlStateNormal];
        [left setTitle:@"筛选" forState:UIControlStateNormal];
        left.titleLabel.font = [UIFont systemFontOfSize:15];
        [left setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
        [left setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        [left addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:left];
    }
}
- (void)leftClick:(UIButton *)sender{
    self.maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.maskView.backgroundColor = RGBAColor(0,0, 0, 0.2);
    [self.view.window addSubview:self.maskView];
    
    _siftView = [[SiftView alloc]initWithFrame:CGRectMake(0, ViewHeight-220, ViewWidth, 220)];
    
    __weak typeof (self) weakSelf = self;
    self.siftView.btnClickBlock = ^{
        [weakSelf.siftView remove];
        [weakSelf.maskView removeFromSuperview];
    };
    [self.maskView addSubview:_siftView];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissSiftView)];
    self.maskView.userInteractionEnabled = YES;
    [self.maskView addGestureRecognizer:gesture];
}
- (void)rightClick:(UIButton *)sender{
    NewsViewController *news = [[NewsViewController alloc]init];
    news.hidesBottomBarWhenPushed = YES;
    PushController(news)
}
- (void)dismissSiftView{
    [self.siftView remove];
    [self.maskView removeFromSuperview];
}
- (void)initUI{
    NSArray *list = @[@"直播",@"人"];
    NSArray *controllerArr = @[[[OnlineViewController alloc]init],[[PersonViewController alloc]init]];
    
    _segHead = [[MLMSegmentHead alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-100, 44) titles:list headStyle:1 layoutStyle:1];
    _segHead.headColor = [UIColor clearColor];
    _segHead.fontScale = .85;
    _segHead.fontSize = 16;
    _segHead.lineScale = .9;
    _segHead.equalSize = YES;
    _segHead.bottomLineHeight = 0;
    _segHead.deSelectColor = [UIColor colorWithWhite:1 alpha:0.5];
    _segHead.selectColor = [UIColor colorWithWhite:1 alpha:1];
    _segHead.lineColor = [UIColor whiteColor];
    
    _segScroll = [[MLMSegmentScroll alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-49) vcOrViews:controllerArr];
    _segScroll.loadAll = NO;
    _segScroll.showIndex = 0;
    
    [MLMSegmentManager associateHead:_segHead withScroll:_segScroll completion:^{
        self.navigationItem.titleView = _segHead;
        [self.view addSubview:_segScroll];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
