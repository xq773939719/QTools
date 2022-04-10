//
//  BaseTabBarController.m
//
//  Created by XQ on 2022/1/24.
//

#if TARGET_OS_IPHONE

#import "BaseTabBarController.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.hideNavigationBar = YES;
        self.hideTabBar = NO;
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    LoggerInfo(@"[%@][%s]-> %@", [self class], __func__, self.params);
    self.navigationController.navigationBar.hidden = self.hideNavigationBar;
    self.tabBarController.tabBar.hidden = self.hideTabBar;
}

#pragma mark - Origientation

/// 是否自动旋转
-(BOOL)shouldAutorotate{
    return self.selectedViewController.shouldAutorotate;
}

/// 支持哪些屏幕方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.selectedViewController supportedInterfaceOrientations];
}

/// 默认方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return [self.selectedViewController preferredInterfaceOrientationForPresentation];
}


@end

#endif
