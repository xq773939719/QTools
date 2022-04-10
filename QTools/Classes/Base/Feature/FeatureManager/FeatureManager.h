//
//  FeatureManager.h
//
//  Created by XQ on 2022/1/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class FeatureModel;

@interface FeatureManager : NSObject

+ (instancetype)share;

- (BOOL)setFeatureModel:(FeatureModel *)model;

- (nullable FeatureModel *)getFeatureModelForKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
