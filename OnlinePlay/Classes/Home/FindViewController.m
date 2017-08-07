//
//  FindViewController.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/17.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "FindViewController.h"
#import "SDCycleScrollView.h"
#import "ScrollContentViewController.h"
#import "FindCell.h"
#import "FindModel.h"
#import "LivesModel.h"
#import "FindTypeViewController.h"
#import "LiveViewController.h"

@interface FindViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>

@property(nonatomic,strong)NSMutableArray *scrollArr;
@property(nonatomic,strong)NSMutableArray *urlArr;
@property(nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation FindViewController
{
    UIView *headview;
    UITableView *findTable;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self sendRequestScrollData];
    [self sendRequestFindData];
}
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}
- (void)initScrollView{
    headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, (ViewHeight-64-50)*0.25+100)];
    headview.backgroundColor = RGBColor(242, 242, 242);
    
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0,ViewWidth, (ViewHeight-64-50)*0.25) delegate:self placeholderImage:[UIImage imageNamed:@"place.jpg"]];
    cycleScrollView.delegate = self;
    cycleScrollView.autoScrollTimeInterval = 4;
    cycleScrollView.imageURLStringsGroup = self.scrollArr;
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    [headview addSubview:cycleScrollView];
    
    CGFloat width = (ViewWidth-40)/1.5;
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, (ViewHeight-64-50)*0.25, ViewWidth, 100)];
    //scroll.backgroundColor = [UIColor greenColor];
    scroll.contentSize = CGSizeMake(width*2.5+40 , 0);
    scroll.showsHorizontalScrollIndicator = NO;
    [headview addSubview:scroll];

    for (NSInteger i = 0; i < 3; i++) {
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(10*(i+1)+width*i, 10, width, 80)];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.layer.cornerRadius = 5;
        bgView.layer.masksToBounds = YES;
        if (i<2) {
            UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 25, 30, 30)];
            icon.image = [UIImage imageNamed:@"live_preannounce_time_icon"];
            [bgView addSubview:icon];
            
            UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(50, 10, width-100, 30)];
            title.text = @"破尿酸普及~";
            [bgView addSubview:title];
            
            UILabel *time = [[UILabel alloc]initWithFrame:CGRectMake(50, 40, width-100, 30)];
            time.text = @"今天19：30";
            [bgView addSubview:time];
            
            UIButton *appointment = [UIButton buttonWithType:UIButtonTypeCustom];
            appointment.frame = CGRectMake(width-60, 25, 50, 30);
            [appointment setTitle:@"预约" forState:UIControlStateNormal];
            [appointment setTitleColor:RGBColor(0, 224, 206) forState:UIControlStateNormal];
            appointment.layer.borderWidth = 1;
            appointment.layer.borderColor = RGBColor(0, 224, 206).CGColor;
            appointment.layer.cornerRadius = 15;
            appointment.layer.masksToBounds = YES;
            [bgView addSubview:appointment];
            
        }else{
            [bgView setFrame:CGRectMake(10*(i+1)+width*i, 10, width/2, 80)];
            UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(width/4-20, 20, 40, 30)];
            imv.image = [UIImage imageNamed:@"live_preannounce_show_more"];
            [bgView addSubview:imv];
            
            UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, width/2, 30)];
            title.textAlignment = NSTextAlignmentCenter;
            title.text = @"查看更多";
            [bgView addSubview:title];
        }
        [scroll addSubview:bgView];
    }
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    ScrollContentViewController *content = [[ScrollContentViewController alloc]init];
    content.url = self.urlArr[index];
    content.hidesBottomBarWhenPushed = YES;
    PushController(content)
}
- (void)initUI{
    findTable = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    findTable.tableHeaderView = headview;
    findTable.delegate = self;
    findTable.dataSource = self;
    findTable.rowHeight = 250;
    findTable.sectionHeaderHeight = 5;
    findTable.sectionFooterHeight = 5;
    [self.view addSubview:findTable];
    
    [findTable registerNib:[UINib nibWithNibName:@"FindCell" bundle:nil] forCellReuseIdentifier:@"findCell"];
    //MJ刷新
//    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
//        
//    } ];
//    header.lastUpdatedTimeLabel.hidden = YES;
//    header.stateLabel.hidden = YES;
//    NSMutableArray *idleImgs = [NSMutableArray array];
//    for (NSInteger i = 1; i < 9; i++) {
//        NSString *string = [NSString stringWithFormat:@"refresh_fly_000%ld",i];
//        UIImage *img = [UIImage imageNamed:string];
//        [idleImgs addObject:img];
//    }
//    NSMutableArray *pullingImgs = [NSMutableArray array];
//    for (NSInteger i = 9; i < 22; i++) {
//        NSString *string = [NSString stringWithFormat:@"refresh_fly_00%02ld",(long)i];
//        UIImage *img = [UIImage imageNamed:string];
//        [pullingImgs addObject:img];
//    }
//    NSMutableArray *refreshingImgs = [NSMutableArray array];
//    for (NSInteger i = 22; i < 30; i++) {
//        NSString *string = [NSString stringWithFormat:@"refresh_fly_00%ld",i];
//        UIImage *img = [UIImage imageNamed:string];
//        [refreshingImgs addObject:img];
//    }
//    [header setImages:idleImgs forState:MJRefreshStateIdle];
//    findTable.mj_header = header;
//    [header setImages:pullingImgs forState:MJRefreshStatePulling];
//    [header setImages:refreshingImgs forState:MJRefreshStateRefreshing];
//    
//    findTable.mj_header = header;
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [findTable.mj_header endRefreshing];
//    });
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FindCell *cell = [tableView dequeueReusableCellWithIdentifier:@"findCell" forIndexPath:indexPath];
    FindModel *model = self.dataArr[indexPath.section];
    [cell configCell:model];
    cell.gestureClickBlock = ^(NSInteger tag) {
        LiveViewController *live = [[LiveViewController alloc]init];
        LivesModel *liveModel = model.livesArr[tag];
        live.hidesBottomBarWhenPushed = YES;
        live.portrait = liveModel.portrait;
        live.uid = liveModel.uid;
        live.nick = liveModel.nick;
        live.share_addr = liveModel.share_addr;
        live.stream_addr = liveModel.stream_addr;
        live.roomID = liveModel.roomID;
        PushController(live)
    };
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FindTypeViewController *type = [[FindTypeViewController alloc]init];
    type.hidesBottomBarWhenPushed = YES;
    FindModel *model = self.dataArr[indexPath.section];
    type.tab_key = model.tab_key;
    type.navTitle = model.title;
    PushController(type)
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//轮播图
- (void)sendRequestScrollData{
    [AFNetHelper GET:ScrollURL parameters:nil success:^(id responseObject) {
        NSData *data = (NSData *)responseObject;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if ([dic[@"error_msg"] isEqualToString:@"ok"]) {
            for (NSDictionary *item in dic[@"data"]) {
                [self.scrollArr addObject:item[@"image"]];
                [self.urlArr addObject:item[@"link"]];
            }
            [self initScrollView];
            [self initUI];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
//内容
- (void)sendRequestFindData{
    [AFNetHelper GET:FindURL parameters:nil success:^(id responseObject) {
        NSData *data = (NSData *)responseObject;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if ([dic[@"error_msg"] isEqualToString:@"操作成功"]) {
            for (NSDictionary *item in dic[@"live_nodes"]) {
                FindModel *model = [[FindModel alloc]init];
                model.desc = item[@"description"];
                model.title = item[@"title"];
                model.tab_key = item[@"tab_key"];
                for (NSDictionary *element in item[@"lives"]) {
                    LivesModel *liveModel = [[LivesModel alloc]init];
                    liveModel.nick = element[@"creator"][@"nick"];
                    liveModel.share_addr = element[@"share_addr"];
                    liveModel.stream_addr = element[@"stream_addr"];
                    liveModel.uid = [element[@"creator"][@"id"] stringValue];
                    liveModel.portrait = element[@"creator"][@"portrait"];
                    liveModel.desc = element[@"creator"][@"description"];
                    liveModel.online_users = [element[@"online_users"] stringValue];
                    liveModel.roomID = element[@"id"];
                    [model.livesArr addObject:liveModel];
                   // NSLog(@"--:%@",liveModel.roomID);
                    
                }
                [self.dataArr addObject:model];
            }
            [findTable reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}
- (NSMutableArray *)scrollArr
{
    if (!_scrollArr) {
        _scrollArr = [NSMutableArray array];
    }
    return _scrollArr;
}
- (NSMutableArray *)urlArr
{
    if (!_urlArr) {
        _urlArr = [NSMutableArray array];
    }
    return _urlArr;
}
- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
@end
