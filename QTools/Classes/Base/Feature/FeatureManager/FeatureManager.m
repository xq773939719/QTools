//
//  FeatureManager.m
//
//  Created by XQ on 2022/1/21.
//

#import "FeatureManager.h"
#import "FeatureModelManager.h"
#import "FeatureModel.h"

@interface FeatureManager ()

@property (nonatomic, strong) FeatureModelManager *modelManager;

@end

@implementation FeatureManager

+ (void)load {
    [self share];
}

+ (instancetype)share {
    static FeatureManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance) {
            instance = [FeatureManager new];
        }
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modelManager = [FeatureModelManager new];
        [self initModels];
    }
    return self;
}

- (void)initModels {
    /*
    NSArray<NSDictionary *> *array = @[
        @{@"key": @"key1", @"status": @(YES)},
        @{@"key": @"key2", @"status": @(YES)},
        @{@"key": @"key3", @"status": @(NO)},
        @{@"key": @"key4", @"status": @(NO)},
        @{@"key": @"key5", @"status": @(NO)},
        @{@"key": @"learn", @"status": @(NO)}
    ];
    [array enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        FeatureModel *model = [FeatureModel new];
        
        NSString *key = obj[@"key"];
        BOOL status = (BOOL)[obj[@"status"] integerValue];
        model.key = key;
        model.status = status;
        [self.modelManager setFeatureModel:model];
    }];
    */
}

- (BOOL)setFeatureModel:(FeatureModel *)model {
    return [self.modelManager setFeatureModel:model];
}

- (nullable FeatureModel *)getFeatureModelForKey:(NSString *)key {
    return [self.modelManager getFeatureModelForKey:key];
}

@end
