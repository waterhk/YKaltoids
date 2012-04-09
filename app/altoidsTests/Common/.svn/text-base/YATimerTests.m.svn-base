//
//  YATimerTests.m
//  altoids
//
//  Created by Derrick Whittle on 2/20/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <OCMock/OCMock.h>
#import "YATimer.h"
#import "DateCreator.h"

@interface YATimerTests : SenTestCase
{
    YATimer* timer;

    id dateCreatorMock;
    NSMutableDictionary* accumulators;
}
@end


@implementation YATimerTests

- (void) setUp
{
    dateCreatorMock = [OCMockObject mockForProtocol:@protocol(DateCreator)];
    accumulators = [[NSMutableDictionary alloc] initWithCapacity:8];
    
    timer = [[YATimer alloc] init];
    [timer setDateCreator:dateCreatorMock];
    [timer setAccumulators:accumulators];
}

- (YATimeAccumulator*) createAccumulatorWithSeconds:(NSTimeInterval)seconds
{
    YATimeAccumulator* accumulator = [[YATimeAccumulator alloc] init];
    [accumulator setAccumulatedSeconds:seconds];
    return accumulator;
}

- (void) assertExpected:(NSTimeInterval)expected IsEqualToActual:(NSTimeInterval)actual withAccuracy:(NSTimeInterval)accuracy
{
    STAssertTrue(actual == actual, @"actual is NaN or somesuch, which unfortunately STAssertEqualsWithAccuracy doesn't catch");
    STAssertEqualsWithAccuracy(expected, actual, accuracy, nil);
}


//
// beginAccumulatingForTag
//

- (void) testBeginAccumulatingForTagShouldMapNewAccumulatorWithNowStartDateWhenGivenNewTag
{
    NSString* tag = @"some tag";
    NSDate* now = [NSDate alloc];
    
    [[[dateCreatorMock expect] andReturn:now] dateForNow];
    
    [timer beginAccumulatingForTag:tag];

    STAssertEquals((NSUInteger)1, [accumulators count], @"expected only 1 tag to be mapped");
    YATimeAccumulator* accumulator = [accumulators objectForKey:tag];
    STAssertEquals(0.0, [accumulator accumulatedSeconds], @"expected accumulator with 0 seconds");
    STAssertEquals(now, [accumulator startDate], @"expected accumulator's start date to be now");
}

- (void) testBeginAccumulatingForTagShouldUpdateMappedAccumulatorWithNowStartDateWhenGivenReusedTag
{
    NSString* tag = @"some tag";
    NSDate* now0 = [NSDate dateWithTimeIntervalSinceNow:0];
    NSDate* now1 = [NSDate alloc];
    
    [[[dateCreatorMock expect] andReturn:now0] dateForNow];    
    [timer beginAccumulatingForTag:tag];
    
    [[[dateCreatorMock expect] andReturn:[NSDate dateWithTimeIntervalSinceNow:0]] dateForNow];
    [timer stopAccumulatingForTag:tag];

    [[[dateCreatorMock expect] andReturn:now1] dateForNow];
    [timer beginAccumulatingForTag:tag];

    STAssertEquals((NSUInteger)1, [accumulators count], @"expected only 1 tag to be mapped");
    YATimeAccumulator* accumulator = [accumulators objectForKey:tag];
    STAssertEquals(now1, [accumulator startDate], @"expected accumulator's start date to be now");
}

- (void) testBeginAccumulatingForTagShouldThrowWhenAttemptingToOverlapTimingForSameTag
{
    NSString* tag = @"some tag";
    NSDate* now = [NSDate alloc];
    
    [[[dateCreatorMock expect] andReturn:now] dateForNow];    
    [timer beginAccumulatingForTag:tag];

    STAssertThrows([timer beginAccumulatingForTag:tag], nil);
}

//
// stopAccumulatingForTag
//

