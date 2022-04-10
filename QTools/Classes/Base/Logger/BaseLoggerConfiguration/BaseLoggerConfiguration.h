//
//  BaseLoggerConfiguration.h
//
//  Created by XQ on 2022/1/21.
//

#import <Foundation/Foundation.h>
#import "Logger.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseLoggerConfiguration : NSObject

@property (nonatomic, copy) NSString *logDirectory;
@property (nonatomic, assign) NSUInteger maximumNumberOfLogFiles;  // default 50
@property (nonatomic, assign) NSUInteger limitOfSizeInMetaBytes; // default to 50M
@property (nonatomic, assign) BOOL zipEnabled; // default YES;
@property (nonatomic, assign) BOOL mmapEnabled; // default YES;
@property (nonatomic, assign) LoggerLevel ttylevel;
@property (nonatomic, assign) LoggerLevel aslevel;
@property (nonatomic, assign) LoggerLevel fileLevel;

+ (instancetype)defaultConfiguration;

@end

NS_ASSUME_NONNULL_END
