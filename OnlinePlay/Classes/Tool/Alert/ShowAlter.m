//
//  ShowAlter.m
//  Here
//
//  Created by DUC-apple3 on 16/4/26.
//  Copyright © 2016年 DUC-apple3. All rights reserved.
//

#import "ShowAlter.h"

@implementation ShowAlter

+(void)showAlertToController:(UIViewController *)targetController title:(NSString *)title message:(NSString *)message buttonAction:(NSString *)button buttonBlock:(buttonBlock)buttonBlock {
 UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if (button == nil) {
        button = @"确定";
    }
    UIAlertAction *buttonAction = [UIAlertAction actionWithTitle:button style:UIAlertActionStyleCancel handler:^(UIAlertAction *  action) {
        //  if (buttonBlock) 如果block传值为空，就返回
       if (buttonBlock)  buttonBlock();
    }];
    [alertController addAction:buttonAction];
    [targetController presentViewController:alertController animated:YES completion:nil];
}
+(void)showAlertToController:(UIViewController *)targetController title:(NSString *)title message:(NSString *)message cancelAction:(NSString *)cancel otherAction:(NSString *)other {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction1 = [UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *otherAction1 = [UIAlertAction actionWithTitle:other style:UIAlertActionStyleDefault handler:nil];
    //    // Add the actions.
    [alertController addAction:cancelAction1];
        [alertController addAction:otherAction1];
    [targetController presentViewController:alertController animated:YES completion:nil];
}

+(void)showAlertToController:(UIViewController *)targetController title:(NSString *)title message:(NSString *)message cancelAction:(NSString *)cancel otherAction:(NSString *)other sureBlock:(void (^)(void))sureB cancelBlock:(void(^)(void))cancelB {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction1 = [UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        if (cancelB) {
            //返回按钮方法
            cancelB();
        }
    }];
    UIAlertAction *otherAction1 = [UIAlertAction actionWithTitle:other style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if (sureB) {
            //确定按钮方法
            sureB();
        }
    }];
    //    // Add the actions.
    [alertController addAction:cancelAction1];
    [alertController addAction:otherAction1];
    
    [targetController presentViewController:alertController animated:YES completion:nil];
}

@end
