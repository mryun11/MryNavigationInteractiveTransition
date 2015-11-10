//
//  MryNavigationInteractiveTransition.h
//
//  Created by mryun11 on 15/11/5.
//  Copyright © 2015年 mryun11. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UIViewController, UIPercentDrivenInteractiveTransition;
@interface MryNavigationInteractiveTransition : NSObject <UINavigationControllerDelegate>

- (instancetype)initWithViewController:(UIViewController *)vc;
- (void)handleControllerPop:(UIPanGestureRecognizer *)recognizer;
- (UIPercentDrivenInteractiveTransition *)interactivePopTransition;

@end
