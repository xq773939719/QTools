//
//  LaunchViewController.h
//
//  Created by XQ on 2022/1/21.
//

#import "BaseKitHeader.h"

NS_ASSUME_NONNULL_BEGIN

@protocol LaunchViewControllerProtocol <NSObject>

- (void)showRootViewController;

@end

@interface LaunchViewController : VIEW_CONTROLLER

@property (nonatomic, weak) id<LaunchViewControllerProtocol> delegate;

@end

NS_ASSUME_NONNULL_END
