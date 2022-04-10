//
//  DebugPanelDataProvider.m
//
//  Created by XQ on 2022/4/7.
//

#if TARGET_OS_IPHONE

#import "DebugPanelDataProvider.h"
#import "DebugLookinModel/DebugLookinModel.h"

@implementation DebugPanelDataProvider

- (NSArray<DebugModel *> *)models {
    NSArray *array = @[
        [DebugLookinModel new],
    ];
    
    return array;
}

@end

#endif
