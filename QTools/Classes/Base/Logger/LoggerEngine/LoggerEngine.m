//
//  LoggerEngine.m
//
//  Created by XQ on 2022/1/21.
//

#import "LoggerEngine.h"

#import "BaseLoggerConfiguration.h"

#import "LoggerFileManager.h"

@interface LoggerEngine ()

@property (nonatomic, strong) DDLog *log;
@property (nonatomic, strong) DDFileLogger *fileLogger;

@end

@implementation LoggerEngine

- (instancetype)initWithConfiguration:(BaseLoggerConfiguration *)configuration {
    self = [super init];
    if (self) {
        [self initLog:configuration];
        [self initFileLogger:configuration];
    }
    
    return self;
}

- (void)initLog:(BaseLoggerConfiguration *)configuration {
    if (configuration.logDirectory) {
        self.log = [DDLog new];
    } else {
        self.log = [DDLog sharedInstance];
    }
    [self.log addLogger:[DDTTYLogger sharedInstance] withLevel:(DDLogLevel)configuration.ttylevel];
    [self.log addLogger:[DDTTYLogger sharedInstance] withLevel:(DDLogLevel)configuration.aslevel];
}

- (void)initFileLogger:(BaseLoggerConfiguration *)configuration {
    DDMultiFormatter *formatter = [DDMultiFormatter new];
    [formatter addFormatter:[[DDDispatchQueueLogFormatter alloc] initWithMode:DDDispatchQueueLogFormatterModeNonShareble]];
    if (!self.fileLogger) {
        LoggerFileManager *fileManager = nil;
        if (configuration.logDirectory) {
            fileManager = [[LoggerFileManager alloc] initWithLogsDirectory:configuration.logDirectory];
        } else {
            fileManager = [[LoggerFileManager alloc] init];
        }
        self.fileLogger = [[DDFileLogger alloc] initWithLogFileManager:fileManager];
        self.fileLogger.logFormatter = formatter;
        self.fileLogger.maximumFileSize = 2 * 1024 * 1024;
        self.fileLogger.logFileManager.maximumNumberOfLogFiles = configuration.maximumNumberOfLogFiles;
        self.fileLogger.logFileManager.logFilesDiskQuota = configuration.limitOfSizeInMetaBytes * 1024 * 1024;
        self.fileLogger.doNotReuseLogFiles = YES;
    }
}

- (void)log:(BOOL)asynchronous level:(LoggerLevel)level flag:(LoggerFlag) flag file:(const char *)file function:(const char *)function line:(NSUInteger)line tag:(NSString *)tag format:(NSString *)format, ... {
    va_list args;
    va_start(args, format);
    [self log:asynchronous level:level flag:flag file:file function:function line:line tag:tag format:format args:args];
    va_end(args);
}

- (void)log:(BOOL)asynchronous level:(LoggerLevel)level flag:(LoggerFlag)flag file:(const char *)file function:(const char *)function line:(NSUInteger)line tag:(NSString *)tag format:(NSString *)format args:(va_list)args {
    if (self.checkHandler) {
        va_list copiedArgs;
        va_copy(copiedArgs, args);
        NSString *message = [[NSString alloc] initWithFormat:format arguments:copiedArgs];
        self.checkHandler(message);
    }
    [self.log log:asynchronous level:(DDLogLevel)level flag:(DDLogFlag)flag context:0 file:file function:function line:line tag:tag format:format args:args];
}

@end
