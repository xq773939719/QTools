//
//  Battery.h
//
//  Created by XQ on 2022/4/6.
//

#if TARGET_OS_IPHONE

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Battery : NSObject

@property (nonatomic, assign, readonly) UIDeviceBatteryState state;
@property (nonatomic, assign, readonly) float level;

+ (instancetype)share;

@end

NS_ASSUME_NONNULL_END

#endif
