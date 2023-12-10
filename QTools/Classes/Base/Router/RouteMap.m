//
//  RouteMap.m
//
//  Created by XQ on 2022/1/23.
//

#import "RouteMap.h"
#import "Logger.h"

static NSString *PREFIX_ROUTE = @"q://";

@interface RouteMap ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, Class> *routeMap;

@end

@implementation RouteMap

- (instancetype)init {
    self = [super init];
    if (self) {
        self.routeMap = [NSMutableDictionary dictionary];
    }
    return self;
}

- (BOOL)registerScheme:(NSString *)scheme withClass:(Class)className {
    @synchronized (self) {
        if (!scheme || (scheme.length > 0 && ![scheme hasPrefix:PREFIX_ROUTE])) {
            LoggerError(@"非法路由前缀路由");
            return NO;
        }
        if ([self.routeMap objectForKey:scheme]) {
            NSAssert(NO, @"不允许同名路由");
            return NO;
        }
        
        LoggerInfo(@"[%@] -> 注册scheme: %@, className: %@", [self class], scheme, className);
        [self.routeMap setObject:className forKey:scheme];
    }
    return YES;
}

- (Class)getClass:(NSString *)scheme {
    Class className = nil;
    @synchronized (self) {
        className = [self.routeMap objectForKey:scheme];
        LoggerInfo(@"[%@] -> 获取scheme: %@, className: %@", [self class], scheme, className);
    }
    return className;
}

@end
