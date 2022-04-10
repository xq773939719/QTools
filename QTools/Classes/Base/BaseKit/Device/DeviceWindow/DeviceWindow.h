//
//  DeviceWindow.h
//
//  Created by XQ on 2022/4/10.
//

#if TARGET_OS_OSX

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeviceWindow : NSObject <NSWindowDelegate>

+ (instancetype)share;

@end

NS_ASSUME_NONNULL_END

#endif
