//
//  NSObject+Method.m
//
//  Created by XQ on 2022/1/28.
//

#import "NSObject+Method.h"
#import <objc/runtime.h>
#import "RuntimeModel.h"

@implementation NSObject (Method)

+ (id)forwardingTargetForSelector:(SEL)aSelector {
    return nil;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return nil;
}

+ (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *signature = [self instanceMethodSignatureForSelector:aSelector];
    if (!signature) {
        signature = [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    }
    return signature;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *signature = [self.class instanceMethodSignatureForSelector:aSelector];
    if (!signature) {
        signature = [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    }
    return signature;
}

+ (void)forwardInvocation:(NSInvocation *)anInvocation {
    if ([self respondsToSelector:anInvocation.selector]) {
        [anInvocation invoke];
        return;
    }
    if ([RuntimeModel respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:RuntimeModel.class];
    }
    anInvocation.target = RuntimeModel.class;
    anInvocation.selector = @selector(__hook__);
    [anInvocation invoke];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    if ([self respondsToSelector:anInvocation.selector]) {
        [anInvocation invoke];
        return;
    }
    RuntimeModel *model = [RuntimeModel new];
    if ([model respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:model];
    }
    anInvocation.target = model;
    anInvocation.selector = @selector(__hook__);
    [anInvocation invoke];
}

/**
 第一次机会 +[ARuntimeModel resolveInstanceMethod:]
 第二次机会 -[ARuntimeModel forwardingTargetForSelector:]
 第三次机会 -[ARuntimeModel methodSignatureForSelector:]
 第一次机会 +[ARuntimeModel resolveInstanceMethod:]
 第三次机会 -[ARuntimeModel forwardInvocation:], <NSInvocation: 0x60000175c180>
 -[BRuntimeModel hook]
 */


@end
