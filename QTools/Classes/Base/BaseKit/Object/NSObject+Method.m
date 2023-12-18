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

@implementation NSObject (MethodSwizzling)

// 交换两个类方法的实现
+ (void)qDefenderSwizzlingClassMethod:(SEL)originalSelector withMethod:(SEL)swizzledSelector withClass:(Class)targetClass {
    swizzlingClassMethod(targetClass, originalSelector, swizzledSelector);
}

// 交换两个对象方法的实现
+ (void)qDefenderSwizzlingInstanceMethod:(SEL)originalSelector withMethod:(SEL)swizzledSelector withClass:(Class)targetClass {
    swizzlingInstanceMethod(targetClass, originalSelector, swizzledSelector);
}

// 交换两个类方法的实现 C 函数
void swizzlingClassMethod(Class class, SEL originalSelector, SEL swizzledSelector) {

    Method originalMethod = class_getClassMethod(class, originalSelector);
    Method swizzledMethod = class_getClassMethod(class, swizzledSelector);

    BOOL didAddMethod = class_addMethod(class,
                                        originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));

    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

// 交换两个对象方法的实现 C 函数
void swizzlingInstanceMethod(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);

    BOOL didAddMethod = class_addMethod(class,
                                        originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));

    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
