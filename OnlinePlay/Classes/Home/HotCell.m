//
//  HotCell.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/25.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "HotCell.h"

@interface HotCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *users;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *online;

@end
@implementation HotCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configCell:(HotModel *)model{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_scroll.subviews>0) {
        for (UIView *view in _scroll.subviews) {
            [view removeFromSuperview];
        }
    }
    _icon.layer.cornerRadius = _icon.frame.size.width/2;
    _icon.layer.masksToBounds = YES;
    //_scroll.backgroundColor = [UIColor yellowColor];
    [_icon sd_setImageWithURL:[NSURL URLWithString:model.portrait] placeholderImage:[UIImage imageNamed:@""]];
    [_img sd_setImageWithURL:[NSURL URLWithString:model.portrait] placeholderImage:[UIImage imageNamed:@""]];
    _name.text = model.nick;
    _users.textColor = [UIColor orangeColor];
    _users.text = [NSString stringWithFormat:@"%@在看",model.online_users];
    
    CGFloat width = (self.frame.size.width-80)/5;
    _scroll.contentSize = CGSizeMake((width+10)*model.tabArr.count, 0);
    for (NSInteger i = 0; i < model.tabArr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((width+10)*i, 3, width, 20);
        btn.layer.cornerRadius = 12;
        btn.layer.masksToBounds = YES;
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = RGBColor(0, 224, 206).CGColor;
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn setTitleColor:RGBColor(0, 224, 206) forState:UIControlStateNormal];
        [btn setTitle:model.tabArr[i] forState:UIControlStateNormal];
        [_scroll addSubview:btn];
    }
    _online.layer.cornerRadius = 10;
    _online.layer.masksToBounds = YES;
    _online.backgroundColor = RGBAColor(0, 0, 0, 0.1);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
