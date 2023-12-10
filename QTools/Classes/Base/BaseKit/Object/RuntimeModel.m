//
//  RuntimeModel.m
//
//  Created by XQ on 2023/12/6.
//

#import "RuntimeModel.h"

@implementation RuntimeModel

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSLog(@"第一次机会 %@", @(__func__));
    return [super resolveInstanceMethod:sel];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSLog(@"第二次机会 %@", @(__func__));
    // return [ARuntimeModel new];
    return nil;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSLog(@"第三次机会 %@", @(__func__));
    return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"第三次机会 %@, %@", @(__func__), anInvocation);
    /*
    BRuntimeModel *model = [BRuntimeModel new]; // self;
    anInvocation.target = model;
    anInvocation.selector = @selector(hook);
    [anInvocation invoke];
     */
}

/**
 第一次机会 +[ARuntimeModel resolveInstanceMethod:]
 第二次机会 -[ARuntimeModel forwardingTargetForSelector:]
 第三次机会 -[ARuntimeModel methodSignatureForSelector:]
 第一次机会 +[ARuntimeModel resolveInstanceMethod:]
 第三次机会 -[ARuntimeModel forwardInvocation:], <NSInvocation: 0x60000175c180>
 -[BRuntimeModel hook]
 */

+ (void)__hook__ {
    NSLog(@"Crash Hook: %@", @(__func__));
    NSLog(@"Crash Hook: %@", [NSThread callStackSymbols]);
    // NSLog(@"Crash Hook: %@", [NSThread callStackReturnAddresses]);
    // NSAssert(NO, @"Crash Hook");
}

- (void)__hook__ {
    NSLog(@"Crash Hook: %@", @(__func__));
    NSLog(@"Crash Hook: %@", [NSThread callStackSymbols]);
    // NSLog(@"Crash Hook: %@", [NSThread callStackReturnAddresses]);
    // NSAssert(NO, @"Crash Hook");
}

@end
