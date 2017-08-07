//
//  HotModel.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/25.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "HotModel.h"

@implementation HotModel
- (NSMutableArray *)tabArr
{
    if (!_tabArr) {
        _tabArr = [NSMutableArray array];
    }
    return _tabArr;
}
@end
