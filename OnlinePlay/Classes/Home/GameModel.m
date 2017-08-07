//
//  GameModel.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/26.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "GameModel.h"

@implementation GameModel
- (NSMutableArray *)liveArr
{
    if (!_liveArr) {
        _liveArr = [NSMutableArray array];
    }
    return _liveArr;
}
@end
