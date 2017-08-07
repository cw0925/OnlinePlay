//
//  UserInfoView.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/8/1.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "UserInfoView.h"
#import "UIView+ParentController.h"
#import "ShowSheet.h"
#import "ToastView.h"

@implementation UserInfoView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)setup{
    self.backgroundColor = [UIColor whiteColor];
    UIButton *report = [UIButton buttonWithType:UIButtonTypeCustom];
    report.frame = CGRectMake(5, 5, 60, 30);
    [report setTitle:@"举报" forState:UIControlStateNormal];
    report.titleLabel.font = [UIFont systemFontOfSize:15];
    [report setTitleColor:RGBColor(172, 64, 224) forState:UIControlStateNormal];
    [report addTarget:self action:@selector(reportClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:report];
    
    UIButton *close = [UIButton buttonWithType:UIButtonTypeCustom];
    close.frame = CGRectMake(self.frame.size.width-40, 5, 30, 30);
    [close setBackgroundImage:[UIImage imageNamed:@"shortvideo_launch_close"] forState:UIControlStateNormal];
    [close addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:close];
    
    UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width/2-30, 40, 60, 60)];
    icon.layer.cornerRadius = 30;
    icon.layer.masksToBounds = YES;
    self.icon = icon;
    [self addSubview:icon];
    
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, self.frame.size.width, 30)];
    name.textAlignment = NSTextAlignmentCenter;
    self.name = name;
    [self addSubview:name];
    
    UILabel *ID = [[UILabel alloc]initWithFrame:CGRectMake(0, 130, self.frame.size.width, 30)];
    ID.textAlignment = NSTextAlignmentCenter;
    ID.font = [UIFont systemFontOfSize:13];
    self.ID = ID;
    [self addSubview:ID];
    
    UILabel *desc = [[UILabel alloc]initWithFrame:CGRectMake(0, 160, self.frame.size.width, 30)];
    desc.textAlignment = NSTextAlignmentCenter;
    [self addSubview:desc];
    self.desc = desc;
    
    UIView *tabView = [[UIView alloc]initWithFrame:CGRectMake(20, 190, self.frame.size.width-40, 30)];
    tabView.backgroundColor = [UIColor greenColor];
    [self addSubview:tabView];
    
    CGFloat width = (tabView.frame.size.width-40)/3;
    for (NSInteger i=0; i<3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(10*(i+1)+width*i, 0, width, 30);
        btn.backgroundColor = [UIColor purpleColor];
        [tabView addSubview:btn];
    }
    
    UILabel *foucs = [[UILabel alloc]initWithFrame:CGRectMake(0, 230, self.frame.size.width/2, 30)];
    foucs.text = @"关注:4";
    foucs.textColor = [UIColor lightGrayColor];
    foucs.textAlignment = NSTextAlignmentCenter;
    foucs.font = [UIFont systemFontOfSize:13];
    [self addSubview:foucs];
    
    UILabel *fans = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2, 230, self.frame.size.width/2, 30)];
    fans.text = @"粉丝:2";
    fans.textColor = [UIColor lightGrayColor];
    fans.font = [UIFont systemFontOfSize:13];
    fans.textAlignment = NSTextAlignmentCenter;
    [self addSubview:fans];
    
    UILabel *receive = [[UILabel alloc]initWithFrame:CGRectMake(0, 260, self.frame.size.width/2, 30)];
    receive.text = @"送出:0";
    receive.textColor = [UIColor orangeColor];
    receive.font = [UIFont systemFontOfSize:13];
    receive.textAlignment = NSTextAlignmentCenter;
    [self addSubview:receive];
    
    UILabel *ticket = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2, 260, self.frame.size.width/2, 30)];
    ticket.text = @"映票:791";
    ticket.textColor = [UIColor orangeColor];
    ticket.font = [UIFont systemFontOfSize:13];
    ticket.textAlignment = NSTextAlignmentCenter;
    [self addSubview:ticket];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(10, self.frame.size.height-51, self.frame.size.width-20, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line];
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-50, self.frame.size.width, 50)];
    [self addSubview:bottomView];
    
    NSArray *arr = @[@"关注",@"私信",@"@TA",@"主页"];
    for (NSInteger i = 0; i<4; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(self.frame.size.width/4*i, 5, self.frame.size.width/4, 40);
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:RGBColor(186, 153, 244) forState:UIControlStateNormal];
        [bottomView addSubview:btn];
    }
}
//关闭
- (void)closeClick:(UIButton *)sender{
    [self.superview removeFromSuperview];
}
//举报
- (void)reportClick:(UIButton *)sender{
    NSArray *arr = @[@"去12318网站举报",@"政治谣言",@"色情低俗",@"未成年人",@"驾驶吸烟",@"商业广告",@"其他"];
    ShowSheet *sheet = [[ShowSheet alloc]init];
    [sheet showActionSheetToController:[self parentController] actionTitle:arr];
    sheet.actionBlock = ^(NSInteger tag) {
        
        ToastView *toastView = [[ToastView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
        toastView.toast.text = @"我们已经收到你的举报，感谢你的举报！";
        [[self parentController].view addSubview:toastView];
    };
}
@end
