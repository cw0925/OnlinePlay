//
//  AttentionHeaderView.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/8/1.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "AttentionHeaderView.h"

@interface AttentionHeaderView ()
@property (weak, nonatomic) IBOutlet UIButton *hotBtn;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end
@implementation AttentionHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _hotBtn.layer.cornerRadius = 15;
    _hotBtn.layer.masksToBounds = YES;
    _hotBtn.backgroundColor = RGBColor(0, 224, 206);
    [_hotBtn addTarget:self action:@selector(hotClick:) forControlEvents:UIControlEventTouchUpInside];
    _title.backgroundColor = RGBColor(244, 244, 244);;
}
- (void)hotClick:(UIButton *)sender{
    if (self.btnBlock) {
        self.btnBlock();
    }
}
@end
