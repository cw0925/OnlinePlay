//
//  GiftModel.h
//  OnlinePlay
//
//  Created by afarsoft on 2017/8/1.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "BaseModel.h"

@interface GiftModel : BaseModel

@property(nonatomic,copy)NSString *image;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *gold;
@property(nonatomic,copy)NSString *gold_type;

@end
