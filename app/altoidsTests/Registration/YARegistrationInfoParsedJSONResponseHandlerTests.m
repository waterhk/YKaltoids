//
//  YARegistrationInfoParsedJSONResponseHandlerTests.m
//  altoids
//
//  Created by Jon Herron on 1/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import <SenTestingKit/SenTestingKit.h>
#import "AddressMetaDataHandler.h"
#import "AddressMetaDataRepository.h"
#import "ManagedObjectContextFactory.h"
#import "MutableArrayCreator.h"
#import "MutableDictionaryCreator.h"
#import "RegistrationInfoAddressMetaDataUpdater.h"
#import "RegistrationInfoCommandDelegate.h"
#import "RegistrationInfoResponseParser.h"
#import "YARegistrationInfoParsedJSONResponseHandler.h"

@interface YARegistrationInfoParsedJSONResponseHandlerTests : SenTestCase 

@property (strong, nonatomic) id addressMetaDataHandler;
@property (strong, nonatomic) id addressMetaDataRepositoryMock;
@property (strong, nonatomic) id managedObjectContextFactoryMock;
@property (strong, nonatomic) id managedObjectContextMock;
@property (strong, nonatomic) id mutableArrayCreatorMock;
@property (strong, nonatomic) id mutableDictionaryCreatorMock;
@property (strong, nonatomic) id registrationInfoAddressMetaDataUpdaterMock;
@property (strong, nonatomic) id registrationInfoCommandDelegateMock;
@property (strong, nonatomic) id registrationInfoResponseParserMock;
@property (strong, nonatomic) YARegistrationInfoParsedJSONResponseHandler *parsedJSONResponseHandler;

- (void)verifyMocks;

@end

@implementation YARegistrationInfoParsedJSONResponseHandlerTests

@synthesize addressMetaDataHandler = addressMetaDataHandler_;
@synthesize addressMetaDataRepositoryMock = addressMetaDataRepositoryMock_;
@synthesize managedObjectContextFactoryMock = managedObjectContextFactoryMock_;
@synthesize managedObjectContextMock = managedObjectContextMock_;
@synthesize mutableArrayCreatorMock = mutableArrayCreatorMock_;
@synthesize mutableDictionaryCreatorMock = mutableDictionaryCreatorMock_;
@synthesize registrationInfoAddressMetaDataUpdaterMock = registrationInfoAddressMetaDataUpdaterMock_;
@synthesize registrationInfoCommandDelegateMock = registrationInfoParsedJSONResponseHandlerDelegateMock_;
@synthesize registrationInfoResponseParserMock = registrationInfoResponseParserMock_;
@synthesize parsedJSONResponseHandler = parsedJSONResponseHandler_;

- (void)setUp
{
    [self setAddressMetaDataHandler:[OCMockObject mockForProtocol:@protocol(AddressMetaDataHandler)]];
    [self setAddressMetaDataRepositoryMock:[OCMockObject mockForProtocol:@protocol(AddressMetaDataRepository)]];
    [self setManagedObjectContextFactoryMock:[OCMockObject mockForProtocol:@protocol(ManagedObjectContextFactory)]];
    [self setManagedObjectContextMock:[OCMockObject mockForClass:[NSManagedObjectContext class]]];
    [self setMutableArrayCreatorMock:[OCMockObject mockForProtocol:@protocol(MutableArrayCreator)]];
    [self setMutableDictionaryCreatorMock:[OCMockObject mockForProtocol:@protocol(MutableDictionaryCreator)]];
    [self setRegistrationInfoAddressMetaDataUpdaterMock:[OCMockObject mockForProtocol:@protocol(RegistrationInfoAddressMetaDataUpdater)]];
    [self setRegistrationInfoCommandDelegateMock:[OCMockObject mockForProtocol:@protocol(RegistrationInfoCommandDelegate)]];
    [self setRegistrationInfoResponseParserMock:[OCMockObject mockForProtocol:@protocol(RegistrationInfoResponseParser)]];
    
    [self setParsedJSONResponseHandler:[[YARegistrationInfoParsedJSONResponseHandler alloc] initWithDelegate:[self registrationInfoCommandDelegateMock]]];
    
    [[self parsedJSONResponseHandler] setAddressMetaDataHandler:[self addressMetaDataHandler]];
    [[self parsedJSONResponseHandler] setAddressMetaDataRepository:[self addressMetaDataRepositoryMock]];
    [[self parsedJSONResponseHandler] setManagedObjectContextFactory:[self managedObjectContextFactoryMock]];
    [[self parsedJSONResponseHandler] setMutableArrayCreator:[self mutableArrayCreatorMock]];
    [[self parsedJSONResponseHandler] setMutableDictionaryCreator:[self mutableDictionaryCreatorMock]];
    [[self parsedJSONResponseHandler] setRegistrationInfoAddressMetaDataUpdater:[self registrationInfoAddressMetaDataUpdaterMock]];
    [[self parsedJSONResponseHandler] setRegistrationInfoResponseParser:[self registrationInfoResponseParserMock]];
}

