//
//  BaseLoggerConfiguration.m
//
//  Created by XQ on 2022/1/21.
//

#import "BaseLoggerConfiguration.h"

@implementation BaseLoggerConfiguration

+ (instancetype)defaultConfiguration {
    BaseLoggerConfiguration *configuration = [BaseLoggerConfiguration new];
    configuration.maximumNumberOfLogFiles = 50;
    configuration.limitOfSizeInMetaBytes = 50;
    configuration.zipEnabled = YES;
    configuration.mmapEnabled = YES;
    configuration.ttylevel = LoggerLevelAll;
    configuration.aslevel = LoggerLevelWarn;
    configuration.fileLevel = LoggerLevelAll;
    return configuration;
}

@end
