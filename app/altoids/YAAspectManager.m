//
//  YAAspectManager.m
//  altoids
//
//  Created by Srinivas Raovasudeva on 11/9/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAAspectManager.h"
#import "AOPProxy.h"
#import <objc/runtime.h>

// Private class extension
@interface YAAspectManager ()

// @property definitions

// methods
- (void)logStart:(NSInvocation *)i;
- (void)logEnd:(NSInvocation *)i;

@end

@implementation YAAspectManager

// Class methods
#pragma mark -
#pragma mark Class methods

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)init
{
  self = [super init];
  if (self) {
    // Initialization code here.
  }
  
  return self;
}

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark <Protocol Name> delegate methods

// Public methods
#pragma mark -
#pragma mark Public methods
- (void) logStart:(NSInvocation *) i {
    if (![i argumentsRetained]) {
        [i retainArguments];
    }
    
    NSLog(@"[START]: %@ > %@", NSStringFromClass([[i target] class]), NSStringFromSelector([i selector]));

    NSUInteger numArgs = [[i methodSignature] numberOfArguments];

    for (int index=2; index < numArgs; index++) {
        id argument = nil;
        [i getArgument:&argument atIndex:index];

//        LOG_EXPR(argument);
//        const char* className = object_getClassName(argument);
//        if ([NSString stringWithCString:className encoding:NSUTF8StringEncoding]==@"nil") {
//            return;
//        }
//        
//        NSLog(@"CLASS: %@",[NSString stringWithCString:className encoding:NSUTF8StringEncoding]);
//        
//        if ([argument isKindOfClass:[NSObject class]]) {
//            NSLog(@"ARG[%d]<%@>: %@",index, NSStringFromClass([argument class]),argument);
//        }
        
//        const char * argType = [[i methodSignature] getArgumentTypeAtIndex:index];
//        if ([[NSString stringWithCString:argType encoding:NSUTF8StringEncoding] isEqualToString:@"@"]) {
//            
//        }
    }
}

- (void) logEnd:(NSInvocation *) i {
    if (![i argumentsRetained]) {
        [i retainArguments];
    }

    NSLog(@"[STOP]: %@ > %@", NSStringFromClass([[i target] class]), NSStringFromSelector([i selector]));

//    id returnValue = nil;
//    if ([[i methodSignature] methodReturnLength] > 0) {
//        
//        NSLog(@"return type: %@",[NSString stringWithCString:[[i methodSignature] methodReturnType] encoding:NSUTF8StringEncoding]);
//        
//        if ([[NSString stringWithCString:[[i methodSignature] methodReturnType] encoding:NSUTF8StringEncoding] isEqualToString:@"@"] && returnValue) {
//            [i getReturnValue:&returnValue];
//            [returnValue retain];
//
//            NSLog(@"[RETURN]: %@",returnValue); 
//            
//            [returnValue release];
//        }        
//    }
}

- (void)instrumentAllMethodsForInstance:(AOPProxy *)instance
{
    Class objClass = object_getClass([instance parentObject]);
    
    const char* className = class_getName(objClass);
    NSString *classNameStr = [NSString stringWithUTF8String:className];
    NSLog(@"<CLASS>: %@",classNameStr);
    
    unsigned int numMethods;
    Method *methods = class_copyMethodList(objClass, &numMethods);
    
    for (int j=0; j < numMethods; j++) {
        Method method = (Method)methods[j];
        SEL methodSelector = method_getName(method);
        const char* selectorName = sel_getName(methodSelector);
        
        [instance interceptMethodStartForSelector:methodSelector 
                                        withInterceptorTarget:self 
                                          interceptorSelector:@selector(logStart:)];
                
        [instance interceptMethodEndForSelector:methodSelector
                                      withInterceptorTarget:self
                                        interceptorSelector:@selector(logEnd:)];

        NSLog(@"Instrumented <METHOD>: %@",[NSString stringWithUTF8String:selectorName]);
    }
    
    free(methods);
}

//- (void)printMethodsForAllRegisteredClasses
//{
//    int numClasses;
//    Class * classes = NULL;
//    
//    classes = NULL;
//    numClasses = objc_getClassList(NULL, 0);
//    
//    if (numClasses > 0 )
//    {
//        classes = (Class *)malloc(sizeof(Class) * numClasses);
//        numClasses = objc_getClassList(classes, numClasses);
//        
//        for (int i = 0; i < numClasses; i++) {
//            Class registeredClass = (Class)classes[i];
//            const char* className = class_getName(registeredClass);
//            NSString *classNameStr = [NSString stringWithUTF8String:className];
//
//            if ([classNameStr rangeOfString:@"YA"].location==0 &&
//                [classNameStr rangeOfString:@"YA"].length==2) {
//                NSLog(@"<CLASS>: %@",classNameStr);
//                
//                unsigned int numMethods;
//                Method *methods = class_copyMethodList(registeredClass, &numMethods);
//                
//                for (int j=0; j < numMethods; j++) {
//                    Method method = (Method)methods[j];
//                    SEL methodSelector = method_getName(method);
//                    const char* selectorName = sel_getName(methodSelector);
//                    NSLog(@"<METHOD>: %@",[NSString stringWithUTF8String:selectorName]);                    
//                }
//                
//                free(methods);
//            }
//        }
//        
//        free(classes);
//    }
//}

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YAAspectManager ()

@end
