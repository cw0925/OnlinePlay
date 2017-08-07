//
//  GameModel.h
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/26.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "BaseModel.h"

@interface GameModel : BaseModel

@property(nonatomic,copy)NSString *title;
//@property(nonatomic,copy)NSString *cover;
//@property(nonatomic,copy)NSString *portrait;
//@property(nonatomic,copy)NSString *nick;
//@property(nonatomic,copy)NSString *name;
//@property(nonatomic,copy)NSString *desc;
//@property(nonatomic,copy)NSString *stream_addr;
@property(nonatomic,strong)NSMutableArray *liveArr;

@end
