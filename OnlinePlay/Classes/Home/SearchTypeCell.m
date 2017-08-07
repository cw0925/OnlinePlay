//
//  SearchTypeCell.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/18.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "SearchTypeCell.h"

#define IMGWIDTH (ScreenWidth+50-40)/3

@interface SearchTypeCell ()

@property (weak, nonatomic) IBOutlet UIView *bgview;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;

@end
@implementation SearchTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configCell:(LiveModel *)model{
    for (UIView *view in _scroll.subviews) {
        [view removeFromSuperview];
    }
    self.backgroundColor = RGBColor(239, 239, 244);
    [_moreBtn setTitleColor:RGBColor(0, 224, 206) forState:UIControlStateNormal];
    [_moreBtn addTarget:self action:@selector(moreClick:) forControlEvents:UIControlEventTouchUpInside];
    _bgview.backgroundColor = [UIColor whiteColor];
    _title.text = model.title;
    _scroll.contentSize = CGSizeMake(IMGWIDTH*model.iconArr.count+40, 0);
    for (NSInteger i=0; i<model.iconArr.count; i++) {
        UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(IMGWIDTH*i+10*(i+1), 0, IMGWIDTH, _scroll.frame.size.height-30)];
        [imv sd_setImageWithURL:[NSURL URLWithString:model.iconArr[i]] placeholderImage:[UIImage imageNamed:@""]];
        [_scroll addSubview:imv];
        
        UILabel *desc = [[UILabel alloc]initWithFrame:CGRectMake(IMGWIDTH*i+10*(i+1), _scroll.frame.size.height-25, IMGWIDTH, 20)];
        desc.text = [NSString stringWithFormat:@"%@人",model.userArr[i]];
        [_scroll addSubview:desc];
    }
    
}
- (void)moreClick:(UIButton *)sender{
    if (self.btnBlock) {
        self.btnBlock();
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
