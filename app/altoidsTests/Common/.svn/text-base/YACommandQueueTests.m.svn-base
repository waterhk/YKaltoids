//
//  YACommandQueueTests.m
//  altoids
//
//  Created by Derrick Whittle on 2/22/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <OCMock/OCMock.h>
#import "YACommandQueue.h"
#import "OperationCreator.h"

@interface YACommandQueueTests : SenTestCase
@end


@implementation YACommandQueueTests

// no setUp or class-level variables since one of our only two tests is for init, which you can't test compatibly with setUp anyway

- (void) testInitWithOperationQueueMaxConcurrentOperationCountShouldSetPropertyToGivenOperationQueueAndSetItsMaxConcurrentOperationCount
{
    id operationQueueMock = [OCMockObject mockForClass:[NSOperationQueue class]];
    NSInteger maxConcurrentOperationCount = 404404;
    
    [[operationQueueMock expect] setMaxConcurrentOperationCount:maxConcurrentOperationCount];

    YACommandQueue* commandQueue = [[YACommandQueue alloc] initWithOperationQueue:operationQueueMock maxConcurrentOperationCount:maxConcurrentOperationCount];
    STAssertEquals(operationQueueMock, [commandQueue operationQueue], nil);
    [operationQueueMock verify];
}

- (void) testAppendShouldCreateOperationWithGivenCommandAndAddToOperationQueue
{
    id operationQueueMock = [OCMockObject mockForClass:[NSOperationQueue class]];
    id operationCreatorMock = [OCMockObject mockForProtocol:@protocol(OperationCreator)];
    id operation = [OCMockObject mockForClass:[NSOperation class]];
    id command = [OCMockObject mockForProtocol:@protocol(Command)];

    [[operationQueueMock expect] setMaxConcurrentOperationCount:(NSInteger)0];

    YACommandQueue* commandQueue = [[YACommandQueue alloc] initWithOperationQueue:operationQueueMock maxConcurrentOperationCount:0];
    [commandQueue setOperationCreator:operationCreatorMock];
    
    [[[operationCreatorMock expect] andReturn:operation] createOperationWithCommand:command];
    [[operationQueueMock expect] addOperation:operation];

    [commandQueue append:command];
    [operationCreatorMock verify];
    [operationQueueMock verify];
}

- (void) testCountShouldReturnOperationCountOfOperationQueue
{
    NSUInteger expectedCount = 8008;
    id operationQueueMock = [OCMockObject mockForClass:[NSOperationQueue class]];
    [[operationQueueMock stub] setMaxConcurrentOperationCount:(NSInteger)0];
    [[[operationQueueMock expect] andReturnValue:OCMOCK_VALUE(expectedCount)] operationCount];

    YACommandQueue* commandQueue = [[YACommandQueue alloc] initWithOperationQueue:operationQueueMock maxConcurrentOperationCount:0];

    NSUInteger count = [commandQueue count];
    STAssertEquals(expectedCount, count, nil);
    [operationQueueMock verify];
}

@end
