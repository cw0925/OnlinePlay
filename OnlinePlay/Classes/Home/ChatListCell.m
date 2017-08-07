//
//  ChatListCell.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/8/2.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "ChatListCell.h"

@implementation ChatListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
