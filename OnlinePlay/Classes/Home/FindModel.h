//
//  FindModel.h
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/25.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "BaseModel.h"

@interface FindModel : BaseModel

@property(nonatomic,copy)NSString *desc;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,strong)NSMutableArray *livesArr;
@property(nonatomic,copy)NSString *tab_key;

@end
