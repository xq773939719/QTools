//
//  BaseApplicationDelegate.h
//
//  Created by XQ on 2022/1/20.
//

#import "BaseKitHeader.h"

NS_ASSUME_NONNULL_BEGIN

@class BaseEntranceManager;

@protocol BaseApplicationEntranceProtocol <NSObject>

@required

- (BaseEntranceManager *)onDelegateInit;

@end

@interface BaseApplicationDelegate : RESPONDER <APPLICATION_DELEGATE, BaseApplicationEntranceProtocol>

@property (nonatomic, strong, readonly) BaseEntranceManager *entranceManager;

@end

NS_ASSUME_NONNULL_END
