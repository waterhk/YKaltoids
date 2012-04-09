//
//  YADateFormatterTests.m
//  altoids
//
//  Created by Venkatraman Sridharan on 2/9/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import <SenTestingKit/SenTestingKit.h>
#import "DateCreator.h"
#import "YADateFormatter.h"

@interface YADateFormatterTests : SenTestCase
{
    NSString* errFormat;
}

@property (strong, nonatomic) YADateFormatter *dateFormatter;
@property (strong, nonatomic) id dateCreatorMock;

- (NSDate *)dateFromString:(NSString *)string;
- (NSDate*) setTimeOnDate:(NSDate*)date withHours:(NSInteger)theHours withMinutes:(NSInteger)theMinutes;

@end

@implementation YADateFormatterTests

@synthesize dateFormatter = dateFormatter_;
@synthesize dateCreatorMock = dateCreatorMock_;

- (void)setUp 
{
    [self setDateFormatter:[[YADateFormatter alloc] init]];
    [self setDateCreatorMock:[OCMockObject mockForProtocol:@protocol(DateCreator)]];
    [[self dateFormatter] setDateCreator:[self dateCreatorMock]];
    [[self dateFormatter] setShortStyleDateFormatter:[[NSDateFormatter alloc] init]];
    [[self dateFormatter] setShortTimeFormatter:[[NSDateFormatter alloc] init]];
    [[self dateFormatter] setShortDateFormatter:[[NSDateFormatter alloc] init]];
    [[self dateFormatter] setDayHourFormatter:[[NSDateFormatter alloc] init]];
    [[self dateFormatter] setMonthDayFormatter:[[NSDateFormatter alloc] init]];
    errFormat = @"Unexpected result: %@";
}

#pragma mark -
#pragma mark relative date format tests

-(void) testRelativeDateFormatterIfGivenInputDateIsNil 
{
    STAssertNil([[self dateFormatter] formatRelativeDateToString: nil], @"Expected nil");
}

-(void) testRelativeDateFormatterIfGivenInputDateIsFuture 
{
    NSDate *currentDate = [NSDate date];
    [[[[self dateCreatorMock] expect] andReturn:currentDate] dateForNow];
    
    NSDate* futureDate = [NSDate distantFuture];
    
    STAssertNil([[self dateFormatter] formatRelativeDateToString:futureDate], @"Expected nil");
}

- (void) testRelativeDateFormatterIfGivenInputDateIsPast
{
    NSDate *currentDate = [NSDate date];
    [[[[self dateCreatorMock] expect] andReturn:currentDate] dateForNow];
    
    NSDate* pastDate = [NSDate distantPast];
    
    STAssertNotNil([[self dateFormatter] formatRelativeDateToString:pastDate], @"Expected not nil");
}

- (void) testRelativeDateFormatterIfGivenInputDateIsCurrentDate
{
    NSDate *currentDate = [NSDate date];
    [[[[self dateCreatorMock] expect] andReturn:currentDate] dateForNow];
    
    STAssertNil([[self dateFormatter] formatRelativeDateToString: currentDate], @"Expected nil");
}

- (void) testRelativeDateFormatterIfGivenInputDateIsLessThanOneMinute
{    
    NSString* result;
    NSString* errMsg;
    NSDate* currentDate = [NSDate date];
    [[[[self dateCreatorMock] expect] andReturn:currentDate] dateForNow];
    
    NSDate *dateInSeconds = [currentDate dateByAddingTimeInterval: -10];
    
    result = [[self dateFormatter] formatRelativeDateToString:dateInSeconds];
    errMsg = [NSString stringWithFormat:errFormat, result];
    STAssertTrue([result isEqualToString:@"JUST NOW"], errMsg);
}

- (void) testRelativeDateFormatterIfGivenInputDateIsLessThanTwoMinutes
{    
    NSString* result;
    NSString* errMsg;
    NSDate* currentDate = [NSDate date];
    [[[[self dateCreatorMock] expect] andReturn:currentDate] dateForNow];
    
    NSDate *dateInSeconds = [currentDate dateByAddingTimeInterval: -70];
    
    result = [[self dateFormatter] formatRelativeDateToString:dateInSeconds];
    errMsg = [NSString stringWithFormat:errFormat, result];
    STAssertTrue([result isEqualToString:@"1 MIN"], errMsg);
}

- (void)testRelativeDateFormatterIfGivenInputIsLessThanThreeMinutes
{
    NSString* result;
    NSString* errMsg;
    NSDate* currentDate = [NSDate date];
    [[[[self dateCreatorMock] expect] andReturn:currentDate] dateForNow];
    
    NSDate* twoMinutes = [currentDate dateByAddingTimeInterval: -125];
    
    result = [[self dateFormatter] formatRelativeDateToString:twoMinutes];
    errMsg = [NSString stringWithFormat:errFormat, result];
    STAssertTrue([result isEqualToString:@"2 MINS"], errMsg);
}

