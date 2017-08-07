//
//  GameCell.h
//  OnlinePlay
//
//  Created by afarsoft on 2017/8/7.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameLiveModel.h"

@interface GameCell : UICollectionViewCell

- (void)configCell:(GameLiveModel *)model;

@end
