//
//  RouteMap.h
//
//  Created by XQ on 2022/1/23.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RouteMap : NSObject

- (BOOL)registerScheme:(NSString *)scheme withClass:(Class)className;

- (Class)getClass:(NSString *)scheme;

@end

NS_ASSUME_NONNULL_END
