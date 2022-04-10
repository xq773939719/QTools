//
//  Router.m
//
//  Created by XQ on 2022/1/23.
//

#import "Router.h"
#import "RouteMap.h"

@interface Router ()

#if TARGET_OS_IPHONE
@property (nonatomic, strong) UINavigationController *rootNavigationController;
#endif

#if TARGET_OS_OSX
@property(nonatomic, strong) NSWindowController *rootWindowController;
#endif

@property (nonatomic, strong) RouteMap *routeMap;

@end

@implementation Router

+ (void)load {
    [self share];
}

+ (instancetype)share {
    static Router *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance) {
            instance = [Router new];
        }
    });
    return instance;
}

#if TARGET_OS_IPHONE

- (void)configRootNavigationController:(UINavigationController *)rootNavigationController {
    self.rootNavigationController = rootNavigationController;
}

#endif

#if TARGET_OS_OSX

- (void)configRootWindowController:(NSWindowController *)rootWindowController {
    self.rootWindowController = rootWindowController;
}

#endif

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.routeMap = [RouteMap new];
    }
    return self;
}

- (BOOL)registerScheme:(NSString *)scheme withClass:(Class)className {
    return [self.routeMap registerScheme:scheme withClass:className];
}

- (BOOL)route:(NSString *)scheme withParams:(NSDictionary *)params {
    Class class = [self.routeMap getClass:scheme];
    if (!class) {
        return NO;
    }
#if TARGET_OS_IPHONE
    UIViewController *viewController = [[class alloc] init];
    viewController.params = params ?: @{};
    [self.rootNavigationController pushViewController:viewController animated:YES];
#endif
    
#if TARGET_OS_OSX
    NSViewController *viewController = [[class alloc] init];
    viewController.params = params ?: @{};
    NSWindow *window = [NSWindow new];
    window.contentViewController = viewController;
    NSWindowController *windowController = [[NSWindowController alloc] initWithWindow:window];
    self.rootWindowController = windowController;
    [windowController showWindow:nil];
#endif
    return YES;
}

@end
