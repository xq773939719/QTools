  //
  //  CommonEntrance.m
  //
  //  Created by XQ on 2022/1/20.
  //

#import "CommonEntranceManager.h"

#import "PlayerModule.h"

@implementation CommonEntranceManager

#pragma mark - BaseEntranceModuleProtocal
- (void)registerModules {
    [super registerModules];
    
    // 注册系统组件
    NSArray *systemModuls = @[
        
    ];
    [BaseModuleManager registerModules:systemModuls
                                 level:BaseModuleLevelSystem];
    
    // 注册通用组件
    NSArray *commonModules = @[
        [PlayerModule class],
    ];
    [BaseModuleManager registerModules:commonModules
                                 level:BaseModuleLevelCommon];
    
    // 业务组件延迟到在子类注册
    [BaseModuleManager registerModules:[self businessModules]
                                 level:BaseModuleLevelBusiness];
}

- (NSArray<Class> *)businessModules {
    return @[];
}

@end
