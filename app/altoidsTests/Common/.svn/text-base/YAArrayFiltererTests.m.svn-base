//
//  YAArrayFiltererTests.m
//  altoids
//
//  Created by Jon Herron on 9/28/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAArrayFiltererTests.h"
#import "YAArrayFilterer.h"
#import "MutableArrayCreator.h"

@interface YAArrayFiltererTests()

@property (strong, nonatomic) id arrayMock;
@property (strong, nonatomic) id predicateMock;
@property (strong, nonatomic) id mutableArrayCreatorMock;
@property (strong, nonatomic) YAArrayFilterer *arrayFilterer;

@end

@implementation YAArrayFiltererTests

@synthesize arrayMock = arrayMock_;
@synthesize predicateMock = predicateMock_;
@synthesize mutableArrayCreatorMock = mutableArrayCreatorMock_;
@synthesize arrayFilterer = arrayFilterer_;

- (void)setUp
{
    [super setUp];
    
    [self setArrayMock:[OCMockObject mockForClass:[NSArray class]]];
    [self setPredicateMock:[OCMockObject mockForClass:[NSPredicate class]]];
    [self setMutableArrayCreatorMock:[OCMockObject mockForProtocol:@protocol(MutableArrayCreator)]];

    [self setArrayFilterer:[[YAArrayFilterer alloc] init]];
    [[self arrayFilterer] setMutableArrayCreator:[self mutableArrayCreatorMock]];
}

//
// filterArray:usingPredicate:
//

- (void)testFilterArrayUsingPredicateReturnsResultsOfHavingArrayFilteredWithPredicate
{
    NSArray *filteredArray = [NSArray array];
    
    [[[[self arrayMock] expect] andReturn:filteredArray] filteredArrayUsingPredicate:[self predicateMock]];
    
    STAssertEqualObjects(filteredArray, [[self arrayFilterer] filterArray:[self arrayMock] usingPredicate:[self predicateMock]], @"Unexpected filtered array");
}

//
// arrayFromArray:excludingObjectsInSet:
//
// these are far from exhaustive tests...

- (void)testArrayFromArrayExcludingObjectsInSetShouldReturnEmptyArrayGivenEmptyArray
{
    NSArray* array = [NSArray array];
    NSSet* set = [NSSet setWithObject:@"whatever"];
    [[[mutableArrayCreatorMock_ stub] andReturn:[NSMutableArray array]] mutableArrayWithCapacity:[array count]];

    NSArray* result = [arrayFilterer_ arrayFromArray:array excludingObjectsInSet:set];
    STAssertTrue([result isKindOfClass:[NSArray class]], nil);
    STAssertTrue(![result count], nil);
    STAssertTrue(result != array, nil);
}

- (void)testArrayFromArrayExcludingObjectsInSetShouldReturnOnlyObjectsContainedInGivenSet
{
    NSArray* array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil];
    NSSet* set = [NSSet setWithObjects:@"1", @"3", @"5", nil];
    [[[mutableArrayCreatorMock_ stub] andReturn:[NSMutableArray array]] mutableArrayWithCapacity:[array count]];

    NSArray* result = [arrayFilterer_ arrayFromArray:array excludingObjectsInSet:set];
    STAssertTrue([result count] == 2, nil);
    STAssertTrue([result containsObject:@"2"], nil);
    STAssertTrue([result containsObject:@"4"], nil);
    STAssertTrue(result != array, nil);
}

- (void)testArrayFromArrayExcludingObjectsInSetShouldReturnMultipleInstancesOfObjectRepeatedInArray
{
    NSArray* array = [NSArray arrayWithObjects:@"1", @"2", @"1", @"3", @"1", nil];
    NSSet* set = [NSSet setWithObjects:@"2", @"3", nil];
    [[[mutableArrayCreatorMock_ stub] andReturn:[NSMutableArray array]] mutableArrayWithCapacity:[array count]];

    NSArray* result = [arrayFilterer_ arrayFromArray:array excludingObjectsInSet:set];
    STAssertTrue([result count] == 3, nil);
    NSArray* expectedArray = [NSArray arrayWithObjects:@"1", @"1", @"1", nil];
    STAssertTrue([result isEqualToArray:expectedArray], nil);
    STAssertTrue(result != array, nil);
}

@end
