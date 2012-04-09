//
//  YATestCase.m
//  altoids
//
//  Created by Derrick Whittle on 2/24/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YATestCase.h"
#import <objc/runtime.h>

@implementation YATestCase


- (NSUInteger) retainCountForObject:(NSObject* __unsafe_unretained)object
{
    NSNumber* retainCount = [object valueForKey:@"retainCount"];
    return [retainCount unsignedIntValue];
}

- (void) swizzleSelector:(SEL)originalSelector
                 inClass:(Class)originalClass
               withBlock:(id)implementationBlock
              asSelector:(SEL)dummySelector
                 inClass:(Class)substitutingClass
            executeBlock:(void (^)(void))block
{
    Method originalMethod = class_getInstanceMethod(originalClass, originalSelector);

    IMP implementation = imp_implementationWithBlock((__bridge void*)[implementationBlock copy]);
    class_addMethod(substitutingClass, dummySelector, implementation, "");

    Method swizzledMethod = class_getInstanceMethod(substitutingClass, dummySelector);
    method_exchangeImplementations(originalMethod, swizzledMethod);

    block();

    method_exchangeImplementations(swizzledMethod, originalMethod);
}

- (void) tearDown
{
    // automatically verify all mock objects
    
    unsigned int instanceVariablesCount;
    Ivar* instanceVariables = class_copyIvarList([self class], &instanceVariablesCount);
    for(int i = 0; i < instanceVariablesCount; ++i)
    {
        Ivar ivar = instanceVariables[i];

        // ignore instance variables that are not bare id objects
        const char const* typeEncoding = ivar_getTypeEncoding(ivar);
        if(!(typeEncoding && !(*(typeEncoding + 1)) && *typeEncoding == '@'))
        {
            continue;
        }

        id instanceVariable = object_getIvar(self, ivar);
        
        // ignore instance variables that do not look like mock objects
        // (until we find some reason not to, we assume all proxy objects are mock objects)
        // (respondsToSelector:@selector(verify) always returns NO even for real mock objects
        if(![instanceVariable isProxy])
        {
            continue;
        }

        [instanceVariable verify];
    }

    free(instanceVariables);
}

@end
