//
//  DebugPanelDataProvider.h
//
//  Created by XQ on 2022/4/7.
//

#if TARGET_OS_IPHONE

#import "BaseHeader.h"

NS_ASSUME_NONNULL_BEGIN

@class DebugModel;

@interface DebugPanelDataProvider : NSObject <BaseModelProviderProtocol>

- (NSArray<DebugModel *> *)models;

@end

NS_ASSUME_NONNULL_END

#endif
