

//
//  ShareView.m
//  OnlinePlay
//
//  Created by CW on 2017/7/22.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "ShareView.h"
#import "UIButton+EdgeInsets.h"

#define WIDTH self.frame.size.width
#define HIGHT self.frame.size.height

@implementation ShareView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)setup{
    self.backgroundColor = [UIColor whiteColor];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 60, 30)];
    title.text = @"分享";
    [self addSubview:title];
    
    UILabel *desc = [[UILabel alloc]initWithFrame:CGRectMake(70, 5, WIDTH-80, 30)];
    desc.textAlignment = NSTextAlignmentRight;
    desc.text = @"分享吧~邀请好友注册，赢取映票";
    desc.font = [UIFont systemFontOfSize:12];
    [self addSubview:desc];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, WIDTH-20, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line];
    
    UIView *share = [[UIView alloc]initWithFrame:CGRectMake(0, 50, WIDTH, HIGHT-50)];
    [self addSubview:share];
    
    NSArray *titleArr = @[@"朋友圈",@"微信",@"微博",@"QQ",@"QQ空间",@"映口令",@"复制链接",@"录屏"];
    NSArray *iconArr = @[@"room_inshare_timeline_def_pengyouquan",@"room_inshare_timeline_def_weixin",@"room_inshare_timeline_def_weibo",@"room_inshare_timeline_def_qq",@"room_inshare_timeline_def_kongjian",@"room_inshare_timeline_def_yingkouling",@"copy_icon",@"room_bottom_share_record_button"];
    for (NSInteger i=0; i<8; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:iconArr[i]] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        btn.frame = CGRectMake(WIDTH/4*(i%4), (HIGHT-50)/2*(i/4), WIDTH/4, (HIGHT-50)/2);
        btn.tag = 100+i;
        [btn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageTop imageTitlespace:10];
        [btn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
        [share addSubview:btn];
    }
}
- (void)shareClick:(UIButton *)sender{
    if (self.btnBlock) {
        self.btnBlock(sender.tag);
    }
}
@end
