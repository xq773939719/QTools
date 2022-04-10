//
//  ViewModel.h
//
//  Created by XQ on 2022/3/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class BaseViewController;

@protocol ViewModel <NSObject>

/// ① 绑定Model
- (BOOL)bind;

/// ② 装载UI
- (BOOL)setup;

@end

@interface ViewModel : NSObject <ViewModel>

@property (nonatomic, weak) BaseViewController *delegate;

- (void)setupModel;
- (void)bindOnModelChange;
- (void)setupViews;
- (void)bindOnViewChange;

@end

NS_ASSUME_NONNULL_END
