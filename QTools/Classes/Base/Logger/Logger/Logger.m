//
//  Logger.m
//
//  Created by XQ on 2022/1/21.
//

#import "Logger.h"

static id<LoggerSystemProtocol> _loggerSystem;
void SetLoggerSystem(id<LoggerSystemProtocol> loggerSystem) {
    _loggerSystem = loggerSystem;
}

void LoggerOutput(LoggerLevel flag, const char * file, const char * function, NSUInteger line, id tag, NSString * format, ...) {
    va_list args;
    va_start(args, format);
    if (_loggerSystem) {
        [_loggerSystem log:flag file:file function:function line:line tag:tag format:format args:args];
    }
    va_end(args);
}

void LoggerOutputV(LoggerLevel flag, const char * file, const char * function, NSUInteger line, id tag, NSString * format, va_list args) {
    if (_loggerSystem) {
        [_loggerSystem log:flag file:file function:function line:line tag:tag format:format args:args];
    }
}

