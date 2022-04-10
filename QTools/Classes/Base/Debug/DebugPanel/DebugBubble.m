//
//  DebugBubble.m
//
//  Created by XQ on 2022/4/7.
//

#if TARGET_OS_IPHONE

#import "DebugBubble.h"

#import "BaseHeader.h"
#import "DebugModel.h"
#import "DebugPanelDataProvider.h"

@interface DebugBubble ()

@property (nonatomic, strong) NSLock *lock;
@property (nonatomic, assign) BOOL isShow;
@property (nonatomic, strong) DebugPanelDataProvider<BaseModelProviderProtocol> *dataProvider;
@property (nonatomic, strong) NSArray<DebugModel *> *models;

@end

@implementation DebugBubble

+ (instancetype)share {
    static DebugBubble *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance) {
            instance = [DebugBubble new];
        }
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.isShow = NO;
        self.dataProvider = [DebugPanelDataProvider new];
        self.models = self.dataProvider.models;
    }
    return self;
}

- (void)show {
    [self.lock lock];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Debug面板"
                                                                             message:@""
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    
    [self.models enumerateObjectsUsingBlock:^(DebugModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [alertController addAction: [UIAlertAction actionWithTitle:obj.title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [UIApplication.sharedApplication.window.rootViewController dismissViewControllerAnimated:YES completion:^{
                obj.onClick();
            }];
        }]];
    }];
    
    [alertController addAction: [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [UIApplication.sharedApplication.window.rootViewController presentViewController:alertController animated:YES completion:^{
        self.isShow = YES;
        [self.lock unlock];
    }];
}

- (void)hide {
    [self.lock lock];
    [UIApplication.sharedApplication.window.rootViewController dismissViewControllerAnimated:YES completion:^{
        self.isShow = NO;
        [self.lock unlock];
    }];
}

#pragma mark - private method

- (NSLock *)lock {
    if (_lock) {
        return _lock;
    }
    _lock = [NSLock new];
    return _lock;
}

@end

#endif
