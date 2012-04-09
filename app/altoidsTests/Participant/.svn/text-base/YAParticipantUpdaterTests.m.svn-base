//
//  YAParticipantUpdaterTests.m
//  altoids
//
//  Created by Jon Herron on 11/16/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAParticipantUpdaterTests.h"
#import "YAAddress.h"
#import "YAParticipant.h"
#import "YAParticipantInfo.h"
#import "ParticipantHandler.h"
#import "ParticipantTransientIDFormatter.h"
#import "YAParticipantUpdater.h"

@interface YAParticipantUpdaterTests()

@property (strong, nonatomic) id addressMock;
@property (strong, nonatomic) id participantMock;
@property (strong, nonatomic) id participantInfoMock;
@property (strong, nonatomic) id participantHandlerMock;
@property (strong, nonatomic) id participantTransientIDFormatterMock;
@property (strong, nonatomic) YAParticipantUpdater *participantUpdater;

@end

@implementation YAParticipantUpdaterTests

@synthesize addressMock = addressMock_;
@synthesize participantMock = participantMock_;
@synthesize participantInfoMock = participantInfoMock_;
@synthesize participantHandlerMock = participantHandlerMock_;
@synthesize participantTransientIDFormatterMock = participantTransientIDFormatterMock_;
@synthesize participantUpdater = participantUpdater_;

- (void)setUp
{
    [self setAddressMock:[OCMockObject mockForClass:[YAAddress class]]];
    [self setParticipantMock:[OCMockObject mockForClass:[YAParticipant class]]];
    [self setParticipantInfoMock:[OCMockObject mockForClass:[YAParticipantInfo class]]];
    [self setParticipantHandlerMock:[OCMockObject mockForProtocol:@protocol(ParticipantHandler)]];
    [self setParticipantTransientIDFormatterMock:[OCMockObject mockForProtocol:@protocol(ParticipantTransientIDFormatter)]];
    
    [self setParticipantUpdater:[[YAParticipantUpdater alloc] init]];
    [[self participantUpdater] setParticipantTransientIDFormatter:[self participantTransientIDFormatterMock]];
    [[self participantUpdater] setParticipantHandler:[self participantHandlerMock]];
}

- (void)testUsesGivenAddressAndParticipantInfoToUpdateParticipantEntity
{
    NSString *firstName = @"fname";
    NSString *lastName = @"lname";
    NSDate *timestamp = [NSDate date];
    NSString *imageURL = @"url";
    BOOL isUser = NO;
    NSString *participantID = @"pid";
    
    [[[[self participantInfoMock] expect] andReturn:firstName] firstName];
    [[[[self participantInfoMock] expect] andReturn:lastName] lastName];
    [(YAParticipantInfo *)[[[self participantInfoMock] expect] andReturn:timestamp] timestamp];
    [[[[self participantInfoMock] expect] andReturn:imageURL] imageURL];
    [(YAParticipantInfo *)[[[self participantInfoMock] expect] andReturnValue:OCMOCK_VALUE(isUser)] isUser];
    [[[[self participantInfoMock] expect] andReturn:participantID] participantID];
    
    [[[self participantHandlerMock] expect] setAddress:[self addressMock] forParticipant:[self participantMock]];
    [[[self participantHandlerMock] expect] setFirstName:firstName forParticipant:[self participantMock]];
    [[[self participantHandlerMock] expect] setLastName:lastName forParticipant:[self participantMock]];
    [[[self participantHandlerMock] expect] setTimestamp:timestamp forParticipant:[self participantMock]];
    [[[self participantHandlerMock] expect] setPhotoURL:imageURL forParticipant:[self participantMock]];
    [[[self participantHandlerMock] expect] setIsUser:isUser forParticipant:[self participantMock]];
    [[[self participantHandlerMock] expect] setParticipantID:participantID forParticipant:[self participantMock]];
    
    [[self participantUpdater] updateParticipant:[self participantMock] fromParticipantInfo:[self participantInfoMock] withAddress:[self addressMock]];
    
    [[self addressMock] verify];
    [[self participantMock] verify];
    [[self participantInfoMock] verify];
    [[self participantHandlerMock] verify];
    [[self participantTransientIDFormatterMock] verify];
}

- (void)testIfParticipantInfoHasNilIDTransientIDFormatterIsUsedToConstructParticipantID
{
    BOOL isUser = NO;
    NSString *transientID = @"transID";
    
    [[[self participantInfoMock] stub] firstName];
    [[[self participantInfoMock] stub] lastName];
    [(YAParticipantInfo *)[[self participantInfoMock] stub] timestamp];
    [[[self participantInfoMock] stub] imageURL];
    [(YAParticipantInfo *)[[[self participantInfoMock] stub] andReturnValue:OCMOCK_VALUE(isUser)] isUser];
    [[[[self participantInfoMock] expect] andReturn:nil] participantID];
    
    [[[self participantHandlerMock] stub] setAddress:OCMOCK_ANY forParticipant:OCMOCK_ANY];
    [[[self participantHandlerMock] stub] setFirstName:OCMOCK_ANY forParticipant:OCMOCK_ANY];
    [[[self participantHandlerMock] stub] setLastName:OCMOCK_ANY forParticipant:OCMOCK_ANY];
    [[[self participantHandlerMock] stub] setTimestamp:OCMOCK_ANY forParticipant:OCMOCK_ANY];
    [[[self participantHandlerMock] stub] setPhotoURL:OCMOCK_ANY forParticipant:OCMOCK_ANY];
    [[[self participantHandlerMock] stub] setIsUser:isUser forParticipant:OCMOCK_ANY];
    
    [[[[self participantTransientIDFormatterMock] expect] andReturn:transientID] transientIDForParticipant:[self participantMock]];
    [[[self participantHandlerMock] expect] setParticipantID:transientID forParticipant:[self participantMock]];
    
    [[self participantUpdater] updateParticipant:[self participantMock] fromParticipantInfo:[self participantInfoMock] withAddress:[self addressMock]];
    
    [[self addressMock] verify];
    [[self participantMock] verify];
    [[self participantInfoMock] verify];
    [[self participantHandlerMock] verify];
    [[self participantTransientIDFormatterMock] verify];
}

@end
