//
//  CodewordView.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/24.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "CodewordView.h"
#import "UILabel+LSLabelSize.h"

#define WIDTH self.frame.size.width

@implementation CodewordView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return  self;
}
- (void)setup{
    self.backgroundColor = [UIColor whiteColor];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, WIDTH, 30)];
    title.text = @"映口令";
    title.textAlignment = NSTextAlignmentCenter;
    [self addSubview:title];
    
    UILabel *desc = [[UILabel alloc] init];
    [self addSubview:desc];
    //不限制label的行数
    desc.numberOfLines = 0;
    //desc.backgroundColor = [UIColor lightGrayColor];
    desc.textAlignment = NSTextAlignmentCenter;
    desc.text = @"映口令复制好啦！快去分享给小伙伴吧！";
    desc.font = [UIFont systemFontOfSize:15];
    //固定宽度
    CGFloat width = WIDTH-20;
    //自适应高度，系统默认字号为17
    desc.frame = CGRectMake(10, 50, width, [UILabel heightOfLabelWithString:desc.text sizeOfFont:17 width:width]);
    
    CGFloat height = CGRectGetHeight(desc.frame);
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 50+height+10, WIDTH, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line];
    
    UIButton *weiboBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [weiboBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    weiboBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    weiboBtn.frame = CGRectMake(0, 50+height+1+15,(WIDTH-1)/2, 40);
    [weiboBtn setImage:[UIImage imageNamed:@"room_inshare_timeline_def_weibo"] forState:UIControlStateNormal];
    [weiboBtn setTitle:@"去微博粘贴" forState:UIControlStateNormal];
    [weiboBtn addTarget:self action:@selector(pasteToWeiBoClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:weiboBtn];
    
    UILabel *rowLine = [[UILabel alloc]initWithFrame:CGRectMake((WIDTH-1)/2+1, 50+height+10, 1, 50)];
    rowLine.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:rowLine];
    
    UIButton *wxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    wxBtn.frame = CGRectMake((WIDTH-1)/2+1, 50+height+1+15,(WIDTH-1)/2, 40);
    [wxBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [wxBtn setImage:[UIImage imageNamed:@"room_inshare_timeline_def_weixin"] forState:UIControlStateNormal];
    wxBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [wxBtn setTitle:@"去微信粘贴" forState:UIControlStateNormal];
    [wxBtn addTarget:self action:@selector(pasteToWeiXinClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:wxBtn];
    
    [self setFrame:CGRectMake(0, 0, WIDTH, 80+height+1+30)];
    
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
}
- (void)pasteToWeiBoClick:(UIButton *)sender{
    if (self.btnBlock) {
        self.btnBlock();
    }
}
- (void)pasteToWeiXinClick:(UIButton *)sender{
     [UIPasteboard generalPasteboard].string = @"复制整段信息，打开［映客］可直接看直播，「坏女孩💘」正在郑州市直播 🔑MTUwMDg3NTM4MjMzNzkzNw🔑还没安装映客？点此安装，http://inke.cn";
    NSURL *url = [NSURL URLWithString:@"weixin://"];
    [[UIApplication sharedApplication] openURL:url];
}
@end
