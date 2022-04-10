//
//  BaseLog.m
//
//  Created by XQ on 2022/1/21.
//

#import "BaseLogger.h"
#import "Logger.h"
#import "BaseLoggerConfiguration.h"
#import "LoggerSystem.h"
#import "LoggerEngine.h"

#ifdef DEBUG
static const DDLogLevel ddLogLevel = DDLogLevelAll;
#else
static const DDLogLevel ddLogLevel = DDLogLevelWarning;
#endif

static inline void innerlog(BOOL asynchronous, DDLogLevel level, DDLogFlag flag, NSInteger context,
                            const char * file, const char * function, NSUInteger line,
                            id tag, NSString * format, va_list args) {
    [LoggerEngineDefault() log:asynchronous level:(LoggerLevel)level flag:(LoggerFlag)flag file:file function:function line:line tag:tag format:format args:args];
}

void LoggerInnerErrorV(const char *file, const char *function, NSUInteger line, id tag, NSString *fmt, va_list args)
{
    innerlog(LOG_ASYNC_ENABLED, LOG_LEVEL_DEF, DDLogFlagError, 0, file, function, line, tag, fmt, args);
}

void LoggerInnerWarnV(const char *file, const char *function, NSUInteger line, id tag, NSString *fmt, va_list args)
{
    innerlog(LOG_ASYNC_ENABLED, LOG_LEVEL_DEF, DDLogFlagWarning, 0, file, function, line, tag, fmt, args);
}

void LoggerInnerInfoV(const char *file, const char *function, NSUInteger line, id tag, NSString *fmt, va_list args)
{
    innerlog(LOG_ASYNC_ENABLED, LOG_LEVEL_DEF, DDLogFlagInfo, 0, file, function, line, tag, fmt, args);
}

void LoggerInnerDebugV(const char *file, const char *function, NSUInteger line, id tag, NSString *fmt, va_list args)
{
    innerlog(LOG_ASYNC_ENABLED, LOG_LEVEL_DEF, DDLogFlagDebug, 0, file, function, line, tag, fmt, args);
}

void LoggerInnerVerboseV(const char *file, const char *function, NSUInteger line, id tag, NSString *fmt, va_list args)
{
    innerlog(LOG_ASYNC_ENABLED, LOG_LEVEL_DEF, DDLogFlagVerbose, 0, file, function, line, tag, fmt, args);
}

#pragma mark - LoggerWithTag

void LoggerInnerError(const char *file, const char *function, NSUInteger line, id tag, NSString *fmt, ...)
{
    va_list args;
    va_start(args, fmt);
    innerlog(LOG_ASYNC_ENABLED, LOG_LEVEL_DEF, DDLogFlagError, 0, file, function, line, tag, fmt, args);
    va_end(args);
}

void LoggerInnerWarn(const char *file, const char *function, NSUInteger line, id tag,  NSString *fmt, ...)
{
    va_list args;
    va_start(args, fmt);
    innerlog(LOG_ASYNC_ENABLED, LOG_LEVEL_DEF, DDLogFlagWarning, 0, file, function, line, tag, fmt, args);
    va_end(args);
}

void LoggerInnerInfo(const char *file, const char *function, NSUInteger line,  id tag, NSString *fmt, ...)
{
    va_list args;
    va_start(args, fmt);
    innerlog(LOG_ASYNC_ENABLED, LOG_LEVEL_DEF, DDLogFlagInfo, 0, file, function, line, tag, fmt, args);
    va_end(args);
}

void LoggerInnerDebug(const char *file, const char *function, NSUInteger line,  id tag, NSString *fmt, ...)
{
    va_list args;
    va_start(args, fmt);
    innerlog(LOG_ASYNC_ENABLED, LOG_LEVEL_DEF, DDLogFlagDebug, 0, file, function, line, tag, fmt, args);
    va_end(args);
}

void LoggerInnerVerbose(const char *file, const char *function, NSUInteger line,  id tag, NSString *fmt, ...)
{
    va_list args;
    va_start(args, fmt);
    innerlog(LOG_ASYNC_ENABLED, LOG_LEVEL_DEF, DDLogFlagVerbose, 0, file, function, line, tag, fmt, args);
    va_end(args);
}

static LoggerEngine *defaultEngine = nil;
LoggerEngine *LoggerEngineDefault() {
    return defaultEngine;
}

void LoggerEngineDefaultCreate(NSInteger limitOfSizeInMetaBytes, BOOL mmapEnabled, BOOL zipEnabled) {
    BaseLoggerConfiguration *configuration = [BaseLoggerConfiguration defaultConfiguration];
    if (limitOfSizeInMetaBytes != 0) {
        configuration.limitOfSizeInMetaBytes = limitOfSizeInMetaBytes;
    }
    configuration.mmapEnabled = mmapEnabled;
    configuration.zipEnabled = zipEnabled;
    defaultEngine = [[LoggerEngine alloc] initWithConfiguration:configuration];
    SetLoggerSystem([LoggerSystem new]);
}
