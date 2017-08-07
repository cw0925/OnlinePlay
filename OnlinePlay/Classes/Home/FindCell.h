//
//  FindCell.h
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/24.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindModel.h"

@interface FindCell : UITableViewCell

@property(nonatomic,strong)void (^gestureClickBlock)(NSInteger tag);

- (void)configCell:(FindModel *)model;

@end
