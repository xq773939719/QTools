//
//  Platform.m
//  Q
//
//  Created by XQ on 2022/4/7.
//

#if TARGET_OS_IPHONE

#import "Platform.h"

@implementation Platform

+ (BOOL)isUnknown {
    return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomUnspecified;
}

+ (BOOL)isPhone {
    return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone;
}

+ (BOOL)isPad {
    return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad;
}

+ (BOOL)isTV {
    return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomTV;
}

+ (BOOL)isCarPlay {
    return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomCarPlay;
}

+ (BOOL)isMac {
    if (@available(iOS 14.0, *)) {
        return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomMac;
    } else {
        return NO;
    }
}

@end

#endif
