//
//  VideoModel.h
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/25.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "BaseModel.h"

@interface VideoModel : BaseModel

@property(nonatomic,copy)NSString *cover_url;
@property(nonatomic,copy)NSString *link;
@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *portrait;
@property(nonatomic,copy)NSString *likeCount;

@end
