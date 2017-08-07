//
//  AttentionCell.h
//  OnlinePlay
//
//  Created by afarsoft on 2017/8/1.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AttentionModel.h"

@interface AttentionCell : UICollectionViewCell

@property(nonatomic,strong)void (^btnBlock)();
- (void)congfigCell:(AttentionModel *)model;

@end
