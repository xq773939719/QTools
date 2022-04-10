//
//  ViewModel.m
//
//  Created by XQ on 2022/3/11.
//

#import "BaseHeader.h"

@implementation ViewModel

#pragma mark - SetupModel

- (BOOL)bind {
    [self setupModel];
    [self bindOnModelChange];
    return YES;
}

- (void)setupModel {
    NSAssert(NO, @"未实现该装载方法");
}

- (void)bindOnModelChange {
    NSAssert(NO, @"未实现该监听方法");
}

#pragma mark SetupView

- (BOOL)setup {
    [self setupViews];
    [self bindOnViewChange];
    return YES;
}

- (void)setupViews {
    NSAssert(NO, @"未实现该装载方法");
}

- (void)bindOnViewChange {
    NSAssert(NO, @"未实现该监听方法");
}

@end
