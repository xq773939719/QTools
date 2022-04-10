//
//  Router.h
//
//  Created by XQ on 2022/1/23.
//

#import "BaseHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface Router : NSObject

#if TARGET_OS_IPHONE
@property (nonatomic, strong, readonly) UINavigationController* rootNavigationController;
#endif

+ (instancetype)share;

#if TARGET_OS_IPHONE
- (void)configRootNavigationController:(UINavigationController *)rootNavigationController;
#endif

#if TARGET_OS_OSX
- (void)configRootWindowController:(NSWindowController *)rootWindowController;
#endif

- (BOOL)registerScheme:(NSString *)scheme withClass:(Class)className;

- (BOOL)route:(NSString *)scheme withParams:(nullable NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
