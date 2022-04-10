//
//  BaseLog.h
//
//  Created by XQ on 2022/1/21.
//

#import <Foundation/Foundation.h>

@class LoggerEngine;

FOUNDATION_EXTERN void LoggerInnerError(const char *file, const char *function, NSUInteger line, id tag, NSString *fmt, ...) NS_FORMAT_FUNCTION(5,6);
FOUNDATION_EXTERN void LoggerInnerWarn(const char *file, const char *function, NSUInteger line, id tag, NSString *fmt, ...) NS_FORMAT_FUNCTION(5,6);
FOUNDATION_EXTERN void LoggerInnerInfo(const char *file, const char *function, NSUInteger line, id tag, NSString *fmt, ...) NS_FORMAT_FUNCTION(5,6);
FOUNDATION_EXTERN void LoggerInnerDebug(const char *file, const char *function, NSUInteger line, id tag, NSString *fmt, ...) NS_FORMAT_FUNCTION(5,6);
FOUNDATION_EXTERN void LoggerInnerVerbose(const char *file, const char *function, NSUInteger line, id tag, NSString *fmt, ...) NS_FORMAT_FUNCTION(5,6);

FOUNDATION_EXTERN void LoggerInnerErrorV(const char *file, const char *function, NSUInteger line, id tag, NSString *fmt, va_list args) NS_FORMAT_FUNCTION(5,0);
FOUNDATION_EXTERN void LoggerInnerWarnV(const char *file, const char *function, NSUInteger line, id tag, NSString *fmt, va_list args) NS_FORMAT_FUNCTION(5,0);
FOUNDATION_EXTERN void LoggerInnerInfoV(const char *file, const char *function, NSUInteger line, id tag, NSString *fmt, va_list args) NS_FORMAT_FUNCTION(5,0);
FOUNDATION_EXTERN void LoggerInnerDebugV(const char *file, const char *function, NSUInteger line, id tag, NSString *fmt, va_list args) NS_FORMAT_FUNCTION(5,0);
FOUNDATION_EXTERN void LoggerInnerVerboseV(const char *file, const char *function, NSUInteger line, id tag, NSString *fmt, va_list args) NS_FORMAT_FUNCTION(5,0);

FOUNDATION_EXTERN LoggerEngine *LoggerEngineDefault(void);
FOUNDATION_EXTERN void LoggerEngineDefaultCreate(NSInteger limitOfSizeInMetaBytes, BOOL mmapEnabled, BOOL zipEnabled);
