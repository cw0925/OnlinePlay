//
//  NewsCell.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/8/2.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "NewsCell.h"

@implementation NewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _icon.layer.cornerRadius = 25;
    _icon.layer.masksToBounds = YES;
    
    _chatBtn.backgroundColor = RGBColor(0, 224, 206);
    [_chatBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //_chatBtn.layer.borderWidth = 1;
    _chatBtn.layer.cornerRadius = 15;
    _chatBtn.layer.masksToBounds = YES;
    _chatBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_chatBtn addTarget:self action:@selector(chatClick:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)chatClick:(UIButton *)sender{
    if (self.btnClickBlock) {
        self.btnClickBlock();
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