- (void) testStopAccumulatingForTagShouldThrowWithoutModifyingAccumulatorsGivenUnrecognizedTag
{
    [[[dateCreatorMock expect] andReturn:[NSDate dateWithTimeIntervalSinceNow:0]] dateForNow];
    [timer beginAccumulatingForTag:@"some tag"];
    
    NSMutableDictionary* copyOfAccumulators = [NSMutableDictionary dictionaryWithCapacity:[accumulators count]];
    [copyOfAccumulators addEntriesFromDictionary:accumulators];
    
    [[[dateCreatorMock expect] andReturn:[NSDate dateWithTimeIntervalSinceNow:0]] dateForNow];

    STAssertThrows([timer stopAccumulatingForTag:@"some other tag"], nil);
    
    STAssertEqualObjects(copyOfAccumulators, accumulators, @"expected accumulators to be unmodified");
}

- (void) testStopAccumulatingForTagShouldResetAccumulatorStartDateToNil
{
    NSString* tag = @"some tag";
    
    [[[dateCreatorMock expect] andReturn:[[NSDate alloc] initWithTimeIntervalSince1970:0]] dateForNow];    
    [timer beginAccumulatingForTag:tag];
    
    [[[dateCreatorMock expect] andReturn:[[NSDate alloc] initWithTimeIntervalSince1970:0]] dateForNow];
    [timer stopAccumulatingForTag:tag];
    
    YATimeAccumulator* accumulator = [accumulators objectForKey:tag];
    STAssertNil([accumulator startDate], nil);
}

- (void) testStopAccumulatingForTagShouldSetAccumulatorSecondsSinceStartForNewTag
{
    NSString* tag = @"some tag";
    NSTimeInterval expectedAccumulatedSeconds = 12345.6789;
    NSDate* begin = [[NSDate alloc] initWithTimeIntervalSince1970:0];
    NSDate* stop = [[NSDate alloc] initWithTimeIntervalSince1970:expectedAccumulatedSeconds];
    
    [[[dateCreatorMock expect] andReturn:begin] dateForNow];
    [timer beginAccumulatingForTag:tag];
    
    [[[dateCreatorMock expect] andReturn:stop] dateForNow];
    [timer stopAccumulatingForTag:tag];
    
    YATimeAccumulator* accumulator = [accumulators objectForKey:tag];
    [self assertExpected:expectedAccumulatedSeconds IsEqualToActual:[accumulator accumulatedSeconds] withAccuracy:0.0001];
}

- (void) testStopAccumulatingForTagShouldAddToAccumulatorSecondsSinceSubsequentStartForReusedTag
{
    NSString* tag = @"some tag";

    NSTimeInterval alreadyAccumulatedSeconds = 12345.6789;
    [accumulators setObject:[self createAccumulatorWithSeconds:alreadyAccumulatedSeconds] forKey:tag];

    NSTimeInterval newlyAccumulatedSeconds = 123.321;
    NSDate* begin = [[NSDate alloc] initWithTimeIntervalSince1970:0];
    NSDate* stop = [[NSDate alloc] initWithTimeIntervalSince1970:newlyAccumulatedSeconds];
    
    [[[dateCreatorMock expect] andReturn:begin] dateForNow];    
    [timer beginAccumulatingForTag:tag];
    [[[dateCreatorMock expect] andReturn:stop] dateForNow];
    [timer stopAccumulatingForTag:tag];

    YATimeAccumulator* accumulator = [accumulators objectForKey:tag];
    NSTimeInterval expectedAccumulatedSeconds = alreadyAccumulatedSeconds + newlyAccumulatedSeconds;
    
    [self assertExpected:expectedAccumulatedSeconds IsEqualToActual:[accumulator accumulatedSeconds] withAccuracy:0.0001];
}

//
// accumulatedSecondsForTag
//

- (void) testAccumulatedSecondsForTagShouldReturnAccumulatedSecondsFromAccumulatorsMappingOfTag
{
    NSString* tag = @"some tag";
    NSTimeInterval expectedAccumulatedSeconds = 8008.135;
    
    [accumulators setObject:[self createAccumulatorWithSeconds:1234.56] forKey:@"some other tag"];
    [accumulators setObject:[self createAccumulatorWithSeconds:expectedAccumulatedSeconds] forKey:tag];
    [accumulators setObject:[self createAccumulatorWithSeconds:9009009.1] forKey:@"yet another tag"];
    
    NSTimeInterval accumulatedSeconds = [timer accumulatedSecondsForTag:tag];
    [self assertExpected:expectedAccumulatedSeconds IsEqualToActual:accumulatedSeconds withAccuracy:0.0001];
}