- (void)testSavesServicesForEachNumberInParsedJSONResponse
{
    NSDictionary *parsedJSONResponse = [NSDictionary dictionary];
    
    NSDictionary *numberInfo1 = [NSDictionary dictionary];
    NSDictionary *numberInfo2 = [NSDictionary dictionary];
    NSDictionary *numberInfo3 = [NSDictionary dictionary];
    NSArray *numbers = [NSArray arrayWithObjects:numberInfo1, numberInfo2, numberInfo3, nil];
    
    [[[[self registrationInfoResponseParserMock] expect] andReturn:numbers] numbersInResponse:parsedJSONResponse];
    
    [[[[self managedObjectContextFactoryMock] expect] andReturn:[self managedObjectContextMock]] create];
    
    id updatedAddressMetaDatasMock = [OCMockObject mockForClass:[NSMutableArray class]];
    [[[[self mutableArrayCreatorMock] expect] andReturn:updatedAddressMetaDatasMock] mutableArrayWithCapacity:3];
    
    id handleToObjectIDMap = [OCMockObject mockForClass:[NSMutableDictionary class]];
    [[[[self mutableDictionaryCreatorMock] expect] andReturn:handleToObjectIDMap] mutableDictionaryWithCapacity:3];
    
    id addressMetaDataMock1 = [OCMockObject mockForClass:[YAAddressMetaData class]];
    id addressMetaDataMock2 = [OCMockObject mockForClass:[YAAddressMetaData class]];
    id addressMetaDataMock3 = [OCMockObject mockForClass:[YAAddressMetaData class]];
    
    NSString *handle1 = @"handle1";
    NSString *handle2 = @"handle2";
    NSString *handle3 = @"handle3";
    
    id objectID1 = [OCMockObject mockForClass:[NSManagedObjectID class]];
    id objectID2 = [OCMockObject mockForClass:[NSManagedObjectID class]];
    id objectID3 = [OCMockObject mockForClass:[NSManagedObjectID class]];
    
    [[[[self addressMetaDataHandler] expect] andReturn:handle1] handleForAddressMetaData:addressMetaDataMock1];
    [[[[self addressMetaDataHandler] expect] andReturn:handle2] handleForAddressMetaData:addressMetaDataMock2];
    [[[[self addressMetaDataHandler] expect] andReturn:handle3] handleForAddressMetaData:addressMetaDataMock3];
    
    [[[[self addressMetaDataHandler] expect] andReturn:objectID1] managedObjectIDForAddressMetaData:addressMetaDataMock1];
    [[[[self addressMetaDataHandler] expect] andReturn:objectID2] managedObjectIDForAddressMetaData:addressMetaDataMock2];
    [[[[self addressMetaDataHandler] expect] andReturn:objectID3] managedObjectIDForAddressMetaData:addressMetaDataMock3];
    
    [[[[self registrationInfoAddressMetaDataUpdaterMock] expect] andReturn:addressMetaDataMock1] updateAddressMetaDataFromNumberRegistrationInfo:numberInfo1 inManagedObjectContext:[self managedObjectContextMock]];
    [[[[self registrationInfoAddressMetaDataUpdaterMock] expect] andReturn:addressMetaDataMock2] updateAddressMetaDataFromNumberRegistrationInfo:numberInfo2 inManagedObjectContext:[self managedObjectContextMock]];
    [[[[self registrationInfoAddressMetaDataUpdaterMock] expect] andReturn:addressMetaDataMock3] updateAddressMetaDataFromNumberRegistrationInfo:numberInfo3 inManagedObjectContext:[self managedObjectContextMock]];
    
    [[handleToObjectIDMap expect] setObject:objectID1 forKey:handle1];
    [[handleToObjectIDMap expect] setObject:objectID2 forKey:handle2];
    [[handleToObjectIDMap expect] setObject:objectID3 forKey:handle3];
    
    [[updatedAddressMetaDatasMock expect] addObject:addressMetaDataMock1];
    [[updatedAddressMetaDatasMock expect] addObject:addressMetaDataMock2];
    [[updatedAddressMetaDatasMock expect] addObject:addressMetaDataMock3];
    
    NSUInteger updateAddressMetaDatasCount = 3;
    [[[updatedAddressMetaDatasMock expect] andReturnValue:OCMOCK_VALUE(updateAddressMetaDatasCount)] count];
    
    BOOL didSave = YES;
    [[[[self addressMetaDataRepositoryMock] expect] andReturnValue:OCMOCK_VALUE(didSave)] saveAddressMetaDatas:updatedAddressMetaDatasMock inManagedObjectContext:[self managedObjectContextMock] error:[OCMArg setTo:nil]];
    
    [[[self registrationInfoCommandDelegateMock] expect] registrationInfoDidSaveWithHandleToObjectIDMap:handleToObjectIDMap];
    
    [[self parsedJSONResponseHandler] handleParsedJSONResponse:parsedJSONResponse];
    
    [self verifyMocks];
}

