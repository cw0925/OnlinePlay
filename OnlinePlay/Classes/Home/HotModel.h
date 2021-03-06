//
//  HotModel.h
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/25.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "BaseModel.h"

@interface HotModel : BaseModel

@property(nonatomic,copy)NSString *uid;
@property(nonatomic,copy)NSString *nick;
@property(nonatomic,copy)NSString *portrait;
@property(nonatomic,copy)NSString *city;
@property(nonatomic,copy)NSString *online_users;
@property(nonatomic,copy)NSString *share_addr;
@property(nonatomic,copy)NSString *stream_addr;
@property(nonatomic,copy)NSMutableArray *tabArr;

@end
