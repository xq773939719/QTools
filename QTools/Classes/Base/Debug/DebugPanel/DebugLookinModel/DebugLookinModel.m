//
//  DebugLookinModel.m
//
//  Created by XQ on 2022/4/7.
//

#if TARGET_OS_IPHONE

#import "DebugLookinModel.h"

@implementation DebugLookinModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"Lookin调试";
        self.onClick = ^{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Lookin功能列表"
                                                                                     message:@""
                                                                              preferredStyle:UIAlertControllerStyleActionSheet];
            [alertController addAction: [UIAlertAction actionWithTitle:@"导出为Lookin文档" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"Lookin_Export" object:nil];
            }]];
            
            [alertController addAction: [UIAlertAction actionWithTitle:@"进入 2D 模式" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"Lookin_2D" object:nil];
            }]];
            
            [alertController addAction: [UIAlertAction actionWithTitle:@"进入 3D 模式" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"Lookin_3D" object:nil];
            }]];
            
            [alertController addAction: [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            
            [UIApplication.sharedApplication.window.rootViewController presentViewController:alertController animated:YES completion:nil];
        };
    }
    return self;
}

@end

#endif
