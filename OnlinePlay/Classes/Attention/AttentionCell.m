//
//  AttentionCell.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/8/1.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "AttentionCell.h"

@interface AttentionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIButton *attentionBtn;
@property (weak, nonatomic) IBOutlet UILabel *live;
@property (weak, nonatomic) IBOutlet UILabel *users;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@end
@implementation AttentionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)congfigCell:(AttentionModel *)model{
    self.backgroundColor = [UIColor whiteColor];
    
    _live.layer.borderColor = [UIColor whiteColor].CGColor;
    _live.layer.borderWidth = 1;
    _live.layer.cornerRadius = 10;
    _live.layer.masksToBounds = YES;
    _live.backgroundColor = RGBColor(84, 82, 81);
    
    _attentionBtn.backgroundColor = RGBColor(0, 224, 206);
    _attentionBtn.layer.cornerRadius = 15;
    _attentionBtn.layer.masksToBounds = YES;
    [_attentionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    _name.font = [UIFont systemFontOfSize:13];
    
    [_icon sd_setImageWithURL:[NSURL URLWithString:model.portrait] placeholderImage:[UIImage imageNamed:@""]];
    _name.text = model.nick;
    [_attentionBtn addTarget:self action:@selector(attentionClick:) forControlEvents:UIControlEventTouchUpInside];
    _users.text = model.online_users;
    
    [_deleteBtn addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)attentionClick:(UIButton *)sender{
    sender.layer.borderWidth = 1;
    sender.backgroundColor = [UIColor whiteColor];
    sender.layer.borderColor = RGBColor(0, 224, 206).CGColor;
    [sender setTitle:@"已关注" forState:UIControlStateNormal];
    [sender setTitleColor:RGBColor(0, 224, 206) forState:UIControlStateNormal];
}
- (void)deleteClick:(UIButton *)sender{
    if (self.btnBlock) {
        self.btnBlock();
    }
}
@end
