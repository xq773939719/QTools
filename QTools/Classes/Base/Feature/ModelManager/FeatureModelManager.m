//
//  FeatureModelManager.m
//
//  Created by XQ on 2022/1/21.
//

#import "FeatureModelManager.h"
#import "FeatureModel.h"

@interface FeatureModelManager ()

@property (nonatomic, strong) NSLock *lock;
@property (nonatomic, strong) NSMutableDictionary<NSString *, FeatureModel *> *featureDictionary;

@end

@implementation FeatureModelManager

- (instancetype)init {
    self = [super init];
    if (self) {
        self.featureDictionary = [NSMutableDictionary dictionary];
        self.lock = [NSLock new];
    }
    return self;
}

- (BOOL)setFeatureModel:(FeatureModel *)model {
    if (!model) {
        return NO;
    }
    [self.lock lock];
    [self.featureDictionary setObject:model forKey:model.key];
    [self.lock unlock];
    return YES;
}

- (FeatureModel *)getFeatureModelForKey:(NSString *)key {
    FeatureModel *model = nil;
    [self.lock lock];
    model = [self.featureDictionary objectForKey:key];
    [self.lock unlock];
    return model;
}

@end
