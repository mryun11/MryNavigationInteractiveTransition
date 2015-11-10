//
//  MryPopAnimation.m
//
//  Created by mryun11 on 15/11/5.
//  Copyright © 2015年 mryun11. All rights reserved.
//

#import "MryPopAnimation.h"

@interface MryPopAnimation ()
@property (nonatomic, strong) id <UIViewControllerContextTransitioning> transitionContext;
@end

@implementation MryPopAnimation

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    //这个方法返回动画执行的时间
    return 0.25f;
}

/**
 *  transitionContext你可以看作是一个工具，用来获取一系列动画执行相关的对象，并且通知系统动画是否完成等功能。
 */
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    /**
     *  获取动画来自的那个控制器
     */
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    /**
     *  边界阴影效果
     */
    fromViewController.view.layer.shadowColor = [UIColor blackColor].CGColor;
    fromViewController.view.layer.shadowRadius = 5;
    fromViewController.view.layer.shadowOpacity = 0.7f;
    /**
     *  获取转场到的那个控制器
     */
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    /**
     *  背景加深效果
     */
    toViewController.view.alpha = 0.7f;
    
    /**
     *  转场动画是两个控制器视图时间的动画，需要一个containerView来作为一个“舞台”，让动画执行。
     */
    UIView *containerView = [transitionContext containerView];
    [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
    
    //模拟系统动画
    CATransform3D t = CATransform3DMakeTranslation(- [UIScreen mainScreen].bounds.size.width / 3,0,0);
    
    [self setAnchorPoint:CGPointMake(0.0, 0.5) forView:toViewController.view];
    [self setAnchorPoint:CGPointMake(1.0, 0.5) forView:fromViewController.view];
    
    toViewController.view.layer.transform = t;
    
    /**
     *  执行动画，我们让fromVC的视图移动到屏幕最右侧
     */
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toViewController.view.layer.transform = CATransform3DIdentity;
        toViewController.view.alpha = 1.f;
        fromViewController.view.transform = CGAffineTransformMakeTranslation([UIScreen mainScreen].bounds.size.width, 0);
    }completion:^(BOOL finished) {
        /**
         *  当你的动画执行完成，这个方法必须要调用，否则系统会认为你的其余任何操作都在动画执行过程中。
         */
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
    
}

#pragma mark - Helper Methods

- (void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view {
    CGPoint oldOrigin = view.frame.origin;
    view.layer.anchorPoint = anchorPoint;
    CGPoint newOrigin = view.frame.origin;
    
    CGPoint transition;
    transition.x = newOrigin.x - oldOrigin.x;
    transition.y = oldOrigin.y - oldOrigin.y;
    
    view.center = CGPointMake (view.center.x - transition.x, view.center.y - transition.y);
}

@end
