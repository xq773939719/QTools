//
//  BaseNavigationController.m
//
//  Created by XQ on 2022/1/24.
//

#if TARGET_OS_IPHONE

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarItem.title = self.viewControllers.firstObject.tabBarTitle;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    [self setHideNavigationBar:YES];
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return self.topViewController;
}

#pragma mark - Origientation

///是否自动旋转
///返回导航控制器的顶层视图控制器的自动旋转属性，因为导航控制器是以栈的原因叠加VC的
///topViewController是其最顶层的视图控制器，
-(BOOL)shouldAutorotate{
    return self.topViewController.shouldAutorotate;
}

/// 支持哪些屏幕方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.topViewController supportedInterfaceOrientations];
}

/// 默认方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return [self.topViewController preferredInterfaceOrientationForPresentation];
}

@end

#endif
