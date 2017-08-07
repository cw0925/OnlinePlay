//
//  HotViewController.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/17.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "HotViewController.h"
#import "SDCycleScrollView.h"
#import "ScrollContentViewController.h"
#import "HotModel.h"
#import "HotCell.h"
#import "LiveViewController.h"

@interface HotViewController ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray *scrollArr;
@property(nonatomic,strong)NSMutableArray *urlArr;
@property(nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation HotViewController
{
    SDCycleScrollView *cycleScrollView;
    UITableView *hotTable;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self sendRequestHotScrollData];
    
    [self initScrollView];
    [self initUI];
    [self sendRequestHotData];
}
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}
- (void)initScrollView{
    cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0,ViewWidth, 120) delegate:self placeholderImage:[UIImage imageNamed:@"place.jpg"]];
    cycleScrollView.delegate = self;
    cycleScrollView.autoScrollTimeInterval = 4;
//    cycleScrollView.imageURLStringsGroup = self.scrollArr;
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
}
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    ScrollContentViewController *content = [[ScrollContentViewController alloc]init];
    content.url = self.urlArr[index];
    content.hidesBottomBarWhenPushed = YES;
    PushController(content)
}
- (void)initUI{
    hotTable = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    //hotTable.backgroundColor = [UIColor yellowColor];
    hotTable.tableHeaderView = cycleScrollView;
    hotTable.delegate = self;
    hotTable.dataSource = self;
    hotTable.rowHeight = 400;
    hotTable.sectionFooterHeight = 5;
    hotTable.sectionHeaderHeight = 5;
    [self.view addSubview:hotTable];
    [hotTable registerNib:[UINib nibWithNibName:@"HotCell" bundle:nil] forCellReuseIdentifier:@"hotCell"];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hotCell" forIndexPath:indexPath];
    HotModel *model = self.dataArr[indexPath.section];
    [cell configCell:model];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LiveViewController *live = [[LiveViewController alloc]init];
    live.hidesBottomBarWhenPushed = YES;
    HotModel *model = self.dataArr[indexPath.section];
    live.nick = model.nick;
    live.portrait = model.portrait;
    live.share_addr = model.share_addr;
    live.stream_addr = model.stream_addr;
    live.uid = model.uid;
    PushController(live)
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)sendRequestHotScrollData{
    [AFNetHelper GET:HotScrollURL parameters:nil success:^(id responseObject) {
        NSData *data = (NSData *)responseObject;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if ([dic[@"error_msg"] isEqualToString:@"操作成功"]) {
            for (NSDictionary *item in dic[@"ticker"]) {
                [self.scrollArr addObject:item[@"image"]];
                [self.urlArr addObject:item[@"link"]];
            }
            cycleScrollView.imageURLStringsGroup = self.scrollArr;
        }
    } failure:^(NSError *error) {
        
    }];
}
- (void)sendRequestHotData{
    [AFNetHelper GET:HotURL parameters:nil success:^(id responseObject) {
        NSData *data = (NSData *)responseObject;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if ([dic[@"error_msg"] isEqualToString:@"操作成功"]) {
            for (NSDictionary *item in dic[@"lives"]) {
                HotModel *model = [[HotModel alloc]init];
                model.uid = item[@"act_info"][@"uid"];
                model.city = item[@"city"];
                model.nick = item[@"creator"][@"nick"];
                model.portrait = item[@"creator"][@"portrait"];
                model.online_users = [item[@"online_users"] stringValue];
                model.stream_addr = item[@"stream_addr"];
                model.share_addr = item[@"share_addr"];
                for (NSDictionary *element in item[@"extra"][@"label"]) {
                    [model.tabArr addObject:element[@"tab_name"]];
                }
                [self.dataArr addObject:model];
            }
            [hotTable reloadData];
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
