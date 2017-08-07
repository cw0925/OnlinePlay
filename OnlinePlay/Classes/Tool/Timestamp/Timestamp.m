//
//  Timestamp.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/19.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "Timestamp.h"

@implementation Timestamp

+ (NSString *)getCurrentDateTimestamp{
    //获取系统时间戳
    NSDate* date1 = [NSDate date];
    NSTimeInterval time1 =[date1 timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f",time1];
    return timeString;
}

@end
