//
//  YAThreader.m
//  altoids
//
//  Created by Derrick Whittle on 2/13/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAThreader.h"

@interface YAThreader()
- (NSInvocation *) invocationForSelector:(SEL)selector onTarget:(NSObject*)target withObject:(id)argument andObject:(id)anotherArgument;
- (void) methodSignaturePrototypeWithArg:(id)arg0 andArg:(id)arg1;
@end


@implementation YAThreader

@synthesize thread = thread_;

- (void) asyncPerformSelector:(SEL)selector onTarget:(NSObject *)target
{
    [target performSelector:selector onThread:thread_ withObject:nil waitUntilDone:NO];
}

- (void) asyncPerformSelector:(SEL)selector onTarget:(NSObject *)target withObject:(id)argument
{
    [target performSelector:selector onThread:thread_ withObject:argument waitUntilDone:NO];
}

- (void) asyncPerformSelector:(SEL)selector onTarget:(NSObject *)target withObject:(id)argument andObject:(id)anotherArgument
{
    NSInvocation *invocation = [self invocationForSelector:selector onTarget:target withObject:argument andObject:anotherArgument];
    
    [self asyncPerformSelector:@selector(invoke) onTarget:invocation];
}

- (void) performSelector:(SEL)selector onTarget:(NSObject*)target
{
    [target performSelector:selector onThread:[self thread] withObject:nil waitUntilDone:YES];
}

- (void) performSelector:(SEL)selector onTarget:(NSObject*)target withObject:(id)argument;
{
    [target performSelector:selector onThread:[self thread] withObject:argument waitUntilDone:YES];
}

- (void) performSelector:(SEL)selector onTarget:(NSObject*)target withObject:(id)argument andObject:(id)anotherArgument
{
    NSInvocation* invocation = [self invocationForSelector:selector onTarget:target withObject:argument andObject:anotherArgument];
    
    [self performSelector:@selector(invoke) onTarget:invocation];
}

- (NSInvocation *) invocationForSelector:(SEL)selector onTarget:(NSObject*)target withObject:(id)argument andObject:(id)anotherArgument
{
    NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:@selector(methodSignaturePrototypeWithArg:andArg:)]];
    [invocation setTarget:target];
    [invocation setSelector:selector];
    [invocation setArgument:&argument atIndex:2];
    [invocation setArgument:&anotherArgument atIndex:3];
    
    return invocation;
}


- (void) methodSignaturePrototypeWithArg:(id)arg0 andArg:(id)arg1
{
    // this method exists only to provide an invocation method signature for use by blockToPerformSelector:onTarget:withObject:andObject:
}

@end
