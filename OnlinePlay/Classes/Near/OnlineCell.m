//
//  OnlineCell.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/19.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "OnlineCell.h"

@interface OnlineCell ()
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end

@implementation OnlineCell

- (void)configCell:(OnlineModel *)model{
    _img.layer.cornerRadius = 5;
    _img.layer.masksToBounds = YES;
    [_img sd_setImageWithURL:[NSURL URLWithString:model.portrait] placeholderImage:[UIImage imageNamed:@""]];
    _title.text = model.distance;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
