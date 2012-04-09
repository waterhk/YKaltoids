//
//  YARegistrationInfoAddressMetaDataUpdaterTests.m
//  altoids
//
//  Created by Jon Herron on 1/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import <SenTestingKit/SenTestingKit.h>
#import "AddressMetaDataHandler.h"
#import "AddressMetaDataRepository.h"
#import "RegistrationInfoResponseParser.h"
#import "YARegistrationInfoAddressMetaDataUpdater.h"

@interface YARegistrationInfoAddressMetaDataUpdaterTests : SenTestCase

@property (strong, nonatomic) id addressMetaDataHandlerMock;
@property (strong, nonatomic) id addressMetaDataRepositoryMock;
@property (strong, nonatomic) id managedObjectContextMock;
@property (strong, nonatomic) id registrationInfoResponseParserMock;
@property (strong, nonatomic) YARegistrationInfoAddressMetaDataUpdater *addressMetaDataUpdater;

@end

@implementation YARegistrationInfoAddressMetaDataUpdaterTests

@synthesize addressMetaDataHandlerMock = addressMetaDataHandlerMock_;
@synthesize addressMetaDataRepositoryMock = addressMetaDataRepositoryMock_;
@synthesize managedObjectContextMock = managedObjectContextMock_;
@synthesize registrationInfoResponseParserMock = registrationInfoResponseParserMock_;
@synthesize addressMetaDataUpdater = addressMetaDataUpdater_;

- (void)setUp
{
    [self setAddressMetaDataHandlerMock:[OCMockObject mockForProtocol:@protocol(AddressMetaDataHandler)]];
    [self setAddressMetaDataRepositoryMock:[OCMockObject mockForProtocol:@protocol(AddressMetaDataRepository)]];
    [self setManagedObjectContextMock:[OCMockObject mockForClass:[NSManagedObjectContext class]]];
    [self setRegistrationInfoResponseParserMock:[OCMockObject mockForProtocol:@protocol(RegistrationInfoResponseParser)]];
    
    [self setAddressMetaDataUpdater:[[YARegistrationInfoAddressMetaDataUpdater alloc] init]];
    [[self addressMetaDataUpdater] setAddressMetaDataHandler:[self addressMetaDataHandlerMock]];
    [[self addressMetaDataUpdater] setAddressMetaDataRepository:[self addressMetaDataRepositoryMock]];
    [[self addressMetaDataUpdater] setRegistrationInfoResponseParser:[self registrationInfoResponseParserMock]];
}

- (void)testUpdateAddressMetaDataFromNumberRegistrationInfo
{
    id addressMetaDataMock = [OCMockObject mockForClass:[YAAddressMetaData class]];
    NSDictionary *regInfo = [NSDictionary dictionary];
    NSDictionary *services = [NSDictionary dictionary];
    NSString *handle = @"123";
    
    [[[[self registrationInfoResponseParserMock] expect] andReturn:handle] handleForNumber:regInfo];
    
    [[[[self addressMetaDataRepositoryMock] expect] andReturn:addressMetaDataMock] addressMetaDataForHandle:handle inManagedObjectContext:[self managedObjectContextMock]];
    [[[[self registrationInfoResponseParserMock] expect] andReturn:services] servicesForNumber:regInfo];
    
    BOOL isHub = YES;
    BOOL isValidSMS = NO;
    
    [[[[self registrationInfoResponseParserMock] expect] andReturnValue:OCMOCK_VALUE(isHub)] hasHubService:services];
    [[[[self registrationInfoResponseParserMock] expect] andReturnValue:OCMOCK_VALUE(isValidSMS)] hasSMSService:services];
    
    [[[self addressMetaDataHandlerMock] expect] setHandleIsHub:isHub forAddressMetaData:addressMetaDataMock];
    [[[self addressMetaDataHandlerMock] expect] setHandleIsValidSMS:isValidSMS forAddressMetaData:addressMetaDataMock];
    
    STAssertEqualObjects(addressMetaDataMock, [[self addressMetaDataUpdater] updateAddressMetaDataFromNumberRegistrationInfo:regInfo inManagedObjectContext:[self managedObjectContextMock]], @"Expected address meta data mock");
    
    [[self addressMetaDataHandlerMock] verify];
    [[self addressMetaDataRepositoryMock] verify];
    [[self registrationInfoResponseParserMock] verify];
    [addressMetaDataMock verify];
}

- (void)testIfRegistrationInfoContainsEmptyHandleUpdateWillReturnNil
{
    [[[[self registrationInfoResponseParserMock] stub] andReturn:nil] handleForNumber:OCMOCK_ANY];
    
    STAssertNil([[self addressMetaDataUpdater] updateAddressMetaDataFromNumberRegistrationInfo:nil inManagedObjectContext:[self managedObjectContextMock]], @"Expected nil to be returned");
    
    [[[[self registrationInfoResponseParserMock] stub] andReturn:@""] handleForNumber:OCMOCK_ANY];
    
    STAssertNil([[self addressMetaDataUpdater] updateAddressMetaDataFromNumberRegistrationInfo:nil inManagedObjectContext:[self managedObjectContextMock]], @"Expected nil to be returned");
    
    [[self addressMetaDataHandlerMock] verify];
    [[self addressMetaDataRepositoryMock] verify];
    [[self registrationInfoResponseParserMock] verify];
}

- (void)testIfAddressMetaDataRepositoryReturnsNilMetaDataUpdateWillReturnNil
{
    [[[[self registrationInfoResponseParserMock] stub] andReturn:@"123"] handleForNumber:OCMOCK_ANY];
    [[[[self addressMetaDataRepositoryMock] stub] andReturn:nil] addressMetaDataForHandle:OCMOCK_ANY inManagedObjectContext:OCMOCK_ANY];
    
    STAssertNil([[self addressMetaDataUpdater] updateAddressMetaDataFromNumberRegistrationInfo:nil inManagedObjectContext:[self managedObjectContextMock]], @"Expected nil to be returned");
    
    [[self addressMetaDataHandlerMock] verify];
    [[self addressMetaDataRepositoryMock] verify];
    [[self registrationInfoResponseParserMock] verify];
}

- (void)testIfNoServicesAreAvailableForNumberUpdateWillReturnNil
{
    [[[[self registrationInfoResponseParserMock] stub] andReturn:@"123"] handleForNumber:OCMOCK_ANY];
    [[[[self addressMetaDataRepositoryMock] stub] andReturn:[OCMockObject mockForClass:[YAAddressMetaData class]]] addressMetaDataForHandle:OCMOCK_ANY inManagedObjectContext:OCMOCK_ANY];
    [[[[self registrationInfoResponseParserMock] stub] andReturn:nil] servicesForNumber:OCMOCK_ANY];
    
    STAssertNil([[self addressMetaDataUpdater] updateAddressMetaDataFromNumberRegistrationInfo:nil inManagedObjectContext:[self managedObjectContextMock]], @"Expected nil to be returned");
    
    [[self addressMetaDataHandlerMock] verify];
    [[self addressMetaDataRepositoryMock] verify];
    [[self registrationInfoResponseParserMock] verify];
}

@end
