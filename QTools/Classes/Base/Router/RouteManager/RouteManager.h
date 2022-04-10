//
//  RouteManager.h
//
//  Created by XQ on 2022/1/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RouteMangerProtocol <NSObject>

- (void)registerViewControllers;

@end

@interface RouteManager : NSObject <RouteMangerProtocol>

@end

NS_ASSUME_NONNULL_END
