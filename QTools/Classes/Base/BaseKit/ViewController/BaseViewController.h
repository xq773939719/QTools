//
//  BaseViewController.h
//
//  Created by XQ on 2022/1/24.
//

#import "BaseKitHeader.h"

NS_ASSUME_NONNULL_BEGIN

@class ViewModel;

@protocol ViewProtocol <NSObject>

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
/// 数据逻辑请求
- (void)loadData:(void (^)(BOOL))callback;
/// 视图逻辑更新
- (void)updateViews;

@end

@protocol ViewModelProtocol <NSObject>

- (void)bindViewModel:(ViewModel *)viewModel;

@end

@interface BaseViewController : VIEW_CONTROLLER <ViewProtocol, RoutableProtocol, LogicProtocol, ViewModelProtocol>

@property (nonatomic, strong, readonly) VIEW *rootContainer;
@property (nonatomic, strong, readonly) NSMutableArray<ViewModel *> *viewModels;

@end

NS_ASSUME_NONNULL_END
