//
//  ShowSheet.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/8/2.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "ShowSheet.h"

@interface ShowSheet ()

@end

@implementation ShowSheet

- (void)showActionSheetToController:(UIViewController *)targetController actionTitle:(NSArray *)titleArr  {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (NSInteger i=0; i<titleArr.count; i++) {
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:titleArr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (self.actionBlock) {
                self.actionBlock(i);
            }
        }];
        [alertController addAction:alertAction];
    }
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *  action) {
        //  if (buttonBlock) 如果block传值为空，就返回
    }];
    [alertController addAction:cancleAction];
    [targetController presentViewController:alertController animated:YES completion:nil];
}
@end
