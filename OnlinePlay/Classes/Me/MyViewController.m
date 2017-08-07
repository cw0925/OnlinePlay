//
//  MyViewController.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/17.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "MyViewController.h"
#import "MyHeaderView.h"
#import "MyCell.h"
#import "SettingViewController.h"
#import "NewsViewController.h"

@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我";
    [self customNavigationBar:NO leftImage:@"" right:YES rightImage:@"title_button_more"];
    [self initUI];
}
- (void)rightClick:(UIButton *)sender{
    NewsViewController *news = [[NewsViewController alloc]init];
    news.hidesBottomBarWhenPushed = YES;
    PushController(news)
}
- (void)initUI{
    MyHeaderView *head = [[MyHeaderView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, 170)];
    UITableView *myTable = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    myTable.delegate = self;
    myTable.dataSource = self;
    myTable.sectionHeaderHeight = 5;
    myTable.sectionFooterHeight = 5;
    myTable.tableHeaderView = head;
    [self.view addSubview:myTable];
    
    [myTable registerNib:[UINib nibWithNibName:@"MyCell" bundle:nil] forCellReuseIdentifier:@"myCell"];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 2;
    }else if (section == 2){
        return 5;
    }else{
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    [cell configCell:indexPath];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
    }else if (indexPath.section == 3){
        SettingViewController *setting = [[SettingViewController alloc]init];
        setting.hidesBottomBarWhenPushed = YES;
        PushController(setting)
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
