//
//  YAAddressMetaDataRepositoryTests.m
//  altoids
//
//  Created by Jon Herron on 1/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import <SenTestingKit/SenTestingKit.h>
#import "AddressMetaDataEntityDescriptionCreator.h"
#import "AddressMetaDataFetchRequestRepository.h"
#import "AddressMetaDataHandler.h"
#import "YAAddressMetaDataRepository.h"

@interface YAAddressMetaDataRepositoryTests : SenTestCase

@property (strong, nonatomic) id addressMetaDataEntityDescriptionCreatorMock;
@property (strong, nonatomic) id addressMetaDataFetchRequestRepositoryMock;
@property (strong, nonatomic) id addressMetaDataHandlerMock;
@property (strong, nonatomic) id addressMetaDataMock;
@property (strong, nonatomic) id fetchRequestMock;
@property (strong, nonatomic) id managedObjectContextMock;
@property (strong, nonatomic) YAAddressMetaDataRepository *repository;

@end

@implementation YAAddressMetaDataRepositoryTests

@synthesize addressMetaDataEntityDescriptionCreatorMock = addressMetaDataEntityDescriptionCreatorMock_;
@synthesize addressMetaDataFetchRequestRepositoryMock = addressMetaDataFetchRequestRepositoryMock_;
@synthesize addressMetaDataHandlerMock = addressMetaDataHandlerMock_;
@synthesize addressMetaDataMock = addressMetaDataMock_;
@synthesize fetchRequestMock = fetchRequestMock_;
@synthesize managedObjectContextMock = managedObjectContextMock_;
@synthesize repository = repository_;

- (void)setUp
{
    [self setAddressMetaDataEntityDescriptionCreatorMock:[OCMockObject mockForProtocol:@protocol(AddressMetaDataEntityDescriptionCreator)]];
    [self setAddressMetaDataFetchRequestRepositoryMock:[OCMockObject mockForProtocol:@protocol(AddressMetaDataFetchRequestRepository)]];
    [self setAddressMetaDataHandlerMock:[OCMockObject mockForProtocol:@protocol(AddressMetaDataHandler)]];
    [self setAddressMetaDataMock:[OCMockObject mockForClass:[YAAddressMetaData class]]];
    [self setManagedObjectContextMock:[OCMockObject mockForClass:[NSManagedObjectContext class]]];
    [self setFetchRequestMock:[OCMockObject mockForClass:[NSFetchRequest class]]];
    
    [self setRepository:[[YAAddressMetaDataRepository alloc] init]];
    [[self repository] setAddressMetaDataHandler:[self addressMetaDataHandlerMock]];
    [[self repository] setEntityDescriptionCreator:[self addressMetaDataEntityDescriptionCreatorMock]];
    [[self repository] setFetchRequestRepository:[self addressMetaDataFetchRequestRepositoryMock]];
}

- (void)testWillReturnExistingAddressMetaDataForHandleIfItExists
{
    NSString *handle = @"123";
    
    [[[[self addressMetaDataFetchRequestRepositoryMock] stub] andReturn:[self fetchRequestMock]] fetchRequestForAddressMetaDataWithHandle:handle inManagedObjectContext:[self managedObjectContextMock]];
    
    [[[[self managedObjectContextMock] stub] andReturn:[NSArray arrayWithObject:[self addressMetaDataMock]]] executeFetchRequest:[self fetchRequestMock] error:[OCMArg setTo:nil]];
    
    STAssertEqualObjects([self addressMetaDataMock], [[self repository] addressMetaDataForHandle:handle inManagedObjectContext:[self managedObjectContextMock]], @"Expected existing meta data to be returned");
}

