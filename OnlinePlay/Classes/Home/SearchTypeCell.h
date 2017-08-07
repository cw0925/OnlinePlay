//
//  SearchTypeCell.h
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/18.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveModel.h"

@interface SearchTypeCell : UITableViewCell

@property(nonatomic,strong)void (^btnBlock)();

- (void)configCell:(LiveModel *)model;
@end
