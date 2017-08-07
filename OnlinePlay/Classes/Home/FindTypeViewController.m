//
//  FindTypeViewController.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/31.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "FindTypeViewController.h"
#import "FindTypeModel.h"
#import "FindTypeCell.h"
#import "LiveViewController.h"

@interface FindTypeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation FindTypeViewController
{
    UICollectionView *typeCollection;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customNavigationBar:YES leftImage:@"title_button_back" right:NO rightImage:@""];
    self.title = self.navTitle;
    [self initUI];
    [self sendRequestFindTypeData];
}
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}
- (void)initUI{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    typeCollection = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    typeCollection.backgroundColor = [UIColor whiteColor];
    layout.itemSize = CGSizeMake((ViewWidth - 30)/2, 210);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    typeCollection.delegate = self;
    typeCollection.dataSource = self;
    [self.view addSubview:typeCollection];
    
    [typeCollection registerNib:[UINib nibWithNibName:@"FindTypeCell" bundle:nil] forCellWithReuseIdentifier:@"findTypeCell"];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FindTypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"findTypeCell" forIndexPath:indexPath];
    FindTypeModel *model = self.dataArr[indexPath.item];
    [cell configCell:model];
    return cell;
}
- (UIEdgeInsets )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LiveViewController *live = [[LiveViewController alloc]init];
    FindTypeModel *model = self.dataArr[indexPath.item];
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

- (void)sendRequestFindTypeData{
    NSString *url = [NSString stringWithFormat:FindTypeURL,self.tab_key];
    NSLog(@"%@",url);
    [AFNetHelper GET:url parameters:nil success:^(id responseObject) {
        NSData *data = (NSData *)responseObject;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if ([dic[@"error_msg"] isEqualToString:@"操作成功"]) {
            for (NSDictionary *item in dic[@"lives"]) {
                FindTypeModel *model = [[FindTypeModel alloc]init];
                model.nick = item[@"creator"][@"nick"];
                model.portrait = item[@"creator"][@"portrait"];
                model.online_users = [item[@"online_users"] stringValue];
                model.stream_addr = item[@"stream_addr"];
                model.share_addr = item[@"share_addr"];
                model.uid = item[@"creator"][@"id"];
                model.roomID = item[@"id"];
                [self.dataArr addObject:model];
            }
            [typeCollection reloadData];
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
