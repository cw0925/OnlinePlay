//
//  FilmViewController.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/17.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "FilmViewController.h"
#import "FilmCell.h"
#import "VideoModel.h"

@interface FilmViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation FilmViewController
{
    UICollectionView *filmCollection;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    [self sendRequestFilmData];
}
- (void)initUI{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((ViewWidth-2)/2, (ViewHeight-2)/2.6 );
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    filmCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight-64-50) collectionViewLayout:layout];
    filmCollection.delegate = self;
    filmCollection.dataSource = self;
    filmCollection.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:filmCollection];
    
    [filmCollection registerNib:[UINib nibWithNibName:@"FilmCell" bundle:nil] forCellWithReuseIdentifier:@"filmCell"];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FilmCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"filmCell" forIndexPath:indexPath];
    VideoModel *model = self.dataArr[indexPath.item];
    [cell configCell:model];
    return cell;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)sendRequestFilmData{
    [AFNetHelper GET:VideoURL parameters:nil success:^(id responseObject) {
        NSData *data = (NSData *)responseObject;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if ([dic[@"error_msg"] isEqualToString:@"操作成功"]) {
            for (NSDictionary *item in dic[@"feeds"]) {
                VideoModel *model = [[VideoModel alloc]init];
                [model setValuesForKeysWithDictionary:item];
                //NSLog(@"--:%@",model.portrait);
                [self.dataArr addObject:model];
            }
            [filmCollection reloadData];
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
