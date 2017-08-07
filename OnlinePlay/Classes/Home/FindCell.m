//
//  FindCell.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/24.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "FindCell.h"
#import "LivesModel.h"

#define width (self.frame.size.width-60)/2.5
#define height self.frame.size.height

@interface FindCell ()

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;

@end

@implementation FindCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configCell:(FindModel *)model{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_scroll.subviews.count>0) {
        for (UIView *view in _scroll.subviews) {
            [view removeFromSuperview];
        }
    }
    _title.text = model.title;
    _desc.text = model.desc;
    _scroll.contentSize = CGSizeMake(width*model.livesArr.count+60, 0);
    //NSLog(@"%d",model.livesArr.count);
    for (NSInteger i = 0; i<model.livesArr.count; i++) {
        LivesModel *liveModel = model.livesArr[i];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10*(i+1)+width*i, 0, width,height)];
        view.tag = i;
        [_scroll addSubview:view];
        
        UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, 130)];
        [imv sd_setImageWithURL:[NSURL URLWithString:liveModel.portrait] placeholderImage:[UIImage imageNamed:@""]];
        [view addSubview:imv];
        
        UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(10, 130, width-20, 20)];
        name.text = liveModel.nick;
        name.font = [UIFont systemFontOfSize:12];
        [view addSubview:name];
        
        UILabel *description = [[UILabel alloc]initWithFrame:CGRectMake(10, 150, width-20, 20)];
        description.text = liveModel.desc;
        description.font = [UIFont systemFontOfSize:10];
        [view addSubview:description];
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(liveClick:)];
        view.userInteractionEnabled = YES;
        [view addGestureRecognizer:gesture];
    }
    
}
- (void)liveClick:(UITapGestureRecognizer *)gesture{
    if (self.gestureClickBlock) {
        self.gestureClickBlock(gesture.view.tag);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
