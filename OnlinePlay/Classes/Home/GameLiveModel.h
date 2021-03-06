//
//  GameLiveModel.h
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/26.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "BaseModel.h"

@interface GameLiveModel : BaseModel

@property(nonatomic,copy)NSString *nick;
@property(nonatomic,copy)NSString *uid;
@property(nonatomic,copy)NSString *roomID;
@property(nonatomic,copy)NSString *cover;
@property(nonatomic,copy)NSString *portrait;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *online_users;
@property(nonatomic,copy)NSString *share_addr;
@property(nonatomic,copy)NSString *stream_addr;

@end
