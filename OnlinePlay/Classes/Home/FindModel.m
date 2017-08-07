//
//  FindModel.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/25.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "FindModel.h"

@implementation FindModel
- (NSMutableArray *)livesArr
{
    if (!_livesArr) {
        _livesArr = [NSMutableArray array];
    }
    return _livesArr;
}
@end
