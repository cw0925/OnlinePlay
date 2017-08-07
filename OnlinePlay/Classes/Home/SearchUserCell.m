//
//  SearchUserCell.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/18.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "SearchUserCell.h"

@interface SearchUserCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UIButton *watch;
@property (weak, nonatomic) IBOutlet UIButton *add;

@end

@implementation SearchUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configCell:(UserModel *)model{
    _icon.layer.cornerRadius = _icon.frame.size.width/2;
    _icon.layer.masksToBounds = YES;
    [_icon sd_setImageWithURL:[NSURL URLWithString:model.user.portrait] placeholderImage:[UIImage imageNamed:@"head-blink"]];
    _name.text = model.user.nick;
    _desc.text = model.reason;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