- (void)testWillCreateAddressMetaDataForHandleIfNoMetaDataExists
{
    NSString *handle = @"321";
    
    [[[[self addressMetaDataFetchRequestRepositoryMock] stub] andReturn:[self fetchRequestMock]] fetchRequestForAddressMetaDataWithHandle:handle inManagedObjectContext:[self managedObjectContextMock]];
    
    [[[[self managedObjectContextMock] stub] andReturn:[NSArray array]] executeFetchRequest:[self fetchRequestMock] error:[OCMArg setTo:nil]];
    
    [[[[self addressMetaDataEntityDescriptionCreatorMock] stub] andReturn:[self addressMetaDataMock]] createAddressMetaDataEntityInManagedObjectContext:[self managedObjectContextMock]];
    
    [[[self addressMetaDataHandlerMock] expect] setHandle:handle forAddressMetaData:[self addressMetaDataMock]];
    
    STAssertEqualObjects([self addressMetaDataMock], [[self repository] addressMetaDataForHandle:handle inManagedObjectContext:[self managedObjectContextMock]], @"Expected new meta data to be returned");
}

- (void)testWillReturnNilIfUnableToFetchAddressMetaDataForHandle
{
    [[[[self addressMetaDataFetchRequestRepositoryMock] stub] andReturn:[self fetchRequestMock]] fetchRequestForAddressMetaDataWithHandle:OCMOCK_ANY inManagedObjectContext:[self managedObjectContextMock]];
    
    [[[[self managedObjectContextMock] stub] andReturn:nil] executeFetchRequest:[self fetchRequestMock] error:[OCMArg setTo:nil]];
    
    STAssertNil([[self repository] addressMetaDataForHandle:nil inManagedObjectContext:[self managedObjectContextMock]], @"Expected nil return");
}


- (void)testWillReturnNilIfUnableToCreateAddressMetaDataForHandle
{
    [[[[self addressMetaDataFetchRequestRepositoryMock] stub] andReturn:[self fetchRequestMock]] fetchRequestForAddressMetaDataWithHandle:OCMOCK_ANY inManagedObjectContext:[self managedObjectContextMock]];
    
    [[[[self managedObjectContextMock] stub] andReturn:[NSArray array]] executeFetchRequest:[self fetchRequestMock] error:[OCMArg setTo:nil]];
    
    [[[[self addressMetaDataEntityDescriptionCreatorMock] stub] andReturn:nil] createAddressMetaDataEntityInManagedObjectContext:[self managedObjectContextMock]];
    
    STAssertNil([[self repository] addressMetaDataForHandle:@"132" inManagedObjectContext:[self managedObjectContextMock]], @"Expected nil return");
}


- (void)testIfHandleIsNilOrEmptyAddressMetaDataForAddressReturnsNil
{
    STAssertNil([[self repository] addressMetaDataForHandle:nil inManagedObjectContext:[self managedObjectContextMock]], @"Expected nil return");
    STAssertNil([[self repository] addressMetaDataForHandle:@"" inManagedObjectContext:[self managedObjectContextMock]], @"Expected nil return");
}

- (void)testIfManagedObjectContextIsNilMetaDataForAddressReturnsNil
{
    STAssertNil([[self repository] addressMetaDataForHandle:@"456" inManagedObjectContext:nil], @"Expected nil return");
}

- (void)testIfAbleToSaveAddressMetaDatasWillReturnYes
{
    BOOL didSave = YES;
    NSError *error;
    
    [[[[self managedObjectContextMock] stub] andReturnValue:OCMOCK_VALUE(didSave)] save:[OCMArg setTo:nil]];
    
    STAssertTrue([[self repository] saveAddressMetaDatas:nil inManagedObjectContext:[self managedObjectContextMock] error:&error], @"Unexpected false return");
}

- (void)testIfUnableToSaveAddressMetaDatasWillReturnNoAndSetError
{
    BOOL didSave = NO;
    NSError *error;
    
    [[[[self managedObjectContextMock] stub] andReturnValue:OCMOCK_VALUE(didSave)] save:[OCMArg setTo:nil]];
    
    STAssertFalse([[self repository] saveAddressMetaDatas:nil inManagedObjectContext:[self managedObjectContextMock] error:&error], @"Unexpected true return");   
}

@end
