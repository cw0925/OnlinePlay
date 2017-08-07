//
//  UIButton+ImageAndTitle.m
//  OnlinePlay
//
//  Created by afarsoft on 2017/7/18.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "UIButton+ImageAndTitle.h"

@implementation UIButton (ImageAndTitle)

- (void)verticalImageAndTitle:(CGFloat)spacing
{
    //self.titleLabel.backgroundColor = [UIColor lightGrayColor];
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    CGSize textSize = [self.titleLabel.text sizeWithAttributes:@{ NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Light" size:15] }];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
}
@end
