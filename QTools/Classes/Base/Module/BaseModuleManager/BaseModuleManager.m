//
//  BaseModuleManager.m
//
//  Created by XQ on 2022/1/20.
//

#import "BaseModuleManager.h"
#import "BaseModule.h"

typedef void(^ForEachBaseModuleBlock)(BaseModule *module);

@interface BaseModuleManager ()

@property(nonatomic, copy) NSDictionary *configs;

@property(nonatomic, strong) NSMutableArray *moduleArray;

@property(nonatomic, strong) NSMutableDictionary *moduleMap;

@end

@implementation BaseModuleManager

+ (void)load {
    [self share];
}

+ (instancetype)share {
    static BaseModuleManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance) {
            instance = [BaseModuleManager new];
        }
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.moduleArray = [NSMutableArray array];
        self.moduleMap = [NSMutableDictionary dictionary];
    }
    return self;
}

+ (void)setConfigs:(NSDictionary *)configs {
    [BaseModuleManager share].configs = configs;
}

+ (void)registerModule:(Class)module level:(BaseModuleLevel)level config:(NSDictionary *)config {
    [[BaseModuleManager share].moduleArray addObject:@{
        @"class": module,
        @"level": @(level),
        @"config": config ?: @{}
    }];
}

+ (void)registerModules:(NSArray<Class> *)modules level:(BaseModuleLevel)level {
    [modules enumerateObjectsUsingBlock:^(Class class, NSUInteger idx, BOOL * _Nonnull stop) {
        [self registerModule:class level:level config:@{}];
    }];
}

+ (void)createModules {
    [[BaseModuleManager share] createModules];
}

#pragma mark private method

- (void)createModules {
    NSArray *modules = self.moduleArray;
    [modules enumerateObjectsUsingBlock:^(NSDictionary *moduleInfo, NSUInteger idx, BOOL * _Nonnull stop) {
        BaseModule *module = [self createModule:moduleInfo];
        if (module) {
            [module didLoadModule];
        }
    }];
}

- (BaseModule *)createModule:(NSDictionary *)moduleInfo {
    BaseModuleLevel level = (BaseModuleLevel) ([moduleInfo[@"level"] integerValue]);
    Class class = (Class) moduleInfo[@"class"];
    NSDictionary *config = moduleInfo[@"config"];
    
    if ([self queryModuleWithClass:class]) {
        return nil;
    }
    
    NSMutableDictionary *combinedConfig = [NSMutableDictionary dictionary];
    [combinedConfig setValuesForKeysWithDictionary:self.configs];
    [combinedConfig setValuesForKeysWithDictionary:config];
    
    BaseModule *module = [[class alloc] init];
    if (!module) {
        return nil;
    }
    
    NSMutableArray *currentLevelModules = self.moduleMap[@(level)];
    if (!currentLevelModules) {
        self.moduleMap[@(level)] = [[NSMutableArray alloc] initWithObjects:module, nil];
    } else {
        [currentLevelModules addObject:module];
    }
    
    return module;
}

- (BaseModule *)queryModuleWithClass:(Class)class {
    NSArray *modules = [[self.moduleMap allValues] copy];
    __block BaseModule *queriedModule = nil;
    [modules enumerateObjectsUsingBlock:^(NSArray *levelArray, NSUInteger idx, BOOL * _Nonnull levelArrayStop) {
        if (levelArray) {
            [levelArray enumerateObjectsUsingBlock:^(BaseModule *module, NSUInteger idx, BOOL * _Nonnull moduleStop) {
                if ([module isMemberOfClass:class]) {
                    queriedModule = module;
                    *moduleStop = YES;
                }
            }];
        }
        * levelArrayStop = queriedModule != nil;
    }];
    return queriedModule;
}

- (void)runForEachModule:(ForEachBaseModuleBlock)block {
    if (!block) {
        return;
    }
    NSArray *modules = nil;
    @synchronized (self) {
        modules = [[self.moduleMap allValues] copy];
    }
    
    [modules enumerateObjectsUsingBlock:^(NSArray *levelArray, NSUInteger idx, BOOL * _Nonnull levelArrayStop) {
        if (levelArray) {
            [levelArray enumerateObjectsUsingBlock:^(BaseModule *module, NSUInteger idx, BOOL * _Nonnull moduleStop) {
                block(module);
            }];
        }
    }];
    
}

- (void)runForEachModule:(ForEachBaseModuleBlock)block level:(BaseModuleLevel)level {
    if (!block) {
        return;
    }
    
    NSArray *modules = nil;
    @synchronized (self) {
        modules = [self.moduleMap[@(level)] copy];
    }
    
    for (BaseModule *module in modules) {
        block(module);
    }
}

# pragma mark - BaseAppStatusProtocol

- (void)onAppLaunch {
    [self runForEachModule:^(BaseModule *module) {
        if ([module respondsToSelector:@selector(onAppLaunch)]) {
            [module onAppLaunch];
        }
    }];
}

- (void)onAppDidBecomeActive {
    [self runForEachModule:^(BaseModule *module) {
        if ([module respondsToSelector:@selector(onAppDidBecomeActive)]) {
            [module onAppDidBecomeActive];
        }
    }];
}

- (void)onAppWillEnterForeground {
    [self runForEachModule:^(BaseModule *module) {
        if ([module respondsToSelector:@selector(onAppWillEnterForeground)]) {
            [module onAppWillEnterForeground];
        }
    }];
}

- (void)onAppWillResignActive {
    [self runForEachModule:^(BaseModule *module) {
        if ([module respondsToSelector:@selector(onAppWillResignActive)]) {
            [module onAppWillResignActive];
        }
    }];
}

- (void)onAppDidEnterBackground {
    [self runForEachModule:^(BaseModule *module) {
        if ([module respondsToSelector:@selector(onAppDidEnterBackground)]) {
            [module onAppDidEnterBackground];
        }
    }];
}

- (void)onAppWillTerminate {
    [self runForEachModule:^(BaseModule *module) {
        if ([module respondsToSelector:@selector(onAppWillTerminate)]) {
            [module onAppWillTerminate];
        }
    }];
}

@end
