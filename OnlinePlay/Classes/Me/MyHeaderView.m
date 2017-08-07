


//
//  MyHeaderView.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/20.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "MyHeaderView.h"

#define WIDTH  self.frame.size.width

@implementation MyHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)setup{
    self.backgroundColor = [UIColor whiteColor];
    
    UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 60, 60)];
    [self addSubview:icon];
    if ([userDefault valueForKey:@"icon"]) {
        [icon sd_setImageWithURL:[NSURL URLWithString:[userDefault valueForKey:@"icon"]] placeholderImage:[UIImage imageNamed:@""]];
    }
    
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(90, 20, WIDTH-90, 30)];
    [self addSubview:name];
    if ([userDefault valueForKey:@"nickname"]) {
        name.text = [userDefault valueForKey:@"nickname"];
    }
    
    UIButton *homepage = [UIButton buttonWithType:UIButtonTypeCustom];
    homepage.frame = CGRectMake(WIDTH-100, 50, 100, 30);
    [homepage setTitle:@"查看编辑主页>" forState:UIControlStateNormal];
    homepage.titleLabel.font = [UIFont systemFontOfSize:12];
    [homepage setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    //homepage.backgroundColor = [UIColor whiteColor];
    [self addSubview:homepage];
    
    UILabel *desc = [[UILabel alloc]initWithFrame:CGRectMake(90, 50, WIDTH-190, 30)];
    //desc.backgroundColor = [UIColor yellowColor];
    desc.text = @"映客号：527478701";
    desc.font = [UIFont systemFontOfSize:12];
    desc.textColor = [UIColor lightGrayColor];
    [self addSubview:desc];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 89, WIDTH, 1)];
    line.backgroundColor = RGBColor(239, 239, 239);
    [self addSubview:line];
    
    UIView *attention = [[UIView alloc]initWithFrame:CGRectMake(0, 100, (WIDTH-11)/2, 60)];
    //attention.backgroundColor = [UIColor redColor];
    [self addSubview:attention];
    
    UILabel *attentionNum = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, (WIDTH-11)/2, 20)];
    attentionNum.textAlignment = NSTextAlignmentCenter;
    attentionNum.text = @"2";
    [attention addSubview:attentionNum];
    
    UILabel *attentionDesc = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, (WIDTH-11)/2, 30)];
    attentionDesc.textAlignment = NSTextAlignmentCenter;
    attentionDesc.text = @"我的关注";
    attentionDesc.textColor = [UIColor lightGrayColor];
    [attention addSubview:attentionDesc];
    
    UILabel *clue = [[UILabel alloc]initWithFrame:CGRectMake((WIDTH-11)/2+5, 115, 1, 30)];
    clue.backgroundColor = RGBColor(239, 239, 239);
    [self addSubview:clue];
    
    UIView *fan = [[UIView alloc]initWithFrame:CGRectMake((WIDTH-11)/2+11, 100, (WIDTH-11)/2, 60)];
    //fan.backgroundColor = [UIColor purpleColor];
    [self addSubview:fan];
    
    UILabel *fanNum = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, (WIDTH-11)/2, 20)];
    fanNum.textAlignment = NSTextAlignmentCenter;
    fanNum.text = @"0";
    [fan addSubview:fanNum];
    
    UILabel *fanDesc = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, (WIDTH-11)/2, 30)];
    fanDesc.textAlignment = NSTextAlignmentCenter;
    fanDesc.text = @"我的粉丝";
    fanDesc.textColor = [UIColor lightGrayColor];
    [fan addSubview:fanDesc];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 160, WIDTH, 10)];
    label.backgroundColor = RGBColor(239, 239, 244);
    [self addSubview:label];
}
@end
