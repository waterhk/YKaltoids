//
//  YAParticipantCreatorTests.m
//  altoids
//
//  Created by Jon Herron on 11/16/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAParticipantCreatorTests.h"
#import "ParticipantHandler.h"
#import "AddressRepository.h"
#import "ParticipantUpdater.h"
#import "ParticipantErrorCreator.h"
#import "YAParticipant.h"
#import "YAParticipantInfo.h"
#import "YAAddress.h"
#import "YAAddressInfo.h"
#import "YAParticipantCreator.h"

@interface YAParticipantCreatorTests()

@property (strong, nonatomic) id managedObjectContextMock;
@property (strong, nonatomic) id addressMock;
@property (strong, nonatomic) id addressInfoMock;
@property (strong, nonatomic) id participantMock;
@property (strong, nonatomic) id participantInfoMock;
@property (strong, nonatomic) id participantHandlerMock;
@property (strong, nonatomic) id participantUpdaterMock;
@property (strong, nonatomic) id participantErrorCreatorMock;
@property (strong, nonatomic) id addressRepositoryMock;
@property (strong, nonatomic) YAParticipantCreator *participantCreator;

- (void)verifyMocks;

@end

@implementation YAParticipantCreatorTests

@synthesize managedObjectContextMock = managedObjectContextMock_;
@synthesize addressMock = addressMock_;
@synthesize addressInfoMock = addressInfoMock_;
@synthesize participantMock = participantMock_;
@synthesize participantInfoMock = participantInfoMock_;
@synthesize participantHandlerMock = participantHandlerMock_;
@synthesize participantUpdaterMock = participantUpdaterMock_;
@synthesize participantErrorCreatorMock = participantErrorCreatorMock_;
@synthesize addressRepositoryMock = addressRepositoryMock_;
@synthesize participantCreator = participantCreator_;

- (void)setUp
{
    [self setManagedObjectContextMock:[OCMockObject mockForClass:[NSManagedObjectContext class]]];
    [self setAddressMock:[OCMockObject mockForClass:[YAAddress class]]];
    [self setAddressInfoMock:[OCMockObject mockForClass:[YAAddressInfo class]]];
    [self setParticipantMock:[OCMockObject mockForClass:[YAParticipant class]]];
    [self setParticipantInfoMock:[OCMockObject mockForClass:[YAParticipantInfo class]]];
    [self setParticipantHandlerMock:[OCMockObject mockForProtocol:@protocol(ParticipantHandler)]];
    [self setParticipantUpdaterMock:[OCMockObject mockForProtocol:@protocol(ParticipantUpdater)]];
    [self setParticipantErrorCreatorMock:[OCMockObject mockForProtocol:@protocol(ParticipantErrorCreator)]];
    [self setAddressRepositoryMock:[OCMockObject mockForProtocol:@protocol(AddressRepository)]];

    [self setParticipantCreator:[[YAParticipantCreator alloc] init]];
    [[self participantCreator] setAddressRepository:[self addressRepositoryMock]];
    [[self participantCreator] setParticipantHandler:[self participantHandlerMock]];
    [[self participantCreator] setParticipantErrorCreator:[self participantErrorCreatorMock]];
    [[self participantCreator] setParticipantUpdater:[self participantUpdaterMock]];
}

- (void)testParticipantFromParticipantInfoCreatesParticipantEntityAndSetsAddressAndFieldsFromParticipantInfo
{
    NSError *error;
    
    [[[[self participantHandlerMock] expect] andReturn:[self participantMock]] createParticipantEntityInManagedObjectContext:[self managedObjectContextMock]];
    
    [[[[self participantInfoMock] expect] andReturn:[self addressInfoMock]] addressInfo];
    [[[[self addressRepositoryMock] expect] andReturn:[self addressMock]] createAddressFromAddressInfo:[self addressInfoMock] inManagedObjectContext:[self managedObjectContextMock] error:[OCMArg setTo:nil]];
    [[[self participantUpdaterMock] expect] updateParticipant:[self participantMock] fromParticipantInfo:[self participantInfoMock] withAddress:[self addressMock]];
    
    STAssertEqualObjects([self participantMock], [[self participantCreator] participantFromParticipantInfo:[self participantInfoMock] inManagedObjectContext:[self managedObjectContextMock] error:&error], @"Unexpected participant returned");
    
    STAssertNil(error, @"Unexpected error returned");
    
    [self verifyMocks];
}

- (void)testParticipantFromParticipantInfoWillReturnNilAndSetErrorIfUnableToCreateAddressForParticipant
{
    NSError *error;
    NSError *errorFromAddressRepository = [NSError errorWithDomain:@"a" code:4321 userInfo:nil];
    NSError *errorFromErrorCreator = [NSError errorWithDomain:@"d" code:1234 userInfo:nil];
    
    [[[self participantHandlerMock] stub] createParticipantEntityInManagedObjectContext:OCMOCK_ANY];
    [[[self participantInfoMock] stub] addressInfo];
    
    [[[[self addressRepositoryMock] expect] andReturn:nil] createAddressFromAddressInfo:OCMOCK_ANY inManagedObjectContext:OCMOCK_ANY error:[OCMArg setTo:errorFromAddressRepository]];
    [[[[self participantErrorCreatorMock] expect] andReturn:errorFromErrorCreator] errorWithCode:YAParticipantErrorCodeFailedToCreateParticipantLocally underlyingError:errorFromAddressRepository];
    
    STAssertNil([[self participantCreator] participantFromParticipantInfo:[self participantInfoMock] inManagedObjectContext:[self managedObjectContextMock] error:&error], @"Unexpected participant returned");
    
    STAssertEqualObjects(error, errorFromErrorCreator, @"Unexpected error returned");
    
    [self verifyMocks];
}

- (void)verifyMocks
{
    [[self managedObjectContextMock] verify];
    [[self addressMock] verify];
    [[self addressInfoMock] verify];
    [[self participantMock] verify];
    [[self participantInfoMock] verify];
    [[self participantHandlerMock] verify];
    [[self participantUpdaterMock] verify];
    [[self participantErrorCreatorMock] verify];
    [[self addressRepositoryMock] verify];
}

@end
