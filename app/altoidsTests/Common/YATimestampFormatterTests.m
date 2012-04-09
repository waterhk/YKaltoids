//
//  YATimestampFormatterTests.m
//  altoids
//
//  Created by Devin Doman on 3/15/12.
//  Copyright 2012 Yahoo!. All rights reserved.
//

#import "YATestCase.h"
#import <objc/runtime.h>
#import "YATimestampFormatter.h"
#import "DateFormatter.h"
#import "DateCreator.h"


@interface YATimestampFormatterTests : YATestCase
{
    YATimestampFormatter* timestampFormatter;
    id dateFormatterMock;
    id dateCreatorMock;
}
@end

@implementation YATimestampFormatterTests

- (void) setUp
{
    dateFormatterMock = [OCMockObject mockForProtocol:@protocol(DateFormatter)];
    dateCreatorMock = [OCMockObject mockForProtocol:@protocol(DateCreator)];
    
    timestampFormatter = [[YATimestampFormatter alloc] init];
    [timestampFormatter setDateFormatter:dateFormatterMock];
    [timestampFormatter setDateCreator:dateCreatorMock];
}

#pragma mark -
#pragma mark timestamp formatter tests

- (void) testTimestampFormatterIfGivenInputDateIsLessThanFiveHours
{
    NSDate* currentDate = [NSDate date];
    [[[dateCreatorMock expect] andReturn:currentDate] dateForNow];
    
    NSDate* lessThanFive = [currentDate dateByAddingTimeInterval: -120];
    NSString* format = @"Relative timestamp";
    [[[dateFormatterMock expect] andReturn:format] formatRelativeDateToString:lessThanFive];
    
    //Test that a relative date is chosen
    NSString* result = [timestampFormatter formatTimestampToString:lessThanFive];
    STAssertTrue([result isEqualToString:format], nil);
}

- (void) testTimestampFormatterIfGivenInputDateIsMoreThanFiveHours
{
    NSDate* currentDate = [NSDate date];
    [[[dateCreatorMock expect] andReturn:currentDate] dateForNow];
    
    NSDate* moreThanFive = [currentDate dateByAddingTimeInterval: -(60 * 60 * 7)];
    NSString* format = @"Absolute timestamp";
    [[[dateFormatterMock expect] andReturn:format] formatAbsoluteDateToString:moreThanFive];
    
    //Test that an absolute date is chosen
    NSString* result = [timestampFormatter formatTimestampToString:moreThanFive];
    STAssertTrue([result isEqualToString:format], nil);
}

- (void) testTimestampFormatterIfGivenInputDateIsMoreThanOneYear
{
    NSDate* currentDate = [NSDate date];
    [[[dateCreatorMock expect] andReturn:currentDate] dateForNow];
    
    NSDate* overAYear = [currentDate dateByAddingTimeInterval: -(60 * 60 * 24 * 365 * 1.5)];
    NSString* format = @"Absolute timestamp for over a year";
    [[[dateFormatterMock expect] andReturn:format] formatAbsoluteDateToString:overAYear];
    
    //Test that an absolute date is chosen
    NSString* result = [timestampFormatter formatTimestampToString:overAYear];
    STAssertTrue([result isEqualToString:format], nil);
}

@end