- (void)testIfParsedJSONResponseContainsNoRegistrationInfoResponseHandlerExistsEarly
{
    [[[self registrationInfoResponseParserMock] stub] numbersInResponse:OCMOCK_ANY];
    
    [[self parsedJSONResponseHandler] handleParsedJSONResponse:nil];
    
    [self verifyMocks];
}

- (void)testIfUpdatedAddressMetaDataWillNotBeAddedToArrayIfItIsNil
{
    NSDictionary *numberInfo1 = [NSDictionary dictionary];
    NSDictionary *numberInfo2 = [NSDictionary dictionary];
    NSDictionary *numberInfo3 = [NSDictionary dictionary];
    NSArray *numbers = [NSArray arrayWithObjects:numberInfo1, numberInfo2, numberInfo3, nil];
    
    [[[[self registrationInfoResponseParserMock] stub] andReturn:numbers] numbersInResponse:OCMOCK_ANY];
    [[[[self managedObjectContextFactoryMock] stub] andReturn:[self managedObjectContextMock]] create];
    
    NSMutableArray *updatedAddressMetaDatas = [NSMutableArray array];
    [[[[self mutableArrayCreatorMock] stub] andReturn:updatedAddressMetaDatas] mutableArrayWithCapacity:3];
    
    NSMutableDictionary *handleToObjectIDMap = [NSMutableDictionary dictionary];
    [[[[self mutableDictionaryCreatorMock] stub] andReturn:handleToObjectIDMap] mutableDictionaryWithCapacity:3];
    
    [[[[self registrationInfoAddressMetaDataUpdaterMock] expect] andReturn:nil] updateAddressMetaDataFromNumberRegistrationInfo:OCMOCK_ANY inManagedObjectContext:OCMOCK_ANY];
    [[[[self registrationInfoAddressMetaDataUpdaterMock] expect] andReturn:nil] updateAddressMetaDataFromNumberRegistrationInfo:OCMOCK_ANY inManagedObjectContext:OCMOCK_ANY];
    [[[[self registrationInfoAddressMetaDataUpdaterMock] expect] andReturn:nil] updateAddressMetaDataFromNumberRegistrationInfo:OCMOCK_ANY inManagedObjectContext:OCMOCK_ANY];
    
    [[[self registrationInfoCommandDelegateMock] stub] registrationInfoDidSaveWithHandleToObjectIDMap:OCMOCK_ANY];
    
    [[self parsedJSONResponseHandler] handleParsedJSONResponse:nil];
    
    STAssertTrue([updatedAddressMetaDatas count] == 0, @"Did not expect any updated address meta data objects in array");
    
    [self verifyMocks];
}

- (void)verifyMocks
{
    [[self addressMetaDataRepositoryMock] verify];
    [[self managedObjectContextFactoryMock] verify];
    [[self managedObjectContextMock] verify];
    [[self mutableArrayCreatorMock] verify];
    [[self mutableDictionaryCreatorMock] verify];
    [[self registrationInfoAddressMetaDataUpdaterMock] verify];
    [[self registrationInfoCommandDelegateMock] verify];
    [[self registrationInfoResponseParserMock] verify];
}

@end
