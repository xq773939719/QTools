//
//  Battery.m
//
//  Created by XQ on 2022/4/6.
//

#if TARGET_OS_IPHONE

#import "Battery.h"
#import "LoggerHeader.h"

@interface Battery ()

@property (nonatomic, assign) UIDeviceBatteryState state;
@property (nonatomic, assign) float level;

@end

@implementation Battery

+ (void)load {
    [Battery share];
}

+ (instancetype)share {
    static Battery *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance) {
            instance = [Battery new];
        }
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [UIDevice currentDevice].batteryMonitoringEnabled = YES;
        self.state = [UIDevice currentDevice].batteryState;
        self.level = [UIDevice currentDevice].batteryLevel;
        [self addObservers];
    }
    return self;
}

- (void)dealloc {
    [self removeObservers];
}

- (void)addObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDeviceBatteryStateDidChangeNotification)
                                                 name:UIDeviceBatteryStateDidChangeNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDeviceBatteryLevelDidChangeNotification)
                                                 name:UIDeviceBatteryLevelDidChangeNotification
                                               object:nil];
}

- (void)removeObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - DidChangeNotification

- (void)onDeviceBatteryStateDidChangeNotification {
    if (self.state == [UIDevice currentDevice].batteryState) {
        return;
    }
    self.state = [UIDevice currentDevice].batteryState;
    LoggerInfo(@"[%@][%s] -> : %@", [self class], __func__, @(self.state));
}

- (void)onDeviceBatteryLevelDidChangeNotification {
    if (self.level == [UIDevice currentDevice].batteryLevel) {
        return;
    }
    self.level = [UIDevice currentDevice].batteryLevel;
    LoggerInfo(@"[%@][%s] -> : %@", [self class], __func__, @(self.level));
}

@end

#endif
