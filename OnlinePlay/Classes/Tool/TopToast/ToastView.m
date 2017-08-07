//
//  ToastView.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/8/2.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "ToastView.h"

@implementation ToastView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)setup{
    UILabel *toast = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 64)];
    toast.backgroundColor = RGBColor(0, 164, 238);
    //toast.text = @"复制链接成功，快去分享吧";
    toast.textColor = [UIColor whiteColor];
    toast.font = [UIFont systemFontOfSize:13];
    toast.textAlignment = NSTextAlignmentCenter;
    [self addSubview:toast];
    self.toast = toast;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
}
@end
