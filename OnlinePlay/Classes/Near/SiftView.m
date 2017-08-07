//
//  SiftView.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/20.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "SiftView.h"

#define WIDTH  self.frame.size.width

@implementation SiftView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return  self;
}
- (void)setup{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 220)];
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view];
    
    UILabel *sex = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 40)];
    sex.textColor = [UIColor lightGrayColor];
    sex.text = @"   性别";
    [view addSubview:sex];
    
    UIView *sexView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, WIDTH, 40)];
    [view addSubview:sexView];
    
    CGFloat btnWidth = (WIDTH - 100)/3;
    
    for (NSInteger i = 0; i < 3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(20+30*i+btnWidth*i, 5, btnWidth, 30);
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sexView addSubview:btn];
        [btn addTarget:self action:@selector(sexClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            [btn setTitle:@"全部" forState:UIControlStateNormal];
        }else if (i == 1){
            [btn setImage:[UIImage imageNamed:@"female_normal"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"female_select"] forState:UIControlStateSelected];
            [btn setTitle:@"女" forState:UIControlStateNormal];
        }else if (i == 2){
            [btn setImage:[UIImage imageNamed:@"male_normal"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"male_select"] forState:UIControlStateSelected];
            [btn setTitle:@"男" forState:UIControlStateNormal];
        }
    }
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, WIDTH, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:line];
    
    UILabel *time = [[UILabel alloc]initWithFrame:CGRectMake(0, 81, WIDTH, 40)];
    time.text = @"  活跃时间";
    time.textColor = [UIColor lightGrayColor];
    [view addSubview:time];
    
    UIView *timeView = [[UIView alloc]initWithFrame:CGRectMake(0, 121, WIDTH, 40)];
    //timeView.backgroundColor = [UIColor purpleColor];
    [view addSubview:timeView];
    
    CGFloat btnW = (WIDTH-50)/4;
    NSArray *arr = @[@"15分钟",@"2小时",@"1天",@"7天"];
    for (NSInteger i = 0; i<4; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(10*(i+1)+btnW*i, 5, btnW, 30);
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [timeView addSubview:btn];
        [btn addTarget:self action:@selector(timeClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIButton *finish = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    finish.frame = CGRectMake(20, 171, WIDTH-40, 40);
    finish.layer.borderWidth = 1;
    finish.layer.borderColor = RGBColor(0, 224, 206).CGColor;
    finish.layer.cornerRadius = 20;
    finish.layer.masksToBounds = YES;
    [finish setTitleColor:RGBColor(0, 224, 206) forState:UIControlStateNormal];
    [finish setTitle:@"完成" forState:UIControlStateNormal];
    [finish addTarget:self action:@selector(finishClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:finish];
}
- (void)sexClick:(UIButton *)sender{
    
}
- (void)timeClick:(UIButton *)sender{
    
}
- (void)finishClick:(UIButton *)sender{
    if (self.btnClickBlock) {
        self.btnClickBlock();
    }
}
- (void)remove{
    [self removeFromSuperview];
}
@end
