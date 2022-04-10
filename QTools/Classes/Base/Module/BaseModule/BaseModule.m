//
//  BaseModule.m
//
//  Created by XQ on 2022/1/20.
//

#import "BaseModule.h"

@interface BaseModule ()

@property (nonatomic, strong) NSDictionary *config;

@end

@implementation BaseModule

- (instancetype)init {
    self = [super init];
    if (self) {
        self.config = [NSDictionary dictionary];
    }
    return self;
}

- (instancetype)initWithConfig: (NSDictionary *)config {
    self = [self init];
    if (self) {
        self.config = [config copy];
    }
    return self;
}

# pragma mark - BaseModuleProtocol
- (NSString *)moduleName {
    return nil;
}

- (BaseModuleLevel)moduleLevel {
    return BaseModuleLevelUnknown;
}

- (void)didLoadModule {
    return;
}

- (nonnull NSDictionary *)moduleConfig {
    return self.config;
}

#pragma mark - BaseAppStatusProtocol

- (void)onAppLaunch {
    
}

- (void)onAppDidBecomeActive {
    
}

- (void)onAppWillEnterForeground {
    
}

- (void)onAppWillResignActive {
    
}

- (void)onAppDidEnterBackground {
    
}

- (void)onAppWillTerminate {
    
}

@end
