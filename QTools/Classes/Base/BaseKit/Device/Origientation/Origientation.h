//
//  Origientation.h
//
//  Created by XQ on 2022/4/6.
//

#if TARGET_OS_IPHONE

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Origientation : NSObject

@property (nonatomic, assign, readonly) UIDeviceOrientation deviceOrientation;

+ (instancetype)share;

- (void)rotate:(UIDeviceOrientation)deviceOrientation;

@end

NS_ASSUME_NONNULL_END

#endif
