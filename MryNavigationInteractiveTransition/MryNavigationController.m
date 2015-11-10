//
//  MryNavigationController.m
//  MryNavigationInteractiveTransition
//
//  Created by mryun11 on 15/11/6.
//  Copyright © 2015年 mryun11. All rights reserved.
//

#import "MryNavigationController.h"
#import "MryNavigationInteractiveTransition.h"

@interface MryNavigationController ()<UIGestureRecognizerDelegate>

@property (nonatomic, weak) UIPanGestureRecognizer *popRecognizer;

@property (nonatomic, strong) MryNavigationInteractiveTransition *navT;

@end

@interface UINavigationController (Ges)

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch;

@end

@implementation MryNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.enabled = NO;
    
    UIPanGestureRecognizer *popRecognizer = [[UIPanGestureRecognizer alloc] init];
    popRecognizer.delegate = self;
    popRecognizer.maximumNumberOfTouches = 1;
    [self.view addGestureRecognizer:popRecognizer];
    
    _navT = [[MryNavigationInteractiveTransition alloc] initWithViewController:self];
    [popRecognizer addTarget:_navT action:@selector(handleControllerPop:)];
    
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 注意：只有非根控制器才有滑动返回功能，根控制器没有。
    // 判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器
    
    return self.viewControllers.count != 1;
}

@end
