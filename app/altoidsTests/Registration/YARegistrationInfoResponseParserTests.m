//
//  YARegistrationInfoResponseParserTests.m
//  altoids
//
//  Created by Jon Herron on 1/26/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import <SenTestingKit/SenTestingKit.h>
#import "YARegistrationInfoResponseParser.h"
#import "MutableDictionaryCreator.h"

#define kNumbersKey @"numbers"
#define kNumberKey @"number"
#define kMMCValue @"mmc"
#define kServicesKey @"services"
#define kSMSValue @"sms"
#define kTypeKey @"type"

@interface YARegistrationInfoResponseParserTests : SenTestCase

@property (strong, nonatomic) id mutableDictionaryCreatorMock;
@property (strong, nonatomic) YARegistrationInfoResponseParser *parser;

@end

@implementation YARegistrationInfoResponseParserTests

@synthesize mutableDictionaryCreatorMock = mutableDictionaryCreatorMock_;
@synthesize parser = parser_;

- (void)setUp
{
    [self setMutableDictionaryCreatorMock:[OCMockObject mockForProtocol:@protocol(MutableDictionaryCreator)]];
    
    [self setParser:[[YARegistrationInfoResponseParser alloc] init]];
    [[self parser] setMutableDictionaryCreator:[self mutableDictionaryCreatorMock]];
}

- (void)testNumbersInResponseReturnsValueForKeyNumbers
{
    NSArray *numbers = [NSArray array];
    NSDictionary *response = [NSDictionary dictionaryWithObject:numbers forKey:kNumbersKey];
    
    STAssertEqualObjects(numbers, [[self parser] numbersInResponse:response], @"Expected array returned from numbers key");
}

- (void)testHandleForNumberReturnsValueForKeyNumber
{
    NSString *handle = @"123";
    NSDictionary *numberResponse = [NSDictionary dictionaryWithObject:handle forKey:kNumberKey];
    
    STAssertTrue([handle isEqualToString:[[self parser] handleForNumber:numberResponse]], @"Expected handle returned from number key");
}

- (void)testServicesForNumberReturnsDictionaryOfEachServiceForGivenNumber
{
    NSDictionary *mmcService = [NSDictionary dictionaryWithObject:kMMCValue forKey:kTypeKey];
    NSDictionary *smsService = [NSDictionary dictionaryWithObject:kSMSValue forKey:kTypeKey];
    NSDictionary *numberResponse = [NSDictionary dictionaryWithObject:[NSArray arrayWithObjects:mmcService, smsService, nil] forKey:kServicesKey];
    
    NSMutableDictionary *parsedServices = [NSMutableDictionary dictionary];
    
    [[[[self mutableDictionaryCreatorMock] expect] andReturn:parsedServices] mutableDictionaryWithCapacity:2];
    
    NSDictionary *services = [[self parser] servicesForNumber:numberResponse];
    
    STAssertNotNil([services objectForKey:kMMCValue], @"Expected mmc service");
    STAssertNotNil([services objectForKey:kSMSValue], @"Expected sms service");
    STAssertNil([services objectForKey:@"fakeService"], @"Unexpected fake service");
}

- (void)testHasHubServiceReturnsTrueIfGivenServicesDictionaryHasMMCKey
{
    NSDictionary *services = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:kMMCValue];
    
    STAssertTrue([[self parser] hasHubService:services], @"Expected hub service");
}

- (void)testHasHubServiceReturnsFalseIfGivenServicesDictionaryDoesNotHaveMMCKey
{
    NSDictionary *services = [NSDictionary dictionary];
    
    STAssertFalse([[self parser] hasHubService:services], @"Expected hub service");
}

- (void)testHasSMSServiceReturnsTrueIfGivenServicesDictionaryHasSMSKey
{
    NSDictionary *services = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:kSMSValue];
    
    STAssertTrue([[self parser] hasSMSService:services], @"Expected sms service");
}

- (void)testHasSMSServiceReturnsFalseIfGivenServicesDictionaryDoesNotHaveSMSKey
{
    NSDictionary *services = [NSDictionary dictionary];
    
    STAssertFalse([[self parser] hasSMSService:services], @"Expected sms service");
}

@end
