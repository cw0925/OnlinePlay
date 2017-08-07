//
//  User.h
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/18.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "BaseModel.h"

@interface User : BaseModel

@property(nonatomic,copy)NSString *nick;
@property(nonatomic,copy)NSString *portrait;

@end