- (void)testRelativeDateFormatterIfGivenInputIsLessThanOneHour
{
    NSString* result;
    NSString* errMsg;
    NSDate* currentDate = [NSDate date];
    [[[[self dateCreatorMock] expect] andReturn:currentDate] dateForNow];
    
    NSDate* lessThanOneHour = [currentDate dateByAddingTimeInterval: -(60 * 54)];
    
    result = [[self dateFormatter] formatRelativeDateToString:lessThanOneHour];
    errMsg = [NSString stringWithFormat:errFormat, result];
    STAssertTrue([result isEqualToString:@"54 MINS"], errMsg);
}

- (void)testRelativeDateFormatterIfGivenInputIsOneHour
{
    NSString* result;
    NSString* errMsg;
    NSDate* currentDate = [NSDate date];
    [[[[self dateCreatorMock] expect] andReturn:currentDate] dateForNow];
    
    NSDate* oneHour = [currentDate dateByAddingTimeInterval: -(60 * 60)];
    
    result = [[self dateFormatter] formatRelativeDateToString:oneHour];
    errMsg = [NSString stringWithFormat:errFormat, result];
    STAssertTrue([result isEqualToString:@"1 HOUR"], errMsg);
}

- (void)testRelativeDateFormatterIfGivenInputIsLessThanFourHours
{
    NSString* result;
    NSString* errMsg;
    NSDate* currentDate = [NSDate date];
    [[[[self dateCreatorMock] expect] andReturn:currentDate] dateForNow];
    
    NSDate* fourHours = [currentDate dateByAddingTimeInterval: -((60 * 60 * 4) + (60 * 30))];
    
    result = [[self dateFormatter] formatRelativeDateToString:fourHours];
    errMsg = [NSString stringWithFormat:errFormat, result];
    STAssertTrue([result isEqualToString:@"4 HOURS"], errMsg);
}

- (void) testRelativeDateFormatterIfGivenInputDateIsOverAYear
{
    NSDate* currentDate = [NSDate date];
    [[[[self dateCreatorMock] expect] andReturn:currentDate] dateForNow];
    
    NSString* result;
    NSString* errMsg;
    
    NSDate* overAYear = [currentDate dateByAddingTimeInterval: -(60 * 60 * 24 * 370)];
    
    result = [[self dateFormatter] formatRelativeDateToString:overAYear];
    errMsg = [NSString stringWithFormat:errFormat, result];
    STAssertTrue([result isEqualToString:@"1 YEAR"], errMsg);
}

- (void) testRelativeDateFormatterIfGivenInputDateIsMoreThanTwoYears 
{
    NSString* result;
    NSString* errMsg;
    NSDate* currentDate = [NSDate date];
    [[[[self dateCreatorMock] expect] andReturn:currentDate] dateForNow];
    
    NSDate* overAYear = [self dateFromString:@"2004-01-02 03:08 PM"];
    
    result = [[self dateFormatter] formatRelativeDateToString:overAYear];
    errMsg = [NSString stringWithFormat:errFormat, result];
    STAssertTrue([result isEqualToString:@"+1 YEAR"], errMsg);
}

#pragma mark -
#pragma mark absolute date format tests

-(void) testAbsoluteDateFormatterIfGivenInputDateIsNil 
{
    STAssertNil([[self dateFormatter] formatAbsoluteDateToString:nil] , @"Expected nil");
}

-(void) testAbsoluteDateFormatterIfGivenInputDateIsFuture 
{
    NSDate* currentDate = [NSDate date];
    [[[[self dateCreatorMock] expect] andReturn:currentDate] dateForNow];
    
    NSDate* futureDate = [NSDate distantFuture];
    
    STAssertNil([[self dateFormatter] formatAbsoluteDateToString:futureDate], @"Expected nil");
}

- (void) testAbsoluteDateFormatterIfGivenInputDateIsPast
{
    NSDate* currentDate = [NSDate date];
    [[[[self dateCreatorMock] expect] andReturn:currentDate] dateForNow];
    
    NSDate* pastDate = [NSDate distantPast];
    
    STAssertNotNil([[self dateFormatter] formatAbsoluteDateToString:pastDate], @"Expected not nil");
}

