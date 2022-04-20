//
//  BaseEntranceManager.m
//
//  Created by XQ on 2022/1/20.
//

#import "BaseEntranceManager.h"
#import "BaseModuleManager.h"
#import "Router.h"

@interface BaseEntranceManager ()

#if TARGET_OS_IPHONE
@property (nonatomic, strong) UINavigationController *rootNavigationController;
#endif

#if TARGET_OS_OSX
@property (nonatomic, strong) NSWindowController *rootWindowController;
#endif

@property (nonatomic, weak) APPLICATION *application;

@property (nonatomic, strong) WINDOW *window;

@property (nonatomic, strong) VIEW_CONTROLLER *rootViewController;

@property (nonatomic, strong) RouteManager *routeManager;

@end

@implementation BaseEntranceManager

+ (Class)rootViewControllerClass {
    return [VIEW_CONTROLLER class];
}

+ (Class)routeManagerClass {
    return [RouteManager class];
}

- (void)launchWithApplication:(APPLICATION *)application{
    self.application = application;
#if TARGET_OS_IPHONE
    self.window = [[UIWindow alloc] initWithFrame: [UIScreen mainScreen].bounds];
    application.window = self.window;
#endif
#if TARGET_OS_OSX
    NSRect frame = CGRectZero;
    NSUInteger style = NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskResizable | NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskFullSizeContentView;
    NSWindow *window = [[NSWindow alloc] initWithContentRect:frame styleMask:style backing:NSBackingStoreBuffered defer:YES];
    self.window = window;
#endif
    [self initNavigation];
    [self registerModules];
    [self createModules];
    [self registerViewControllers];
}

#if TARGET_OS_OSX
- (void)setCurrentWindow:(NSWindow *)window {
    self.window = window;
    [window center];
    [window makeKeyWindow];
    self.rootWindowController.window = window;
    [self.rootWindowController showWindow:nil];
}
#endif

- (void)initNavigation {
    
#if TARGET_OS_IPHONE
    self.rootNavigationController = [[BaseNavigationController alloc] initWithRootViewController:self.rootViewController];
    [[Router share] configRootNavigationController:self.rootNavigationController];
#endif
    
#if TARGET_OS_OSX
    [[Router share] configRootWindowController:self.rootWindowController];
    self.rootWindowController.window = self.window;
    [self.rootWindowController showWindow:nil];
#endif
}

#if TARGET_OS_OSX

- (NSWindowController *)rootWindowController {
    if (_rootWindowController) {
        return _rootWindowController;
    }
    _rootWindowController = [NSWindowController new];
    return _rootWindowController;
}

#endif


- (VIEW_CONTROLLER *)rootViewController {
    if (_rootViewController) {
        return _rootViewController;
    }
    _rootViewController = [[self class].rootViewControllerClass new];
    return _rootViewController;
}

- (void)registerModules {
    NSArray *systemModules = @[
        
    ];
    [BaseModuleManager registerModules:systemModules
                                 level:BaseModuleLevelSystem];
}

- (void)createModules {
    [BaseModuleManager createModules];
}

- (void)registerViewControllers {
    [self.routeManager registerViewControllers];
}

- (RouteManager *)routeManager {
    if (_routeManager) {
        return _routeManager;
    }
    _routeManager = [[self class].routeManagerClass new];
    return _routeManager;
}

- (void)onAppLaunch {
    [[BaseModuleManager share] onAppLaunch];
}

- (void)onAppDidBecomeActive {
    [self setCurrentWindow:self.window];
    [[BaseModuleManager share] onAppDidBecomeActive];
}

- (void)onAppWillEnterForeground {
    [[BaseModuleManager share] onAppWillEnterForeground];
}

- (void)onAppWillResignActive {
    [[BaseModuleManager share] onAppWillResignActive];
}

- (void)onAppDidEnterBackground {
    [[BaseModuleManager share] onAppDidEnterBackground];
}

- (void)onAppWillTerminate {
    [[BaseModuleManager share] onAppWillTerminate];
}

@end
