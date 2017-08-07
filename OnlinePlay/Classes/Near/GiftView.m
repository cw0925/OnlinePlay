//
//  GiftView.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/8/1.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "GiftView.h"
#import "GiftCell.h"
#import "GiftModel.h"

@interface GiftView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation GiftView
{
    UICollectionView *giftCollection;
    UIPageControl *page;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        [self sendRequestGiftData];
    }
    return self;
}
- (void)setup{
    self.backgroundColor = RGBAColor(44, 34, 45, 0.9);
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(self.frame.size.width/4, 120);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    giftCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 250) collectionViewLayout:layout];
    giftCollection.delegate = self;
    giftCollection.dataSource = self;
    giftCollection.pagingEnabled = YES;
    giftCollection.showsHorizontalScrollIndicator = NO;
    giftCollection.backgroundColor = [UIColor clearColor];
    [self addSubview:giftCollection];
    
    [giftCollection registerNib:[UINib nibWithNibName:@"GiftCell" bundle:nil] forCellWithReuseIdentifier:@"giftCell"];
    
    page = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 250, self.frame.size.width, 10)];
    //page.backgroundColor = [UIColor whiteColor];
    [self addSubview:page];
    
    UIButton *topup = [UIButton buttonWithType:UIButtonTypeCustom];
    topup.frame = CGRectMake(10, 260, 60, 30);
    [topup setTitle:@"充值>" forState:UIControlStateNormal];
    [topup setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self addSubview:topup];
    
    UIButton *send = [UIButton buttonWithType:UIButtonTypeCustom];
    send.frame = CGRectMake(self.frame.size.width-90, 260, 80, 30);
    [send setTitle:@"发送" forState:UIControlStateNormal];
    [send setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    send.backgroundColor = RGBColor(0, 224, 206);
    [self addSubview:send];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger i = (NSInteger)scrollView.contentOffset.x/self.frame.size.width;
    page.currentPage = i;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //NSLog(@"%d",self.dataArr.count);
    return self.dataArr.count;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 0, 0, 0);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GiftCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"giftCell" forIndexPath:indexPath];
    GiftModel *model = self.dataArr[indexPath.item];
    [cell configCell:model];
    return cell;
}
- (void)sendRequestGiftData{
    [AFNetHelper GET:GiftURL parameters:nil success:^(id responseObject) {
        NSData *data = (NSData *)responseObject;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if ([dic[@"error_msg"] isEqualToString:@"操作成功"]) {
            for (NSDictionary *item in dic[@"gifts"]) {
                GiftModel *model = [[GiftModel alloc]init];
                model.gold = [item[@"gold"] stringValue];
                model.gold_type = [item[@"gold"] stringValue];
                model.name = item[@"name"];
                model.image = item[@"image"];
                [self.dataArr addObject:model];
            }
            if (self.dataArr.count%8==0) {
                page.numberOfPages = self.dataArr.count/8;
                //giftCollection.contentSize = CGSizeMake(self.frame.size.width*self.dataArr.count, 0);
            }else{
                page.numberOfPages = self.dataArr.count/8+1;
               // giftCollection.contentSize = CGSizeMake(self.frame.size.width*(self.dataArr.count+1), 0);
            }
            [giftCollection reloadData];
            
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
