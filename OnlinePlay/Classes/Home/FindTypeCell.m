//
//  FindTypeCell.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/31.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "FindTypeCell.h"

@interface FindTypeCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;

@end
@implementation FindTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configCell:(FindTypeModel *)model{
    [_icon sd_setImageWithURL:[NSURL URLWithString:model.portrait] placeholderImage:[UIImage imageNamed:@""]];
    _name.text = model.nick;
}
@end
