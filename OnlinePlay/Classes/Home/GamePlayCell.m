//
//  GamePlayCell.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/8/7.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "GamePlayCell.h"
#import <IJKMediaFramework/IJKMediaFramework.h>

@interface GamePlayCell ()

@property (atomic, retain) id <IJKMediaPlayback> player;
@property (weak, nonatomic) UIView *PlayerView;

@end
@implementation GamePlayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configCell:(GameLiveModel *)model{
    //直播视频
    NSString *url = [model.stream_addr stringByReplacingOccurrencesOfString:@"pzsp" withString:@"http"];
    _player = [[IJKFFMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:url] withOptions:nil];
    NSLog(@"加载--:%@",model.stream_addr);
    
    UIView *playerView = [self.player view];
    
    UIView *displayView = [[UIView alloc] initWithFrame:self.frame];
    self.PlayerView = displayView;
    //self.PlayerView.backgroundColor = [UIColor blackColor];
    [self addSubview:self.PlayerView];
    
    playerView.frame = self.PlayerView.bounds;
    playerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.PlayerView insertSubview:playerView atIndex:1];
    [_player setScalingMode:IJKMPMovieScalingModeAspectFill];
    // [self installMovieNotificationObservers];
    
    if (![self.player isPlaying]) {
        [self.player prepareToPlay];
        [self.player play];
    }else{
        [self.player pause];
    }
}
@end
