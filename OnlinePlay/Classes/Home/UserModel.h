//
//  UserModel.h
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/18.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "BaseModel.h"
#import "User.h"

@interface UserModel : BaseModel

@property(nonatomic,copy)NSString *reason;
@property(nonatomic,strong)User *user;

@end
