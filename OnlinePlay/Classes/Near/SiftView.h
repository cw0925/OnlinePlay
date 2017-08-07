//
//  SiftView.h
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/20.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SiftView : UIView

@property(nonatomic,strong)void (^btnClickBlock)();
- (void)remove;
@end
