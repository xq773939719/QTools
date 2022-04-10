//
//  Platform.h
//  Q
//
//  Created by XQ on 2022/4/7.
//

#if TARGET_OS_IPHONE

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Platform : NSObject

+ (BOOL)isUnknown;

+ (BOOL)isPhone;

+ (BOOL)isPad;

+ (BOOL)isTV;

+ (BOOL)isCarPlay;

+ (BOOL)isMac;

@end

NS_ASSUME_NONNULL_END

#endif
