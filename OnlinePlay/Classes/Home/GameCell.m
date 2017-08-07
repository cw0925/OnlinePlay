//
//  GameCell.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/8/7.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "GameCell.h"

@interface GameCell ()
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UILabel *name;

@end
@implementation GameCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _icon.layer.cornerRadius = 30;
    _icon.layer.masksToBounds = YES;
    
    _desc.font = [UIFont systemFontOfSize:12];
    _desc.textColor = [UIColor whiteColor];
    _name.font = [UIFont systemFontOfSize:11];
}
- (void)configCell:(GameLiveModel *)model{
    [_img sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@""]];
    [_icon sd_setImageWithURL:[NSURL URLWithString:model.portrait] placeholderImage:[UIImage imageNamed:@""]];
    _desc.text = model.name;
    _name.text = model.nick;
    //NSLog(@"mode:%@",model.nick);
}
@end
