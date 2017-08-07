//
//  LiveModel.h
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/18.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "BaseModel.h"

@interface LiveModel : BaseModel

@property(nonatomic,copy)NSString *title;
@property(nonatomic,strong)NSMutableArray *iconArr;
@property(nonatomic,strong)NSMutableArray *userArr;

@end
