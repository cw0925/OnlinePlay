//
//  LiveModel.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/18.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "LiveModel.h"

@implementation LiveModel
- (NSMutableArray *)iconArr
{
    if (!_iconArr) {
        _iconArr = [NSMutableArray array];
    }
    return _iconArr;
}
- (NSMutableArray *)userArr
{
    if (!_userArr) {
        _userArr = [NSMutableArray array];
    }
    return _userArr;
}
@end