- (void) testAccumulatedSecondsForTagShouldIncludeRunningTimeOfUnstoppedTimer
{
    NSString* tag = @"some tag";
    NSTimeInterval expectedAccumulatedSeconds = 8008.135;
    
    YATimeAccumulator* accumulator = [self createAccumulatorWithSeconds:0];
    [accumulator setStartDate:[NSDate dateWithTimeIntervalSince1970:0]];
    [accumulators setObject:accumulator forKey:tag];
    
    [[[dateCreatorMock expect] andReturn:[NSDate dateWithTimeIntervalSince1970:expectedAccumulatedSeconds]] dateForNow];
    
    NSTimeInterval accumulatedSeconds = [timer accumulatedSecondsForTag:tag];
    [self assertExpected:expectedAccumulatedSeconds IsEqualToActual:accumulatedSeconds withAccuracy:0.0001];
}

- (void) testAccumulatedSecondsForTagShouldThrowGivenUnrecognizedTag
{
    STAssertThrows([timer accumulatedSecondsForTag:@"tag that wasn't used for begin/stop"], nil);
}

//
// descriptionOfAccumulatedSecondsForAllTags
//

- (void) testDescriptionOfAccumulatedSecondsForAllTagsShouldReturnDescriptionOfAccumulatorsMap
{
    [accumulators setObject:[self createAccumulatorWithSeconds:1234.56] forKey:@"zerg"];
    [accumulators setObject:[self createAccumulatorWithSeconds:9009009.1] forKey:@"protoss"];
    
    NSString* expectedDescription = [accumulators description];
    NSString* description = [timer descriptionOfAccumulatedSecondsForAllTags];
    STAssertEqualObjects(expectedDescription, description, nil);
}

//
// integration
//

- (void) testTimerIntegration
{
    NSTimeInterval expectedTotal = 1234.5;
    NSTimeInterval expectedSomeStuff0 = 8008.135;
    NSTimeInterval expectedSomeStuff1 = 9009009.1;
    NSDate* startTotal = [NSDate dateWithTimeIntervalSince1970:0];
    NSDate* startSomeStuff0 = [NSDate dateWithTimeIntervalSince1970:1];
    NSDate* startSomeStuff1 = [NSDate dateWithTimeIntervalSince1970:1 + expectedSomeStuff0];

    [[[dateCreatorMock expect] andReturn:startTotal] dateForNow];
    [timer beginAccumulatingForTag:@"total"];
    
    [[[dateCreatorMock expect] andReturn:startSomeStuff0] dateForNow];
    [timer beginAccumulatingForTag:@"some stuff"];
    // work that does some stuff
    [[[dateCreatorMock expect] andReturn:[NSDate dateWithTimeInterval:expectedSomeStuff0 sinceDate:startSomeStuff0]] dateForNow];
    [timer stopAccumulatingForTag:@"some stuff"];

    [[[dateCreatorMock expect] andReturn:startSomeStuff1] dateForNow];
    [timer beginAccumulatingForTag:@"some stuff"];
    // more work that does some stuff
    [[[dateCreatorMock expect] andReturn:[NSDate dateWithTimeInterval:expectedSomeStuff1 sinceDate:startSomeStuff1]] dateForNow];
    [timer stopAccumulatingForTag:@"some stuff"];

    [[[dateCreatorMock expect] andReturn:[NSDate dateWithTimeInterval:expectedTotal sinceDate:startTotal]] dateForNow];
    [timer stopAccumulatingForTag:@"total"];

    [self assertExpected:expectedTotal IsEqualToActual:[timer accumulatedSecondsForTag:@"total"] withAccuracy:0.0001];
    [self assertExpected:expectedSomeStuff0 + expectedSomeStuff1 IsEqualToActual:[timer accumulatedSecondsForTag:@"some stuff"] withAccuracy:0.0001];
    STAssertEquals((NSUInteger)2, [accumulators count], @"expected only two tags to be mapped");
}


@end
