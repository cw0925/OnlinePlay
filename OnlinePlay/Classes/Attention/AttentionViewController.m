//
//  AttentionViewController.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/17.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "AttentionViewController.h"
#import "SearchViewController.h"
#import "AttentionModel.h"
#import "AttentionCell.h"
#import "LiveViewController.h"
#import "AttentionHeaderView.h"
#import "HomeViewController.h"
#import "NewsViewController.h"

@interface AttentionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation AttentionViewController
{
    UICollectionView *attentionCollection;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customNavigationBar:YES leftImage:@"live_icon_add" right:YES rightImage:@"title_button_more"];
    self.title = @"关注";
    [self initUI];
    [self sendRequestAttentionData];
}
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
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
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    attentionCollection = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    attentionCollection.backgroundColor = RGBColor(244, 244, 244);
    attentionCollection.delegate = self;
    attentionCollection.dataSource = self;
    layout.itemSize = CGSizeMake((ViewWidth-50)/2, 200);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.headerReferenceSize = CGSizeMake(ViewWidth, 250); //设置collectionView头视图的大小
    [self.view addSubview:attentionCollection];
    
    [attentionCollection registerNib:[UINib nibWithNibName:@"AttentionCell" bundle:nil] forCellWithReuseIdentifier:@"attentionCell"];
    
    [attentionCollection registerNib:[UINib nibWithNibName:@"AttentionHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 20, 10, 20);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AttentionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"attentionCell" forIndexPath:indexPath];
    AttentionModel *model = self.dataArr[indexPath.item];
    [cell congfigCell:model];
    cell.btnBlock = ^{
        [self.dataArr removeObjectAtIndex:indexPath.item];
        [collectionView reloadData];
    };
    return cell;
}
- (UICollectionReusableView*)collectionView:(UICollectionView*)collectionView viewForSupplementaryElementOfKind:(NSString*)kind atIndexPath:(NSIndexPath*)indexPath{
    AttentionHeaderView *head = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head" forIndexPath:indexPath];
    head.btnBlock = ^{
        HomeViewController *home = [[HomeViewController alloc]init];
        //home.segScroll.showIndex = 2;
        PushController(home)
    };
    return head;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LiveViewController *live = [[LiveViewController alloc]init];
    live.hidesBottomBarWhenPushed = YES;
    AttentionModel *model = self.dataArr[indexPath.item];
    live.nick = model.nick;
    live.portrait = model.portrait;
    live.share_addr = model.share_addr;
    live.stream_addr = model.stream_addr;
    live.uid = model.uid;
    live.roomID = model.roomID;
    PushController(live)
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)sendRequestAttentionData{
    [AFNetHelper GET:AttentionURL parameters:nil success:^(id responseObject) {
        NSData *data = (NSData *)responseObject;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if ([dic[@"error_msg"] isEqualToString:@"操作成功"] ) {
            for (NSDictionary *item in dic[@"lives"]) {
                AttentionModel *model = [[AttentionModel alloc]init];
                model.nick = item[@"creator"][@"nick"];
                model.uid = item[@"creator"][@"id"];
                model.portrait = item[@"creator"][@"portrait"];
                model.online_users = [item[@"online_users"] stringValue];
                model.share_addr = item[@"share_addr"];
                model.stream_addr = item[@"stream_addr"];
                model.roomID = item[@"id"];
                [self.dataArr addObject:model];
            }
            [attentionCollection reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}
- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
@end
