//
//  FeatureModel.h
//
//  Created by XQ on 2022/1/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FeatureModel : NSObject

@property (nonatomic, strong) NSString *key;
@property (nonatomic, assign) BOOL status;
@property (nonatomic, strong) NSDictionary *extend;

@end

NS_ASSUME_NONNULL_END
