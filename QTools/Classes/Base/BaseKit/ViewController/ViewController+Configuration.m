//
//  ViewController+Configuration.m
//
//  Created by XQ on 2022/1/22.
//

#import "ViewController+Configuration.h"

#import <objc/runtime.h>

static NSString *viewControllerNameKey = @"viewControllerNameKey";
static NSString *paramsKey = @"paramsKey";

#if TARGET_OS_IPHONE

static NSString *hideStatusBarKey = @"hideStatusBar";
static NSString *statusStyleKey = @"statusStyle";

static NSString *hideTabBarKey = @"hideTabBar";
static NSString *tabBarTitleKey = @"tabBarTitleKey";
static NSString *tabBarIconKey = @"tabBarIconKey";

static NSString *hideNavigationBarKey = @"hideNavigationBar";
static NSString *navigationTitleKey = @"navigationTitleKey";

#endif

@implementation VIEW_CONTROLLER (Configuration)

#pragma mark - ViewController

- (void)setViewControllerName:(NSString *)viewControllerName {
    objc_setAssociatedObject(self, &viewControllerNameKey, viewControllerName, OBJC_ASSOCIATION_RETAIN);
}

- (NSString *)viewControllerName {
    return objc_getAssociatedObject(self, &viewControllerNameKey);
}

- (void)setParams:(NSDictionary *)params {
    objc_setAssociatedObject(self, &paramsKey, params, OBJC_ASSOCIATION_RETAIN);
}

- (NSDictionary *)params {
    return objc_getAssociatedObject(self, &paramsKey);
}

#if TARGET_OS_IPHONE

#pragma mark - 状态栏

- (void)setHideStatusBar:(BOOL)hideStatusBar {
    objc_setAssociatedObject(self, &hideStatusBarKey, @(hideStatusBar), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)hideStatusBar {
    return [objc_getAssociatedObject(self, &hideStatusBarKey) boolValue];
}

- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle {
    objc_setAssociatedObject(self, &statusStyleKey, @(statusBarStyle), OBJC_ASSOCIATION_ASSIGN);
}

- (UIStatusBarStyle)statusBarStyle {
    return (UIStatusBarStyle)[objc_getAssociatedObject(self, &statusStyleKey) integerValue];
}

#pragma mark - Tab

- (void)setHideTabBar:(BOOL)hideTabBar {
    objc_setAssociatedObject(self, &hideTabBarKey, @(hideTabBar), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)hideTabBar {
    return [objc_getAssociatedObject(self, &hideTabBarKey) boolValue];
}

- (void)setTabBarTitle:(NSString *)tabBarTitle {
    objc_setAssociatedObject(self, &tabBarIconKey, tabBarTitle, OBJC_ASSOCIATION_RETAIN);
}

- (NSString *)tabBarTitle {
    return objc_getAssociatedObject(self, &tabBarIconKey);
}

- (void)setTabBarIcon:(NSString *)tabBarIcon {
    objc_setAssociatedObject(self, &tabBarIconKey, tabBarIcon, OBJC_ASSOCIATION_RETAIN);
}

- (NSString *)tabBarIcon {
    return objc_getAssociatedObject(self, &tabBarIconKey);
}

#pragma mark - Navigation

- (void)setHideNavigationBar:(BOOL)hideNavigationBar {
    objc_setAssociatedObject(self, &hideNavigationBarKey, @(hideNavigationBar), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)hideNavigationBar {
    return [objc_getAssociatedObject(self, &hideNavigationBarKey) boolValue];
}

- (void)setNavigationTitle:(NSString *)navigationTitle {
    objc_setAssociatedObject(self, &navigationTitleKey, navigationTitle, OBJC_ASSOCIATION_RETAIN);
}

- (NSString *)navigationTitle {
    return objc_getAssociatedObject(self, &navigationTitleKey);
}

#endif

@end
