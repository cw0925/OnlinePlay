//
//  GiftCell.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/8/1.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "GiftCell.h"

@interface GiftCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *gold;
@property (weak, nonatomic) IBOutlet UILabel *name;

@end

@implementation GiftCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configCell:(GiftModel *)model{
    [_icon sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@""]];
    _gold.text = model.gold;
    _gold.textColor = [UIColor orangeColor];
    _name.text = model.name;
    _name.textColor = [UIColor whiteColor];
}
@end
