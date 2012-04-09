//
//  YAParticipantRepositoryTests.m
//  altoids
//
//  Created by Jon Herron on 11/16/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAParticipantRepositoryTests.h"
#import "ParticipantHandler.h"
#import "AddressRepository.h"
#import "ParticipantUpdater.h"
#import "ParticipantErrorCreator.h"
#import "ParticipantCreator.h"
#import "MutableSetCreator.h"
#import "YAParticipant.h"
#import "YAParticipantInfo.h"
#import "YAAddress.h"
#import "YAAddressInfo.h"
#import "YAParticipantRepository.h"
#import "UserProfileHandler.h"
#import "UserProfileRepository.h"

@interface YAParticipantRepositoryTests()

@property (strong, nonatomic) id managedObjectContextMock;
@property (strong, nonatomic) id addressMock;
@property (strong, nonatomic) id addressInfoMock;
@property (strong, nonatomic) id participantMock;
@property (strong, nonatomic) id participantInfoMock;
@property (strong, nonatomic) id participantHandlerMock;
@property (strong, nonatomic) id participantUpdaterMock;
@property (strong, nonatomic) id participantErrorCreatorMock;
@property (strong, nonatomic) id addressRepositoryMock;
@property (strong, nonatomic) id participantCreatorMock;
@property (strong, nonatomic) id mutableSetCreatorMock;
@property (strong, nonatomic) id userProfileHandlerMock;
@property (strong, nonatomic) id userProfileRepositoryMock;
@property (strong, nonatomic) YAParticipantRepository *participantRepository;

- (void)verifyMocks;

@end

@implementation YAParticipantRepositoryTests

@synthesize managedObjectContextMock = managedObjectContextMock_;
@synthesize addressMock = addressMock_;
@synthesize addressInfoMock = addressInfoMock_;
@synthesize participantMock = participantMock_;
@synthesize participantInfoMock = participantInfoMock_;
@synthesize participantHandlerMock = participantHandlerMock_;
@synthesize participantUpdaterMock = participantUpdaterMock_;
@synthesize participantErrorCreatorMock = participantErrorCreatorMock_;
@synthesize addressRepositoryMock = addressRepositoryMock_;
@synthesize participantCreatorMock = participantCreatorMock_;
@synthesize mutableSetCreatorMock = mutableSetCreatorMock_;
@synthesize userProfileHandlerMock = userProfileHandlerMock_;
@synthesize userProfileRepositoryMock = userProfileRepositoryMock_;
@synthesize participantRepository = participantRepository_;

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
    [self setParticipantCreatorMock:[OCMockObject mockForProtocol:@protocol(ParticipantCreator)]];
    [self setMutableSetCreatorMock:[OCMockObject mockForProtocol:@protocol(MutableSetCreator)]];
    [self setUserProfileHandlerMock:[OCMockObject mockForProtocol:@protocol(UserProfileHandler)]];
    [self setUserProfileRepositoryMock:[OCMockObject mockForProtocol:@protocol(UserProfileRepository)]];
    
    [self setParticipantRepository:[[YAParticipantRepository alloc] init]];
    [[self participantRepository] setParticipantHandler:[self participantHandlerMock]];
    [[self participantRepository] setAddressRepository:[self addressRepositoryMock]];
    [[self participantRepository] setParticipantErrorCreator:[self participantErrorCreatorMock]];
    [[self participantRepository] setMutableSetCreator:[self mutableSetCreatorMock]];
    [[self participantRepository] setParticipantUpdater:[self participantUpdaterMock]];
    [[self participantRepository] setParticipantCreator:[self participantCreatorMock]];
    [[self participantRepository] setUserProfileRepository:[self userProfileRepositoryMock]];
    [[self participantRepository] setUserProfileHandler:[self userProfileHandlerMock]];
}

- (void)testCreateParticipantFromParticipantInfoCreatesParticipantEntityFromParticipantInfo
{
    NSError *error;
    
    [[[[self participantCreatorMock] expect] andReturn:[self participantMock]] participantFromParticipantInfo:[self participantInfoMock] inManagedObjectContext:[self managedObjectContextMock] error:[OCMArg setTo:nil]];
    
    STAssertEqualObjects([self participantMock], [[self participantRepository] createParticipantFromParticipantInfo:[self participantInfoMock] inManagedObjectContext:[self managedObjectContextMock] error:&error], @"Unexpected participant returned");
    
    STAssertNil(error, @"Unexpected error returned");
    
    [self verifyMocks];
}

