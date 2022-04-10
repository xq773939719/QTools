//
//  LoggerSystem.m
//
//  Created by XQ on 2022/1/21.
//

#import "LoggerSystem.h"

#import "BaseLogger.h"

@implementation LoggerSystem

+ (void)load {
  LoggerEngineDefaultCreate(0, YES, YES);
}

- (void)log:(LoggerLevel)flag file:(const char *)file function:(const char *)function line:(NSUInteger)line tag:(id)tag format:(NSString *)format args:(va_list)args {
    switch (flag) {
        case LoggerLevelError: LoggerInnerErrorV(file, function, line, tag, format, args); break;
        case LoggerLevelWarn: LoggerInnerWarnV(file, function, line, tag, format, args); break;
        case LoggerLevelInfo: LoggerInnerInfoV(file, function, line, tag, format, args); break;
        case LoggerLevelDebug: LoggerInnerDebugV(file, function, line, tag, format, args); break;
        case LoggerLevelVerbose: LoggerInnerVerboseV(file, function, line, tag, format, args); break;
        default: break;
    }
}

@end
