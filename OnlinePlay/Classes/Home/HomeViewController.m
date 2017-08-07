//
//  HomeViewController.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/17.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "HomeViewController.h"
#import "FindViewController.h"
#import "HotViewController.h"
#import "FilmViewController.h"
#import "GameViewController.h"
#import "SearchViewController.h"
#import "NewsViewController.h"

@interface HomeViewController ()

@property (nonatomic, strong) MLMSegmentHead *segHead;
//@property (nonatomic, strong) MLMSegmentScroll *segScroll;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self customNavigationBar:YES leftImage:@"title_button_search" right:YES rightImage:@"title_button_more"];
    [self initUI];
}
- (void)leftClick:(UIButton *)sender{
    SearchViewController *search = [[SearchViewController alloc]init];
    [self presentViewController:search animated:YES completion:^{
        
    }];
}
- (void)rightClick:(UIButton *)sender{
    NewsViewController *news = [[NewsViewController alloc]init];
    news.hidesBottomBarWhenPushed = YES;
    PushController(news)
}
- (void)initUI{
    NSArray *list = @[@"发现",@"热门",@"小视频",@"游戏"];
    NSArray *controllerArr = @[[[FindViewController alloc]init],[[HotViewController alloc]init],[[FilmViewController alloc]init],[[GameViewController alloc]init]];
    
    _segHead = [[MLMSegmentHead alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-100, 44) titles:list headStyle:1 layoutStyle:1];
    _segHead.headColor = [UIColor clearColor];
    _segHead.fontScale = .85;
    _segHead.fontSize = 16;
    _segHead.lineScale = .9;
    _segHead.equalSize = NO;
    _segHead.bottomLineHeight = 0;
    _segHead.deSelectColor = [UIColor colorWithWhite:1 alpha:0.5];
    _segHead.selectColor = [UIColor colorWithWhite:1 alpha:1];
    _segHead.lineColor = [UIColor whiteColor];
    
    _segScroll = [[MLMSegmentScroll alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-49) vcOrViews:controllerArr];
    _segScroll.loadAll = YES;
    //_segScroll.showIndex = 0;
    
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