- (void)testCreateParticipantFromParticipantInfoWillReturnNilAndSetErrorIfUnableToCreateParticipant
{
    NSError *error;
    NSError *errorFromParticipantCreator = [NSError errorWithDomain:@"d" code:1234 userInfo:nil];
    
    [[[[self participantCreatorMock] expect] andReturn:nil] participantFromParticipantInfo:[self participantInfoMock] inManagedObjectContext:[self managedObjectContextMock] error:[OCMArg setTo:errorFromParticipantCreator]];
    
    STAssertNil([[self participantRepository] createParticipantFromParticipantInfo:[self participantInfoMock] inManagedObjectContext:[self managedObjectContextMock] error:&error], @"Unexpected participant returned");
    
    STAssertEqualObjects(error, errorFromParticipantCreator, @"Unexpected error returned");
    
    [self verifyMocks];
}

- (void)testCreateParticipantsFromArrayOfParticipantInfoCreatesParticipantEntityForEachParticipantInfo
{
    NSError *error;
    
    id mutableSetMock = [OCMockObject mockForClass:[NSMutableSet class]];
    id participant1 = [OCMockObject mockForClass:[YAParticipant class]];
    id participant2 = [OCMockObject mockForClass:[YAParticipant class]];
    id participant3 = [OCMockObject mockForClass:[YAParticipant class]];
    id participantInfo1 = [OCMockObject mockForClass:[YAParticipantInfo class]];
    id participantInfo2 = [OCMockObject mockForClass:[YAParticipantInfo class]];
    id participantInfo3 = [OCMockObject mockForClass:[YAParticipantInfo class]];
    NSArray *participantInfos = [NSArray arrayWithObjects:participantInfo1, participantInfo2, participantInfo3, nil];
    NSSet *result;
    
    [[[[self mutableSetCreatorMock] expect] andReturn:mutableSetMock] mutableSetWithCapacity:[participantInfos count]];
    
    [[[[self participantCreatorMock] expect] andReturn:participant1] participantFromParticipantInfo:participantInfo1 inManagedObjectContext:[self managedObjectContextMock] error:[OCMArg setTo:nil]];
    [[[[self participantCreatorMock] expect] andReturn:participant2] participantFromParticipantInfo:participantInfo2 inManagedObjectContext:[self managedObjectContextMock] error:[OCMArg setTo:nil]];
    [[[[self participantCreatorMock] expect] andReturn:participant3] participantFromParticipantInfo:participantInfo3 inManagedObjectContext:[self managedObjectContextMock] error:[OCMArg setTo:nil]];
    
    [[mutableSetMock expect] addObject:participant1];
    [[mutableSetMock expect] addObject:participant2];
    [[mutableSetMock expect] addObject:participant3];
    
    result = [[self participantRepository] createParticipantsFromArrayOfParticipantInfo:participantInfos inManagedObjectContext:[self managedObjectContextMock] error:&error];
    
    STAssertNil(error, @"Unexpected error");
    STAssertNotNil(result, @"Unexpected result");
    
    [self verifyMocks];
}

- (void)testCreateParticipantsFromArrayOfParticipantInfoWillReturnNilAndSetErrorIfUnableToCreateParticipant
{
    NSArray *participantInfos = [NSArray arrayWithObject:[self participantInfoMock]];
    NSError *error;
    NSError *errorFromParticipantCreator = [NSError errorWithDomain:@"d" code:1234 userInfo:nil];
    
    [[[self mutableSetCreatorMock] stub] mutableSetWithCapacity:[participantInfos count]];
    
    [[[[self participantCreatorMock] expect] andReturn:nil] participantFromParticipantInfo:[self participantInfoMock] inManagedObjectContext:[self managedObjectContextMock] error:[OCMArg setTo:errorFromParticipantCreator]];
    
    STAssertNil([[self participantRepository] createParticipantsFromArrayOfParticipantInfo:participantInfos inManagedObjectContext:[self managedObjectContextMock] error:&error], @"Unexpected return");
    
    STAssertEqualObjects(errorFromParticipantCreator, error, @"Unexpected error");
    
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
    [[self participantCreatorMock] verify];
    [[self mutableSetCreatorMock] verify];
}

@end
