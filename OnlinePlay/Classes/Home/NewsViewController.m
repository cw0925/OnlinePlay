//
//  NewsViewController.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/8/2.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "NewsViewController.h"
#import "ChatListCell.h"
#import "ChatViewController.h"

@interface NewsViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation NewsViewController
{
    UITableView *chatTable;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customNavigationBar];
    [self initUI];
}
- (void)customNavigationBar{
    self.title = @"消息";
    
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    left.frame = CGRectMake(0, 0,25, 25);
    [left setBackgroundImage:[UIImage imageNamed:@"title_button_back"] forState:UIControlStateNormal];
    [left addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:left];
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(0, 0,60, 25);
    right.titleLabel.font = [UIFont systemFontOfSize:13];
    [right setTitle:@"忽略未读" forState:UIControlStateNormal];
    [right addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:right];
}
- (void)leftClick:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightClick:(UIButton *)sender{
    
}
- (void)initUI{
    chatTable = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    chatTable.delegate = self;
    chatTable.dataSource = self;
    chatTable.rowHeight = 60;
    chatTable.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:chatTable];
    [chatTable registerNib:[UINib nibWithNibName:@"ChatListCell" bundle:nil] forCellReuseIdentifier:@"chatListCell"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"chatListCell" forIndexPath:indexPath];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatViewController *chat = [[ChatViewController alloc]initWithConversationChatter:@"huo1225" conversationType:EMConversationTypeChat];
    PushController(chat)
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
