//
//  YARegistrationInfoRequestDataBuilderTests.m
//  altoids
//
//  Created by Venkatraman Sridharan on 1/24/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import <SenTestingKit/SenTestingKit.h>
#import "MutableArrayCreator.h"
#import "MutableDictionaryCreator.h"
#import "YASMSAddressInfo.h"
#import "YARegistrationInfoRequestDataBuilder.h"

@interface YARegistrationInfoRequestDataBuilderTests : SenTestCase

@property (strong, nonatomic) id mutableArrayCreatorMock;
@property (strong, nonatomic) id mutableDictionaryCreatorMock;
@property (strong, nonatomic) id mutableDictionaryMock;
@property (strong, nonatomic) YARegistrationInfoRequestDataBuilder *registrationInfoRequestDataBuilder;

@end

@implementation YARegistrationInfoRequestDataBuilderTests

@synthesize mutableArrayCreatorMock = mutableArrayCreatorMock_;
@synthesize mutableDictionaryMock = mutableDictionaryMock_;
@synthesize mutableDictionaryCreatorMock = mutableDictionaryCreatorMock_;
@synthesize registrationInfoRequestDataBuilder = registrationInfoRequestDataBuilder_;

- (void) setUp 
{
    [self setMutableArrayCreatorMock:[OCMockObject mockForProtocol:@protocol(MutableArrayCreator)]];
    [self setMutableDictionaryMock:[OCMockObject mockForClass:[NSMutableDictionary class]]];
    [self setMutableDictionaryCreatorMock:[OCMockObject mockForProtocol:@protocol(MutableDictionaryCreator)]];
    
    [self setRegistrationInfoRequestDataBuilder:[[YARegistrationInfoRequestDataBuilder alloc] init]];
    
    [[self registrationInfoRequestDataBuilder] setMutableArrayCreator:[self mutableArrayCreatorMock]];
    [[self registrationInfoRequestDataBuilder] setMutableDictionaryCreator:[self mutableDictionaryCreatorMock]];
}

- (void) verifyMocks 
{
    [[self mutableDictionaryMock] verify];
    [[self mutableDictionaryCreatorMock] verify];
}

- (void)testCanBuildRequestDataWithAddressHandle 
{
    id addressHandleDictionary = [OCMockObject mockForClass:[NSMutableDictionary class]];
    id numbersArray = [OCMockObject mockForClass:[NSMutableArray class]];
    NSString *addressHandle = @"14086774567";
    YAAddressInfo *address = [[YASMSAddressInfo alloc] initWithYE164PhoneNumber:addressHandle];

    [[[[self mutableDictionaryCreatorMock] expect] andReturn:addressHandleDictionary] mutableDictionaryWithCapacity:1];
    [[addressHandleDictionary expect] setObject:addressHandle forKey:@"number"];
    
    [[[[self mutableArrayCreatorMock] expect] andReturn:numbersArray] mutableArrayWithCapacity:1];
    [[numbersArray expect] addObject:addressHandleDictionary];

    [[[[self mutableDictionaryCreatorMock] expect] andReturn:[self mutableDictionaryMock]] mutableDictionaryWithCapacity:1];
    [[[self mutableDictionaryMock] expect] setObject:numbersArray forKey:@"numbers"];
    
    STAssertNotNil([[self registrationInfoRequestDataBuilder] requestDataForAddress:address], @"Unexpected nil return");
    
    [self verifyMocks];
}

- (void)testReturnsNilRequestDataWhenProvidedAddressIsNilOrHasNilOrEmptyHandle
{    
    STAssertNil([[self registrationInfoRequestDataBuilder] requestDataForAddress:nil], @"Expected nil");
    STAssertNil([[self registrationInfoRequestDataBuilder] requestDataForAddress:[[YASMSAddressInfo alloc] initWithYE164PhoneNumber:nil]], @"Expected nil");
    STAssertNil([[self registrationInfoRequestDataBuilder] requestDataForAddress:[[YASMSAddressInfo alloc] initWithYE164PhoneNumber:@""]], @"Expected nil");
    
    [self verifyMocks];
}


@end
