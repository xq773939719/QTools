//
//  Origientation.m
//
//  Created by XQ on 2022/4/6.
//

#if TARGET_OS_IPHONE

#import "Origientation.h"
#import "LoggerHeader.h"

@interface Origientation ()

@property (nonatomic, assign) UIDeviceOrientation deviceOrientation;

@end

@implementation Origientation

+ (void)load {
    [Origientation share];
}

+ (instancetype)share {
    static Origientation *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance) {
            instance = [Origientation new];
        }
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.deviceOrientation = UIDevice.currentDevice.orientation;
        [self addObservers];
    }
    return self;
}

- (void)dealloc {
    [self removeObservers];
}

- (void)addObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDeviceOrientationDidChange)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
}

- (void)removeObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - private method

- (void)onDeviceOrientationDidChange {
    if (self.deviceOrientation == UIDevice.currentDevice.orientation) {
        return;
    }
    self.deviceOrientation = UIDevice.currentDevice.orientation;
    LoggerInfo(@"[%@][%s] -> : %@", [self class], __func__, @(self.deviceOrientation));
}

- (void)rotate:(UIDeviceOrientation)deviceOrientation {
    if (self.deviceOrientation == deviceOrientation) {
        return;
    }
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:deviceOrientation]
                                    forKey:@"orientation"];
    }
}

@end

#endif
