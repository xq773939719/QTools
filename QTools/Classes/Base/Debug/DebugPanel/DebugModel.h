//
//  DebugModel.h
//
//  Created by XQ on 2022/4/7.
//

#if TARGET_OS_IPHONE

#import "BaseHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface DebugModel : NSObject

@property (nonatomic, strong) NSString *title;
@property(nonatomic, copy) void (^onClick)();

@end

NS_ASSUME_NONNULL_END

#endif
