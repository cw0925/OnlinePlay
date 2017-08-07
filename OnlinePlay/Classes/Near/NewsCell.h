//
//  NewsCell.h
//  OnlinePlay
//
//  Created by afarsoft on 2017/8/2.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsCell : UITableViewCell

@property(nonatomic,strong)void (^btnClickBlock)();
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIButton *chatBtn;

@end
