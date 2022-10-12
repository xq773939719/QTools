//
//  RouteManager.m
//
//  Created by XQ on 2022/1/29.
//

#import "RouteManager.h"
#import "Router.h"

@implementation RouteManager

- (void)registerViewControllers {
    [[Router share] registerScheme:@"" withClass:[VIEW_CONTROLLER class]];
}

@end
