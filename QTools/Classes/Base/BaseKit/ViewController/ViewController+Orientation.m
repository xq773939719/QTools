//
//  UIViewController+Orientation.m
//
//  Created by XQ on 2022/4/6.
//

#if TARGET_OS_IPHONE

#import "ViewController+Orientation.h"
#import "DeviceHeader.h"

@implementation UIViewController (Orientation)

#pragma mark - uiOrientation

- (UIInterfaceOrientation)uiOrientation {
    switch ([Origientation share].deviceOrientation) {
        case UIDeviceOrientationPortrait:
            return UIInterfaceOrientationPortrait;
        case UIDeviceOrientationLandscapeLeft:
            return UIInterfaceOrientationLandscapeLeft;
        case UIDeviceOrientationPortraitUpsideDown:
            return UIInterfaceOrientationPortraitUpsideDown;
        case UIDeviceOrientationLandscapeRight:
            return UIInterfaceOrientationLandscapeRight;
        default:
            break;
    }
    return UIInterfaceOrientationUnknown;
}

- (void)setUiOrientation:(UIInterfaceOrientation)uiOrientation {
    UIDeviceOrientation orientation = UIDeviceOrientationUnknown;
    switch (uiOrientation) {
        case UIInterfaceOrientationPortrait:
            orientation = UIDeviceOrientationPortrait;
            break;
        case UIInterfaceOrientationLandscapeLeft:
            orientation = UIDeviceOrientationLandscapeLeft;
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            orientation = UIDeviceOrientationPortraitUpsideDown;
            break;
        case UIInterfaceOrientationLandscapeRight:
            orientation = UIDeviceOrientationLandscapeRight;
            break;
        default:
            break;
    }
    [[Origientation share] rotate:orientation];
}

#pragma mark - protrait

- (BOOL)isPortrait {
    return UIInterfaceOrientationIsPortrait(self.uiOrientation);
}

#pragma mark - landscape

- (BOOL)isLandscape {
    return UIInterfaceOrientationIsLandscape(self.uiOrientation);;
}


@end

#endif
