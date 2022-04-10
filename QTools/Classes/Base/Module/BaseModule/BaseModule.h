//
//  BaseModule.h
//
//  Created by XQ on 2022/1/20.
//

#import <Foundation/Foundation.h>

#import "ProtocolHeader.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, BaseModuleLevel) {
    BaseModuleLevelUnknown = -1,
    BaseModuleLevelSystem = 0,
    BaseModuleLevelCommon = 1,
    BaseModuleLevelBusiness = 2,
};

@protocol BaseModuleProtocol

@required

- (NSString *)moduleName;
- (BaseModuleLevel)moduleLevel;
- (NSDictionary *)moduleConfig;
- (void)didLoadModule;

@end

@interface BaseModule : NSObject <BaseModuleProtocol, BaseAppStatusProtocal>

- (instancetype)initWithConfig:(NSDictionary *)config;

@end

NS_ASSUME_NONNULL_END
