//
//  YATestCase.h
//  altoids
//
//  Created by Derrick Whittle on 2/24/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SenTestingKit/SenTestingKit.h>
#import <OCMock/OCMock.h>

// we define retain count getter as a macro instead of a method to avoid having our retain count getter itself actually retain the object
#define YA_TEST_RETAIN_COUNT(object) [[object valueForKey:@"retainCount"] unsignedIntValue]

@interface YATestCase : SenTestCase

- (NSUInteger) retainCountForObject:(NSObject* __unsafe_unretained)object;

- (void) swizzleSelector:(SEL)originalSelector
                 inClass:(Class)originalClass
               withBlock:(id)implementationBlock
              asSelector:(SEL)dummySelector
                 inClass:(Class)substitutingClass
            executeBlock:(void (^)(void))block;

@end
