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

@end

@implementation BaseEntranceManager

@synthesize window = _window;
@synthesize rootViewController = _rootViewController;
@synthesize routeManager = _routeManager;

- (void)launchWithApplication:(APPLICATION *)application{
#if TARGET_OS_IPHONE
    self.window = [[UIWindow alloc] initWithFrame: [UIScreen mainScreen].bounds];
    application.window = self.window;
#endif
#if TARGET_OS_OSX
    NSRect frame = CGRectZero;
    NSUInteger style = NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskResizable | NSWindowStyleMaskFullSizeContentView;
    self.window = [[NSWindow alloc] initWithContentRect:frame styleMask:style backing:NSBackingStoreNonretained defer:YES];
#endif
    [self initNavigation];
    [self registerModules];
    [self createModules];
    [self registerViewControllers];
}

- (void)initNavigation {
    
#if TARGET_OS_IPHONE
    self.rootNavigationController = [[BaseNavigationController alloc] initWithRootViewController:[self rootViewController]];
    [[Router share] configRootNavigationController:self.rootNavigationController];
#endif
    
#if TARGET_OS_OSX
    self.rootWindowController = [NSWindowController new];
    self.rootWindowController.window = self.window;
    [[Router share] configRootWindowController:self.rootWindowController];
#endif
    
}

- (VIEW_CONTROLLER *)rootViewController {
    NSAssert(NO, @"子类未实现该方法");
    return nil;
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
    
}

- (void)onAppLaunch {
    [[BaseModuleManager share] onAppLaunch];
}

- (void)onAppDidBecomeActive {
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
