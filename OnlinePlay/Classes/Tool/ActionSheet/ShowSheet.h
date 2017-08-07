//
//  ShowSheet.h
//  OnlinePlay
//
//  Created by afarsoft on 2017/8/2.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowSheet : UIAlertController

@property(nonatomic,strong)void (^actionBlock)(NSInteger tag);
- (void)showActionSheetToController:(UIViewController *)targetController actionTitle:(NSArray *)titleArr;

@end
