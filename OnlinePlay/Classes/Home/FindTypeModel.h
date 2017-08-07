//
//  FindTypeModel.h
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/31.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "BaseModel.h"

@interface FindTypeModel : BaseModel

@property(nonatomic,copy)NSString *nick;
@property(nonatomic,copy)NSString *portrait;
@property(nonatomic,copy)NSString *online_users;
@property(nonatomic,copy)NSString *share_addr;
@property(nonatomic,copy)NSString *stream_addr;
@property(nonatomic,copy)NSString *uid;
@property(nonatomic,copy)NSString *roomID;

@end
