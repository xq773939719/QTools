//
//  BaseViewController.h
//
//  Created by XQ on 2022/1/24.
//

#import "BaseKitHeader.h"

NS_ASSUME_NONNULL_BEGIN

@class ViewModel;
@class ViewControllerContext;

@protocol ContextProtocol <NSObject>

@property (nonatomic, strong, readonly) ViewControllerContext *context;

@end

@protocol ViewProtocol <NSObject>

#if TARGET_OS_OSX
/// 不使用xib方式需要补充View
+ (CGSize) viewSize;
#endif

- (void)addSubview:(VIEW *)view;

@end


@protocol RoutableProtocol <NSObject>

+ (NSString *)scheme;

@end

@protocol LogicProtocol <NSObject>

/// 初始化默认图框架
- (void)initDefaultViews;
/// 初始化逻辑数据
- (void)setupData;
/// 初始化逻辑子视图
- (void)setupViews;
/// 布局逻辑子视图
- (void)layoutViews;
/// 数据逻辑请求
- (void)loadData:(void (^)(BOOL))callback;
/// 视图逻辑更新
- (void)updateViews;

@end

@protocol ViewModelProtocol <NSObject>

- (void)bindViewModel:(ViewModel *)viewModel;

@end

@interface BaseViewController : VIEW_CONTROLLER <
ContextProtocol,
ViewProtocol,
RoutableProtocol,
LogicProtocol,
ViewModelProtocol
>

@property (nonatomic, weak) BaseEntranceManager *entranceManager;

/// VC上下文
@property (nonatomic, strong, readonly) ViewControllerContext *context;
/// VC容器
@property (nonatomic, strong, readonly) VIEW *rootContainer;
/// 绑定的VM
@property (nonatomic, strong, readonly) NSMutableArray<ViewModel *> *viewModels;

@end

NS_ASSUME_NONNULL_END
