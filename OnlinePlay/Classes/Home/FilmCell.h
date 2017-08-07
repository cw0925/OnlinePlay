//
//  FilmCell.h
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/20.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoModel.h"

@interface FilmCell : UICollectionViewCell
- (void)configCell:(VideoModel *)model;
@end
