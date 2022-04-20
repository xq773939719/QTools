//
//  DeviceWindow.m
//
//  Created by XQ on 2022/4/10.
//

#if TARGET_OS_OSX

#import "DeviceWindow.h"

@implementation DeviceWindow

+ (instancetype)share {
    static DeviceWindow *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance) {
            instance = [DeviceWindow new];
        }
    });
    return instance;
}

@end

#endif
