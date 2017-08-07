//
//  PresentTransitionAnimated.m
//  自定义转场动画
//
//  Created by 吴灶洲 on 2016/11/27.
//  Copyright © 2016年 吴灶洲. All rights reserved.
//

#import "PresentTransitionAnimated.h"

@implementation PresentTransitionAnimated
/** 定义动画时间 */
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.3;
}

/** 定义动画效果 */
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //转场的容器图，动画完成之后会消失
    UIView *containerView = transitionContext.containerView;
    UIView *fromView;
    UIView *toView;
    
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    }else{
        fromView = fromViewController.view;
        toView = toViewController.view;
    }
    
    //对应关系
    BOOL isPresent = (toViewController.presentingViewController == fromViewController);
    
    CGRect fromFrame = [transitionContext initialFrameForViewController:fromViewController];
    CGRect toFrame = [transitionContext finalFrameForViewController:toViewController];
    
    if (isPresent) {
        fromView.frame = fromFrame;
        toView.frame = CGRectOffset(toFrame, toFrame.size.width, 0);
    }
    
    if (isPresent) {
        [containerView addSubview:toView];
    }
    
    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:transitionDuration animations:^{
        if (isPresent) {
            toView.frame = toFrame;
            fromView.frame = CGRectOffset(fromFrame, fromFrame.size.width*0.3*-1, 0);
        }
    } completion:^(BOOL finished) {
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        
        if (wasCancelled)
            [toView removeFromSuperview];
        
        [transitionContext completeTransition:!wasCancelled];
    }];
    
    
    
    
}


@end
