//
//  UsersModel.h
//  OnlinePlay
//
//  Created by afarsoft on 2017/8/1.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "BaseModel.h"

@interface UsersModel : BaseModel

@property(nonatomic,copy)NSString *uid;
@property(nonatomic,copy)NSString *hometown;
@property(nonatomic,copy)NSString *portrait;
@property(nonatomic,copy)NSString *nick;
@property(nonatomic,copy)NSString *veri_info;
@property(nonatomic,copy)NSString *desc;

@end
