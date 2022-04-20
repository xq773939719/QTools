//
//  BaseEntranceManager.h
//
//  Created by XQ on 2022/1/20.
//

#import "BaseKitHeader.h"
#import "ProtocolHeader.h"

NS_ASSUME_NONNULL_BEGIN

@class APPLICATION;
@class VIEW_CONTROLLER;
@class RouteManager;

@protocol BaseEntranceModuleProtocal

@property (nonatomic, assign, readonly, class) Class rootViewControllerClass;

@property (nonatomic, assign, readonly, class) Class routeManagerClass;

// APP
@property (nonatomic, weak, readonly) APPLICATION *application;

// 视窗
@property (nonatomic, strong, readonly) WINDOW *window;

// 根视图控制器
@property (nonatomic, strong, readonly) VIEW_CONTROLLER *rootViewController;

// 路由管理员
@property (nonatomic, strong, readonly) RouteManager *routeManager;

- (void)setCurrentWindow:(WINDOW *)window;

// 注册模块
- (void)registerModules;

// 启动模块
- (void)createModules;

// 注册VC
- (void)registerViewControllers;

@end

@interface BaseEntranceManager : NSObject <BaseEntranceModuleProtocal, BaseAppStatusProtocal>

#if TARGET_OS_IPHONE
// 根导航控制器
@property (nonatomic, strong, readonly) UINavigationController *rootNavigationController;
#endif

#if TARGET_OS_OSX
@property (nonatomic, strong, readonly) NSWindowController *rootWindowController;
#endif

- (void)launchWithApplication:(APPLICATION *)application;

@end

NS_ASSUME_NONNULL_END
