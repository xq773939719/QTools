//
//  UIViewController+Configuration.h
//
//  Created by XQ on 2022/1/22.
//

#import "BaseKitHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface VIEW_CONTROLLER (Configuration)

// ViewController配置
@property (nonatomic, strong) NSString *viewControllerName;
@property (nonatomic, strong) NSDictionary *params;

#if TARGET_OS_IPHONE

// 状态栏配置
@property (nonatomic, assign) BOOL hideStatusBar;
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;

// Tab配置
@property (nonatomic, assign) BOOL hideTabBar;
@property (nonatomic, strong) NSString *tabBarTitle;
@property (nonatomic, strong) NSString *tabBarIcon;

// 导航栏配置
@property (nonatomic, assign) BOOL hideNavigationBar;
@property (nonatomic, strong) NSString *navigationTitle;

#endif

@end

NS_ASSUME_NONNULL_END
