//
//  GameViewController.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/17.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "GameViewController.h"
#import "SDCycleScrollView.h"
#import "ScrollContentViewController.h"
#import "GameCell.h"
#import "GamePlayCell.h"
#import "GameModel.h"
#import "GameLiveModel.h"
#import "LiveViewController.h"

@interface GameViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SDCycleScrollViewDelegate>

@property(nonatomic,strong)NSMutableArray *scrollArr;
@property(nonatomic,strong)NSMutableArray *urlArr;
@property(nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation GameViewController
{
    SDCycleScrollView *cycleScrollView;
    UIView *headView;
    UICollectionView *gameCollection;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.view.backgroundColor = [UIColor grayColor];
    [self initHeadView];
    [self sendRequestGameScrollData];
    [self initUI];
    [self sendRequestGameData];
}
- (void)initHeadView{
    headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, 200)];
    headView.backgroundColor = [UIColor whiteColor];
    //[self.view addSubview:headView];
    
    cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0,ViewWidth, 140) delegate:self placeholderImage:[UIImage imageNamed:@"place.jpg"]];
    cycleScrollView.delegate = self;
    cycleScrollView.autoScrollTimeInterval = 4;
    //cycleScrollView.imageURLStringsGroup = self.scrollArr;
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    [headView addSubview:cycleScrollView];
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 140, ViewWidth, 60)];
    [headView addSubview:bottomView];
    
    UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(20, 15, 40, 30)];
    imv.image = [UIImage imageNamed:@"qiandao-pic"];
    [bottomView addSubview:imv];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(70, 5, ViewWidth-70-100, 25)];
    title.text = @"每日签到领好礼";
    title.font = [UIFont systemFontOfSize:15];
    [bottomView addSubview:title];
    
    UILabel *desc = [[UILabel alloc]initWithFrame:CGRectMake(70, 30, ViewWidth-70-100, 30)];
    desc.text = @"签到完成任务都可获得经验、钻石奖励";
    desc.font = [UIFont systemFontOfSize:12];
    [bottomView addSubview:desc];
    
    UIButton *prize = [UIButton buttonWithType:UIButtonTypeCustom];
    prize.frame = CGRectMake(ViewWidth-90, 15, 80, 30);
    [prize setTitle:@"立即领奖" forState:UIControlStateNormal];
    [prize setTitleColor:RGBColor(0, 224, 206) forState:UIControlStateNormal];
    prize.titleLabel.font = [UIFont systemFontOfSize:14];
    prize.layer.borderWidth = 1;
    prize.layer.borderColor = RGBColor(0, 224, 206).CGColor;
    prize.layer.cornerRadius = 15;
    prize.layer.masksToBounds = YES;
    [bottomView addSubview:prize];

}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    ScrollContentViewController *content = [[ScrollContentViewController alloc]init];
    content.url = self.urlArr[index];
    content.hidesBottomBarWhenPushed = YES;
    PushController(content)
}
- (void)initUI{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //layout.itemSize = CGSizeMake((ViewWidth-2)/2, 170);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    gameCollection = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    gameCollection.delegate = self;
    gameCollection.dataSource = self;
    gameCollection.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:gameCollection];
    
    [gameCollection registerNib:[UINib nibWithNibName:@"GameCell" bundle:nil] forCellWithReuseIdentifier:@"gameCell"];
    [gameCollection registerNib:[UINib nibWithNibName:@"GamePlayCell" bundle:nil] forCellWithReuseIdentifier:@"gamePlayCell"];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArr.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    GameModel *model = self.dataArr[section];
    return model.liveArr.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item == 0) {
        return CGSizeMake(ViewWidth, 200);
    }else{
        return CGSizeMake((ViewWidth-2)/2, 170);
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.item == 0) {
        GamePlayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"gamePlayCell" forIndexPath:indexPath];
        GameModel *model = self.dataArr[indexPath.section];
        GameLiveModel *liveModel = model.liveArr[indexPath.item];
        [cell configCell:liveModel];
        return cell;
    }else{
        GameCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"gameCell" forIndexPath:indexPath];
        GameModel *model = self.dataArr[indexPath.section];
        GameLiveModel *liveModel = model.liveArr[indexPath.item];
        [cell configCell:liveModel];
        return cell;
    }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LiveViewController *live = [[LiveViewController alloc]init];
    GameModel *model = self.dataArr[indexPath.section];
    GameLiveModel *liveModel = model.liveArr[indexPath.item];
    live.hidesBottomBarWhenPushed = YES;
    live.portrait = liveModel.portrait;
    live.uid = liveModel.uid;
    live.nick = liveModel.nick;
    live.share_addr = liveModel.share_addr;
    live.stream_addr = liveModel.stream_addr;
    live.roomID = liveModel.roomID;
    PushController(live)
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)sendRequestGameScrollData{
    [AFNetHelper GET:GameScrollURL parameters:nil success:^(id responseObject) {
        NSData *data = (NSData *)responseObject;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if ([dic[@"error_msg"] isEqualToString:@"ok"]) {
            for (NSDictionary *item in dic[@"data"]) {
                [self.scrollArr addObject:item[@"image"]];
                [self.urlArr addObject:item[@"link"]];
            }
            cycleScrollView.imageURLStringsGroup = self.scrollArr;
        }
    } failure:^(NSError *error) {
        
    }];
}
- (void)sendRequestGameData{
    [AFNetHelper GET:GameURL parameters:nil success:^(id responseObject) {
        NSData *data = (NSData *)responseObject;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if ([dic[@"error_msg"] isEqualToString:@"操作成功"]) {
            NSArray *arr = dic[@"content"];
            for (NSInteger i=0; i<arr.count; i++) {
                if (!(i==0||i==3)) {
                    NSDictionary *item = arr[i];
                    GameModel *model = [[GameModel alloc]init];
                    model.title = item[@"title"];
                    for (NSDictionary *element in item[@"lives"]) {
                        GameLiveModel *liveModel = [[GameLiveModel alloc]init];
                        liveModel.name = element[@"name"];
                         liveModel.online_users = [element[@"online_users"] stringValue];
                         liveModel.share_addr = element[@"share_addr"];
                         liveModel.stream_addr = element[@"stream_addr"];
                        liveModel.nick = element[@"creator"][@"nick"];
                        liveModel.uid = element[@"creator"][@"id"];
                        liveModel.roomID = element[@"id"];
                        liveModel.portrait = element[@"creator"][@"portrait"];
                        liveModel.cover = element[@"extra"][@"cover"];
                        [model.liveArr addObject:liveModel];
                    }
                    [self.dataArr addObject:model];
                }
                [gameCollection reloadData];
            }
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
