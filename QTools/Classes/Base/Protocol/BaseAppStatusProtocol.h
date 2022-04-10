//
//  BaseAppStatusProtocol.h
//
//  Created by XQ on 2022/1/20.
//

#ifndef BaseAppStatusProtocol_h
#define BaseAppStatusProtocol_h

@protocol BaseAppStatusProtocal

@optional
- (void)onAppLaunch;
- (void)onAppWillEnterForeground;
- (void)onAppDidBecomeActive;
- (void)onAppWillResignActive;
- (void)onAppDidEnterBackground;
- (void)onAppWillTerminate;

@end

#endif /* BaseAppStatusProtocol_h */
