//
//  YASetFiltererTests.m
//  altoids
//
//  Created by Derrick Whittle on 3/3/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YATestCase.h"
#import "YASetFilterer.h"
#import "MutableSetCreator.h"

@interface YASetFiltererTests : SenTestCase
{
    YASetFilterer* filterer;

    id mutableSetCreatorMock;

    id predicateMock;
}
@end

@implementation YASetFiltererTests

- (void) setUp
{
    mutableSetCreatorMock = [OCMockObject mockForProtocol:@protocol(MutableSetCreator)];

    filterer = [[YASetFilterer alloc] init];
    [filterer setMutableSetCreator:mutableSetCreatorMock];

    predicateMock = [OCMockObject mockForClass:[NSPredicate class]];
}


//
// setFromSet:filteredWithPredicate:
//

- (void) testSetFromSetFilteredWithPredicateShouldReturnNewEmptySetGivenEmptySet
{
    NSSet* set = [NSSet set];
    [[[mutableSetCreatorMock expect] andReturn:[NSMutableSet set]] mutableSetWithCapacity:[set count]];

    NSSet* result = [filterer setFromSet:set filteredWithPredicate:predicateMock];
    STAssertTrue([result isEqualToSet:set], nil);
    STAssertTrue(set != result, nil);
    [mutableSetCreatorMock verify];
}

- (void) testSetFromSetFilteredWithPredicateShouldReturnEmptySetGivenNilSet
{
    [[[mutableSetCreatorMock expect] andReturn:[NSMutableSet set]] mutableSetWithCapacity:0];
    NSSet* result = [filterer setFromSet:nil filteredWithPredicate:predicateMock];
    STAssertTrue([result count] == 0, nil);
}

- (void) testSetFromSetFilteredWithPredicateShouldReturnEmptySetWhenGivenNilPredicate
{
    NSSet* set = [NSSet setWithObjects:@"1", @"2", nil];
    [[[mutableSetCreatorMock expect] andReturn:[NSMutableSet set]] mutableSetWithCapacity:[set count]];

    NSSet* result = [filterer setFromSet:set filteredWithPredicate:nil];
    STAssertTrue([result count] == 0, nil);
    [mutableSetCreatorMock verify];
}

- (void) testSetFromSetFilteredWithPredicateShouldReturnSetContainingExactlyThoseObjectsFromGivenSetThatEvaluateForGivenPredicate
{
    NSSet* set = [NSSet setWithObjects:@"y1", @"y2", @"n3", @"n4", @"y5", nil];
    [[[mutableSetCreatorMock expect] andReturn:[NSMutableSet set]] mutableSetWithCapacity:[set count]];

    BOOL yes = YES;
    BOOL no = NO;
    [[[predicateMock expect] andReturnValue:OCMOCK_VALUE(yes)] evaluateWithObject:@"y1"];
    [[[predicateMock expect] andReturnValue:OCMOCK_VALUE(yes)] evaluateWithObject:@"y2"];
    [[[predicateMock expect] andReturnValue:OCMOCK_VALUE(yes)] evaluateWithObject:@"y5"];
    [[[predicateMock expect] andReturnValue:OCMOCK_VALUE(no)] evaluateWithObject:@"n3"];
    [[[predicateMock expect] andReturnValue:OCMOCK_VALUE(no)] evaluateWithObject:@"n4"];

    NSSet* result = [filterer setFromSet:set filteredWithPredicate:predicateMock];
    STAssertTrue([result count] == 3, nil);
    STAssertTrue([result containsObject:@"y1"], nil);
    STAssertTrue([result containsObject:@"y2"], nil);
    STAssertTrue([result containsObject:@"y5"], nil);
    [mutableSetCreatorMock verify];
    [predicateMock verify];
}

- (void) testSetFromSetFilteredWithPredicateShouldReturnEmptySetWhenNoObjectFromGivenSetEvalutesForGivenPredicate
{
    NSSet* set = [NSSet setWithObject:@"test"];
    [[[mutableSetCreatorMock expect] andReturn:[NSMutableSet set]] mutableSetWithCapacity:[set count]];
    
    BOOL no = NO;
    [[[predicateMock expect] andReturnValue:OCMOCK_VALUE(no)] evaluateWithObject:@"test"];

    NSSet* result = [filterer setFromSet:set filteredWithPredicate:predicateMock];
    STAssertTrue([result count] == 0, nil);
    [mutableSetCreatorMock verify];
    [predicateMock verify];
}


@end
