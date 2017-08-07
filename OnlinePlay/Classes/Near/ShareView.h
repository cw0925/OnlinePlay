//
//  ShareView.h
//  OnlinePlay
//
//  Created by CW on 2017/7/22.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareView : UIView

@property(nonatomic,strong)void (^btnBlock)(NSInteger tag);

@end
