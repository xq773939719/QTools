//
//  BaseApplicationDelegate.m
//
//  Created by XQ on 2022/1/20.
//

#import "BaseApplicationDelegate.h"
#import "BaseEntranceManager.h"
#import "Logger.h"

@interface BaseApplicationDelegate ()

@property (nonatomic, strong) BaseEntranceManager *entranceManager;

@end

@implementation BaseApplicationDelegate

# pragma mark - BaseApplicationEntranceProtocol
- (BaseEntranceManager *)onDelegateInit {
        // 子类需要实现
    return nil;
}


#if TARGET_OS_IPHONE

#pragma mark - UIApplicationDelegate

- (BOOL)application:(APPLICATION *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    LoggerInfo(@"[%@] -> %@", [self class], @"启动");
    [self.entranceManager launchWithApplication:application];
    [self.entranceManager onAppLaunch];
    return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    LoggerInfo(@"[%@] -> %@", [self class], @"将要进入前台");
    [self.entranceManager onAppWillEnterForeground];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    LoggerInfo(@"[%@] -> %@", [self class], @"已经激活");
    [self.entranceManager onAppDidBecomeActive];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    LoggerInfo(@"[%@] -> %@", [self class], @"将要失活");
    [self.entranceManager onAppWillResignActive];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    LoggerInfo(@"[%@] -> %@", [self class], @"已经进入后台");
    [self.entranceManager onAppDidEnterBackground];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    LoggerInfo(@"[%@] -> %@", [self class], @"已经终止");
    [self.entranceManager onAppWillTerminate];
}

#endif

#if TARGET_OS_OSX

#pragma mark - NSApplicationDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    LoggerInfo(@"[%@] -> %@", [self class], @"启动");
    NSApplication *application = (NSApplication *)notification.object;
    [self.entranceManager launchWithApplication:application];
    [self.entranceManager onAppLaunch];
}

- (void)applicationWillUnhide:(NSNotification *)notification {
    LoggerInfo(@"[%@] -> %@", [self class], @"将要进入前台");
    [self.entranceManager onAppWillEnterForeground];
}

- (void)applicationWillBecomeActive:(NSNotification *)notification {
    LoggerInfo(@"[%@] -> %@", [self class], @"已经激活");
    [self.entranceManager onAppDidBecomeActive];
}

- (void)applicationWillResignActive:(NSNotification *)notification {
    LoggerInfo(@"[%@] -> %@", [self class], @"将要失活");
    [self.entranceManager onAppWillResignActive];
}

- (void)applicationWillHide:(NSNotification *)notification {
    LoggerInfo(@"[%@] -> %@", [self class], @"已经进入后台");
    [self.entranceManager onAppDidEnterBackground];
}

- (void)applicationWillTerminate:(NSNotification *)notification {
    LoggerInfo(@"[%@] -> %@", [self class], @"已经终止");
    [self.entranceManager onAppWillTerminate];
}

#endif

#pragma mark - getter

- (BaseEntranceManager *)entranceManager {
    if (!_entranceManager) {
        _entranceManager = [self onDelegateInit];
    }
    return _entranceManager;
}

- (WINDOW *)window {
    return [self.entranceManager window];
}

@end
