//
//  Logger.h
//
//  Created by XQ on 2022/1/21.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, LoggerFlag){
    LoggerFlagError      = (1 << 0),
    LoggerFlagWarn    = (1 << 1),
    LoggerFlagInfo       = (1 << 2),
    LoggerFlagDebug      = (1 << 3),
    LoggerFlagVerbose    = (1 << 4)
};

typedef NS_ENUM(NSUInteger, LoggerLevel) {
    LoggerLevelOff = 0,
    LoggerLevelError = (1 << 0),
    LoggerLevelWarn = (LoggerLevelError | 1 << 1),
    LoggerLevelInfo = (LoggerLevelWarn | 1 << 2),
    LoggerLevelDebug = (LoggerLevelInfo | 1 << 3),
    LoggerLevelVerbose = (LoggerLevelDebug | 1 << 4),
    LoggerLevelAll = NSUIntegerMax
};

#define LoggerError(frmt, ...) LoggerOutput(LoggerLevelError, __FILE__, __PRETTY_FUNCTION__, __LINE__, nil, frmt, ##__VA_ARGS__)
#define LoggerWarn(frmt, ...) LoggerOutput(LoggerLevelWarn, __FILE__, __PRETTY_FUNCTION__, __LINE__, nil, frmt, ##__VA_ARGS__)
#define LoggerInfo(frmt, ...) LoggerOutput(LoggerLevelInfo, __FILE__, __PRETTY_FUNCTION__, __LINE__, nil, frmt, ##__VA_ARGS__)
#define LoggerDebug(frmt, ...) LoggerOutput(LoggerLevelDebug, __FILE__, __PRETTY_FUNCTION__, __LINE__, nil, frmt, ##__VA_ARGS__)
#define LoggerVerbose(frmt, ...) LoggerOutput(LoggerLevelVerbose, __FILE__, __PRETTY_FUNCTION__, __LINE__, nil, frmt, ##__VA_ARGS__)

#define LoggerErrorWithTag(tag,frmt, ...) LoggerOutput(LoggerLevelError, __FILE__, __PRETTY_FUNCTION__, __LINE__, tag, frmt, ##__VA_ARGS__)
#define LoggerWarnWithTag(tag,frmt, ...) LoggerOutput(LoggerLevelWarn, __FILE__, __PRETTY_FUNCTION__, __LINE__, tag, frmt, ##__VA_ARGS__)
#define LoggerInfoWithTag(tag,frmt, ...) LoggerOutput(LoggerLevelInfo, __FILE__, __PRETTY_FUNCTION__, __LINE__, tag, frmt, ##__VA_ARGS__)
#define LoggerDebugWithTag(tag,frmt, ...) LoggerOutput(LoggerLevelDebug, __FILE__, __PRETTY_FUNCTION__, __LINE__, tag, frmt, ##__VA_ARGS__)
#define LoggerVerboseWithTag(tag,frmt, ...) LoggerOutput(LoggerLevelVerbose, __FILE__, __PRETTY_FUNCTION__, __LINE__, tag, frmt, ##__VA_ARGS__)

#define LoggerErrorV(frmt, va) LoggerOutputV(LoggerLevelError, __FILE__, __PRETTY_FUNCTION__, __LINE__, nil, frmt, va)
#define LoggerWarnV(frmt, va) LoggerOutputV(LoggerLevelWarn, __FILE__, __PRETTY_FUNCTION__, __LINE__, nil, frmt, va)
#define LoggerInfoV(frmt, va) LoggerOutputV(LoggerLevelInfo, __FILE__, __PRETTY_FUNCTION__, __LINE__, nil, frmt, va)
#define LoggerDebugV(frmt, va) LoggerOutputV(LoggerLevelDebug, __FILE__, __PRETTY_FUNCTION__, __LINE__, nil, frmt, va)
#define LoggerVerboseV(frmt, va) LoggerOutputV(LoggerLevelVerbose, __FILE__, __PRETTY_FUNCTION__, __LINE__, nil, frmt, va)

#define LoggerErrorWithTagV(tag, frmt, va) LoggerOutputV(LoggerLevelError, __FILE__, __PRETTY_FUNCTION__, __LINE__, tag, frmt, va)
#define LoggerWarnWithTagV(tag, frmt, va) LoggerOutputV(LoggerLevelWarn, __FILE__, __PRETTY_FUNCTION__, __LINE__, tag, frmt, va)
#define LoggerInfoWithTagV(tag, frmt, va) LoggerOutputV(LoggerLevelInfo, __FILE__, __PRETTY_FUNCTION__, __LINE__, tag, frmt, va)
#define LoggerDebugWithTagV(tag, frmt, va) LoggerOutputV(LoggerLevelDebug, __FILE__, __PRETTY_FUNCTION__, __LINE__, tag, frmt, va)
#define LoggerVerboseWithTagV(tag, frmt, va) LoggerOutputV(LoggerLevelVerbose, __FILE__, __PRETTY_FUNCTION__, __LINE__, tag, frmt, va)

@protocol LoggerSystemProtocol <NSObject>
- (void)log:(LoggerLevel)flag file:(const char *)file function:(const char *)function line:(NSUInteger)line tag:(id)tag format:(NSString *)format args:(va_list)args;
@end

void SetLoggerSystem(id<LoggerSystemProtocol> loggerSystem);

void LoggerOutput(LoggerLevel flag, const char * file, const char * function, NSUInteger line, id tag, NSString * format, ...);
void LoggerOutputV(LoggerLevel flag, const char * file, const char * function, NSUInteger line, id tag, NSString * format, va_list args);
