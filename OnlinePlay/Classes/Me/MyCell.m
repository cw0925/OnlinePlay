//
//  MyCell.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/20.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "MyCell.h"

@interface MyCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *desc;

@end
@implementation MyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configCell:(NSIndexPath *)index{
    
    _title.font = [UIFont systemFontOfSize:15];
    _desc.font = [UIFont systemFontOfSize:15];
    _desc.textAlignment = NSTextAlignmentRight;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (index.section == 0) {
        _icon.image = [UIImage imageNamed:@"home_contribute"];
        _title.text = @"映票贡献榜";
        _desc.hidden = YES;
    }else if (index.section == 1){
        if (index.row == 0) {
            _icon.image = [UIImage imageNamed:@"home_video_icon"];
            _title.text = @"视频";
            _desc.hidden = YES;
        }else{
            _icon.image = [UIImage imageNamed:@"home_watch_record_icon"];
            _title.text = @"观看记录";
            _desc.hidden = YES;
        }
    }else if (index.section == 2){
        if (index.row == 0) {
            _icon.image = [UIImage imageNamed:@"home_harvest_icon"];
            _title.text = @"收益";
            _desc.text = @"0映票";
        }else if (index.row == 1){
            _icon.image = [UIImage imageNamed:@"home_account_icon"];
            _title.text = @"账户";
            _desc.text = @"0钻石";
        }else if (index.row == 2){
            _icon.image = [UIImage imageNamed:@"home_level_icon"];
            _title.text = @"等级";
            _desc.text = @"1级";
        }else if (index.row == 3){
            _icon.image = [UIImage imageNamed:@"home_certify_icon"];
            _title.text = @"实名认证";
            _desc.text = @"未认证";
        }else{
            _icon.image = [UIImage imageNamed:@"home_invite_friend_icon"];
            _title.text = @"邀请好友";
            _desc.text = @"赢取映票";
        }
    }else{
        _icon.image = [UIImage imageNamed:@"home_setting_icon"];
        _title.text = @"设置";
        _desc.hidden = YES;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
