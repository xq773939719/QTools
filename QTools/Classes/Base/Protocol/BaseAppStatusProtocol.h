//
//  BaseAppStatusProtocol.h
//
//  Created by XQ on 2022/1/20.
//

#ifndef BaseAppStatusProtocol_h
#define BaseAppStatusProtocol_h

@class NSMenu;

@protocol BaseAppStatusProtocal

@optional
/// 启动时
- (void)onAppLaunch;

/// 进入前台
- (void)onAppWillEnterForeground;

/// 获得焦点
- (void)onAppDidBecomeActive;

/// 失去焦点
- (void)onAppWillResignActive;

/// 进入后台
- (void)onAppDidEnterBackground;

/// 终止
- (void)onAppWillTerminate;

@end

#endif /* BaseAppStatusProtocol_h */
