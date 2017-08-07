//
//  FilmCell.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/20.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "FilmCell.h"

@interface FilmCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imv;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *users;

@end
@implementation FilmCell

- (void)configCell:(VideoModel *)model{
    if (model.cover_url) {
        [_imv sd_setImageWithURL:[NSURL URLWithString:model.cover_url] placeholderImage:[UIImage imageNamed:@""]];
    }else{
        [_imv sd_setImageWithURL:[NSURL URLWithString:model.portrait] placeholderImage:[UIImage imageNamed:@""]];
    }
    _name.text = model.nickname;
    _users.text = model.likeCount;
    //NSLog(@"%@",model.portrait);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