- (void) testAbsoluteDateFormatterIfGivenInputDateIsCurrentDate
{
    NSDate* currentDate = [NSDate date];
    [[[[self dateCreatorMock] expect] andReturn:currentDate] dateForNow];
    
    STAssertNil([[self dateFormatter] formatAbsoluteDateToString:currentDate], @"Expected nil");
}

- (void) testAbsoluteDateFormatterIfGivenInputDateIsToday
{
    NSString* result;
    NSString* errMsg;
    NSDate* anchorDate = [self dateFromString:@"2011-03-14 11:59 PM"];
    [[[[self dateCreatorMock] expect] andReturn:anchorDate] dateForNow];
    
    NSDate* today = [self setTimeOnDate:anchorDate withHours:3 withMinutes:5];
    
    result = [[self dateFormatter] formatAbsoluteDateToString:today];
    errMsg = [NSString stringWithFormat:errFormat, result];
    STAssertTrue([result isEqualToString:@"3:05 AM"], errMsg);
}

- (void) testAbsoluteDateFormatterIfGivenInputDateIsLessThanAWeek
{
    NSString* result;
    NSString* errMsg;
    NSDate* anchorDate = [self dateFromString:@"2012-03-14 4:52 PM"];
    [[[[self dateCreatorMock] expect] andReturn:anchorDate] dateForNow];
    
    NSDate* threeDays = [anchorDate dateByAddingTimeInterval: -(60 * 60 * 24 * 3)];
    
    result = [[self dateFormatter] formatAbsoluteDateToString:threeDays];
    errMsg = [NSString stringWithFormat:errFormat, result];
    STAssertTrue([result isEqualToString:@"Sun 4 PM"], errMsg);
}

- (void) testAbsoluteDateFormatterIfGivenInputDateIsMoreThanAWeek
{    
    NSString* result;
    NSString* errMsg;
    NSDate* anchorDate = [self dateFromString:@"2012-03-14 11:00 PM"];
    [[[[self dateCreatorMock] expect] andReturn:anchorDate] dateForNow];
    
    NSDate* nineDays = [anchorDate dateByAddingTimeInterval: -(60 * 60 * 24 * 9)];
    
    result = [[self dateFormatter] formatAbsoluteDateToString:nineDays];
    errMsg = [NSString stringWithFormat:errFormat, result];
    STAssertTrue([result isEqualToString:@"Mar 5"], errMsg);
}

- (void) testAbsoluteDateFormatterIfGivenInputDateIsMoreThanOneYear 
{
    NSString* result;
    NSString* errMsg;
    NSDate* anchorDate = [self dateFromString:@"2012-03-14 11:00 PM"];
    [[[[self dateCreatorMock] expect] andReturn:anchorDate] dateForNow];
    
    NSDate* overAYear = [self dateFromString:@"2011-01-02 03:08 PM"];
    
    result = [[self dateFormatter] formatAbsoluteDateToString:overAYear];
    errMsg = [NSString stringWithFormat:errFormat, result];
    STAssertTrue([result isEqualToString:@"1/2/11"], errMsg);
}

#pragma mark -
#pragma mark short style format tests

- (void)testShortStyleStringFromDateReturnsNilIfDateIsNil
{
    STAssertNil([dateFormatter_ shortStyleStringFromDate:nil], nil);
}

- (void)testShortStyleStringFromDateHandlesSingleDigitMonthDayHourAndMinuteProperly
{
    NSString *formattedDate = [dateFormatter_ shortStyleStringFromDate:[self dateFromString:@"2012-01-02 03:08 PM"]];
    NSString* errMsg = [NSString stringWithFormat:errFormat, formattedDate];
    
    STAssertTrue([formattedDate isEqualToString:@"1/2/12 3:08 PM"], errMsg);
}

- (void)testShortStyleStringFromDateHandlesDoubleDigitMonthDayHourAndMinuteProperly
{
    NSString *formattedDate = [dateFormatter_ shortStyleStringFromDate:[self dateFromString:@"2012-11-22 11:12 AM"]];
    NSString* errMsg = [NSString stringWithFormat:errFormat, formattedDate];
    
    STAssertTrue([formattedDate isEqualToString:@"11/22/12 11:12 AM"], errMsg);
}

#pragma mark -
#pragma mark private methods

- (NSDate *)dateFromString:(NSString *)string
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm a"];
    
    return [dateFormatter dateFromString:string];
}

- (NSDate*) setTimeOnDate:(NSDate*)date withHours:(NSInteger)theHours withMinutes:(NSInteger)theMinutes
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier: NSGregorianCalendar];
    NSDateComponents *components = [gregorian components: NSUIntegerMax fromDate: date];
    [components setHour:theHours];
    [components setMinute:theMinutes];
    
    return [gregorian dateFromComponents: components];
}

@end