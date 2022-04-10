//
//  ViewController+Orientation.h
//
//  Created by XQ on 2022/4/6.
//

#if TARGET_OS_IPHONE

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Orientation)

@property (nonatomic, assign, readonly) BOOL isPortrait;
@property (nonatomic, assign, readonly) BOOL isLandscape;
@property (nonatomic, assign) UIInterfaceOrientation uiOrientation;

@end

NS_ASSUME_NONNULL_END

#endif
