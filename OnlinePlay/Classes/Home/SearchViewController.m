//
//  SearchViewController.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/18.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchTypeCell.h"
#import "SearchUserCell.h"
#import "UserModel.h"
#import "User.h"
#import "LiveModel.h"
#import "MoreSearchViewController.h"
#import "BaseNavigationViewController.h"
#import "PresentTransitionAnimated.h"
#import "DismissTransitionAnimated.h"
#import "Timestamp.h"

@interface SearchViewController ()<UITableViewDelegate,UITableViewDataSource,UIViewControllerTransitioningDelegate>

@property(nonatomic,strong)NSMutableArray *userArr;
@property(nonatomic,strong)NSMutableArray *typeArr;

@end

@implementation SearchViewController
{
    UITableView *searchTable;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customNavigationBar];
    [self initUI];
    
    [self sendRequestSearchData];
}
- (void)customNavigationBar{
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, 64)];
    navView.backgroundColor = RGBColor(0, 224, 206);
    [self.view addSubview:navView];
    
    UITextField *searchTF = [[UITextField alloc]initWithFrame:CGRectMake(20, 30, ViewWidth-80, 25)];
    searchTF.font = [UIFont systemFontOfSize:15];
    searchTF.layer.cornerRadius = 13;
    searchTF.layer.masksToBounds = YES;
    searchTF.placeholder = @"请输入昵称/映客号";
    searchTF.backgroundColor = [UIColor whiteColor];
    [searchTF becomeFirstResponder];
    [navView addSubview:searchTF];
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //cancleBtn.backgroundColor = [UIColor redColor];
    cancleBtn.frame = CGRectMake(ViewWidth-50, 28, 40, 30);
    cancleBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancleClick:) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:cancleBtn];
}
- (void)cancleClick:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)initUI{
    searchTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ViewWidth, ViewHeight-64) style:UITableViewStyleGrouped];
    //searchTable.backgroundColor = [UIColor purpleColor];
    searchTable.delegate = self;
    searchTable.dataSource = self;
    [self.view addSubview:searchTable];
    
    [searchTable registerNib:[UINib nibWithNibName:@"SearchTypeCell" bundle:nil] forCellReuseIdentifier:@"typeCell"];
    
    [searchTable registerNib:[UINib nibWithNibName:@"SearchUserCell" bundle:nil] forCellReuseIdentifier:@"userCell"];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return  self.typeArr.count;
    }else{
        return  self.userArr.count;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 184.5;
    }else{
        return 70;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section

{
    
    return 0.1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        SearchTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"typeCell" forIndexPath:indexPath];
        LiveModel *model = self.typeArr[indexPath.row];
        [cell configCell:model];
        
        //__weak typeof (self) weakSelf = self;
        cell.btnBlock = ^{
            MoreSearchViewController *more = [[MoreSearchViewController alloc]init];
            BaseNavigationViewController *navc = [[BaseNavigationViewController alloc]initWithRootViewController:more];
            navc.transitioningDelegate = self;
            more.navcTitle = model.title;
            [self presentViewController:navc animated:YES completion:^{
                
            }];
        };
        return cell;
    }else{
        SearchUserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userCell" forIndexPath:indexPath];
        UserModel *model = self.userArr[indexPath.row];
        [cell configCell:model];
        return cell;
    }
}
#pragma Mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [[PresentTransitionAnimated alloc] init];
}
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[DismissTransitionAnimated alloc] init];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)sendRequestSearchData{
    NSString *string = [NSString stringWithFormat:SearchPlaceholdURL,[Timestamp getCurrentDateTimestamp]];
    NSLog(@"%@",string);
    [AFNetHelper GET:string parameters:nil success:^(id responseObject) {
        NSData *data = (NSData *)responseObject;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if ([dic[@"error_msg"] isEqualToString:@"操作成功"]) {
            //类型
            NSArray *liveArray = dic[@"live_nodes"];
            for (NSDictionary *item in liveArray) {
                LiveModel *model = [[LiveModel alloc]init];
                model.title = item[@"title"];
                
                NSArray *livesArr = item[@"lives"];
                for (NSDictionary *element in livesArr) {
                    [model.iconArr addObject:element[@"creator"][@"portrait"]];
                    [model.userArr addObject:element[@"online_users"]];
                }
                [self.typeArr addObject:model];
            }
            //用户
            NSArray *userArray = dic[@"user_nodes"][0][@"users"];
            for (NSDictionary *item in userArray) {
                UserModel *model = [[UserModel alloc]init];
                model.reason = item[@"reason"];
                User *user = [User mj_objectWithKeyValues:item[@"user"]];
                model.user = user;
                [self.userArr addObject:model];
            }
            [searchTable reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}
- (NSMutableArray *)typeArr
{
    if (!_typeArr) {
        _typeArr = [NSMutableArray array];
    }
    return _typeArr;
}
- (NSMutableArray *)userArr
{
    if (!_userArr) {
        _userArr = [NSMutableArray array];
    }
    return _userArr;
}
@end
