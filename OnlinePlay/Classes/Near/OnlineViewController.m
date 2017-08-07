
//
//  OnlineViewController.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/19.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "OnlineViewController.h"
#import "OnlineCell.h"
#import "Timestamp.h"
#import "OnlineModel.h"
#import "LiveViewController.h"

#define ITEMSIZE (ViewWidth-40)/3

@interface OnlineViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)NSMutableArray *onlineArr;
@end

@implementation OnlineViewController
{
    UICollectionView *onlineCollection;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.automaticallyAdjustsScrollViewInsets = NO;
    [self initUI];
    [self sendRequestOnlineData];
}
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}
- (void)initUI{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(ITEMSIZE, ITEMSIZE+30);
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    onlineCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight-64-20 ) collectionViewLayout:layout];
    onlineCollection.delegate = self;
    onlineCollection.dataSource = self;
    onlineCollection.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:onlineCollection];
    
    [onlineCollection registerNib:[UINib nibWithNibName:@"OnlineCell" bundle:nil] forCellWithReuseIdentifier:@"onlineCell"];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.onlineArr.count;
}
//定义每个Section的四边间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);//分别为上、左、下、右
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    OnlineCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"onlineCell" forIndexPath:indexPath];
    OnlineModel *model = self.onlineArr[indexPath.item];
    [cell configCell:model];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LiveViewController *live = [[LiveViewController alloc]init];
    OnlineModel *model = self.onlineArr[indexPath.item];
    live.hidesBottomBarWhenPushed = YES;
    live.portrait = model.portrait;
    live.uid = model.uid;
    live.nick = model.nick;
    live.share_addr = model.share_addr;
    live.stream_addr = model.stream_addr;
    live.roomID = model.roomID;
    PushController(live)
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)sendRequestOnlineData{
    
    [AFNetHelper GET:OnlineURL parameters:nil success:^(id responseObject) {
        NSData *data = (NSData *)responseObject;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if ([dic[@"error_msg"] isEqualToString:@"操作成功"]) {
            for (NSDictionary *item in dic[@"flow"]) {
                OnlineModel *model = [[OnlineModel alloc]init];
                model.distance = item[@"info"][@"distance"];
                model.portrait= item[@"info"][@"creator"][@"portrait"];
                model.stream_addr = item[@"info"][@"stream_addr"];
                model.uid = item[@"info"][@"act_info"][@"uid"];
                model.nick = item[@"info"][@"creator"][@"nick"];
                model.share_addr = item[@"info"][@"share_addr"];
                model.roomID = item[@"info"][@"id"];
                [self.onlineArr addObject:model];
            }
            [onlineCollection reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
- (NSMutableArray *)onlineArr
{
    if (!_onlineArr) {
        _onlineArr = [NSMutableArray array];
    }
    return _onlineArr;
}
@end
