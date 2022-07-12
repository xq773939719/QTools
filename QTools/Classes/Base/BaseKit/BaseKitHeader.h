//
//  BaseKitHeader.h
//
//  Created by XQ on 2022/1/21.
//

#ifndef BaseKitHeader_h
#define BaseKitHeader_h

// 通用
#import "NSObject+Method.h"
#import "ViewModel.h"
#import "BaseWebView.h"

#ifdef __APPLE__
#include <TargetConditionals.h>
#endif

#import "DarwinDefine.h"

#import "BaseApplicationDelegate.h"
#import "BaseEntranceManager.h"
#import "LaunchViewController.h"

// 基类
#import "ViewControllerContext.h"
#import "BaseViewController.h"
#import "BaseNavigationController.h"
#import "BaseTabBarController.h"

// 扩展
#import "Application+Base.h"
#import "ViewController+Configuration.h"
#import "ViewController+Orientation.h"

#endif /* BaseKitHeader_h */
