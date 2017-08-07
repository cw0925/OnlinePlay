//
//  ShowAlter.h
//  Here
//
//  Created by DUC-apple3 on 16/4/26.
//  Copyright © 2016年 DUC-apple3. All rights reserved.
//

#import <UIKit/UIKit.h>
// 第一个void 返回值
// 第二个void  参数
typedef void (^buttonBlock)(void);
@interface ShowAlter : UIAlertController
//封装提示框
/**单个按钮的提示框**/
+(void)showAlertToController:(UIViewController *)targetController title:(NSString *)title message:(NSString *)message buttonAction:(NSString *)button buttonBlock:(buttonBlock)buttonBlock;
/**无返回方法的提示框**/
+(void)showAlertToController:(UIViewController *)targetController title:(NSString *)title message:(NSString *)message cancelAction:(NSString *)cancel otherAction:(NSString *)other;
/**带返回方法的提示框**/
+(void)showAlertToController:(UIViewController *)targetController title:(NSString *)title message:(NSString *)message cancelAction:(NSString *)cancel otherAction:(NSString *)other sureBlock:(void (^)(void))sureB cancelBlock:(void(^)(void))cancelB;
@end
