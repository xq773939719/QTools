//
//  UIApplication+Base.h
//
//  Created by XQ on 2022/1/21.
//

#if TARGET_OS_IPHONE

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (Base)

@property (nonatomic, weak) UIWindow *window;

@end

NS_ASSUME_NONNULL_END

#endif
