//
//  DarwinDefine.h
//
//  Created by XQ on 2022/4/10.
//

#ifndef DarwinDefine_h
#define DarwinDefine_h

#if TARGET_OS_IPHONE

#import <UIKit/UIKit.h>

#define RESPONDER UIResponder
#define APPLICATION UIApplication
#define APPLICATION_DELEGATE UIApplicationDelegate
#define WINDOW UIWindow
#define VIEW_CONTROLLER UIViewController
#define VIEW UIView
#define COLOR UIColor

#endif

#if TARGET_OS_OSX

#import <AppKit/AppKit.h>

#define RESPONDER NSResponder
#define APPLICATION NSApplication
#define APPLICATION_DELEGATE NSApplicationDelegate
#define WINDOW NSWindow
#define VIEW_CONTROLLER NSViewController
#define VIEW NSView
#define COLOR NSColor

#endif

#endif /* DarwinDefine_h */
