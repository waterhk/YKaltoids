//
//  YAParticipantErrorCreatorTests.m
//  altoids
//
//  Created by Jon Herron on 11/15/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAParticipantErrorCreatorTests.h"
#import "YAParticipantErrorCreator.h"
#import "ErrorCreator.h"

@interface YAParticipantErrorCreatorTests()

@property (strong, nonatomic) id errorCreatorMock;
@property (strong, nonatomic) YAParticipantErrorCreator *participantErrorCreator;

@end

@implementation YAParticipantErrorCreatorTests

@synthesize errorCreatorMock = errorCreatorMock_;
@synthesize participantErrorCreator = participantErrorCreator_;

- (void)setUp
{
    [self setErrorCreatorMock:[OCMockObject mockForProtocol:@protocol(ErrorCreator)]];

    [self setParticipantErrorCreator:[[YAParticipantErrorCreator alloc] init]];
    [[self participantErrorCreator] setErrorCreator:[self errorCreatorMock]];
}

- (void)testCreatesErrorWithinParticipantErrorDomainAndGivenErrorCode
{
    [[[self errorCreatorMock] expect] errorWithDomain:YAParticipantErrorDomain code:100 localizedDescription:OCMOCK_ANY underlyingError:OCMOCK_ANY];
    
    [[self participantErrorCreator] errorWithCode:100];
    
    [[self errorCreatorMock] verify];
}

- (void)testCreatesErrorWithCorrectLocalizedStringForErrorCode
{
	[[[self errorCreatorMock] expect] errorWithDomain:YAParticipantErrorDomain code:YAParticipantErrorCodeFailedToCreateParticipantLocally localizedDescription:YAParticipantErrorFailedToCreateParticipantLocally underlyingError:nil];
	[[self participantErrorCreator] errorWithCode:YAParticipantErrorCodeFailedToCreateParticipantLocally];

	[[[self errorCreatorMock] expect] errorWithDomain:YAParticipantErrorDomain code:YAParticipantErrorCodeMaximumNumberOfParticipantsExceeded localizedDescription:YAParticipantErrorMaximumNumberOfParticipantsExceeded underlyingError:nil];
	[[self participantErrorCreator] errorWithCode:YAParticipantErrorCodeMaximumNumberOfParticipantsExceeded];

	[[[self errorCreatorMock] expect] errorWithDomain:YAParticipantErrorDomain code:YAParticipantErrorCodeFailedToAddParticipantAsContact localizedDescription:YAParticipantErrorFailedToAddParticipantAsContact underlyingError:nil];
	[[self participantErrorCreator] errorWithCode:YAParticipantErrorCodeFailedToAddParticipantAsContact];

	[[[self errorCreatorMock] expect] errorWithDomain:YAParticipantErrorDomain code:YAParticipantErrorCodeFailedToRetrieveImageForParticipant localizedDescription:YAParticipantErrorFailedToRetrieveImageForParticipant underlyingError:nil];
	[[self participantErrorCreator] errorWithCode:YAParticipantErrorCodeFailedToRetrieveImageForParticipant];

	[[[self errorCreatorMock] expect] errorWithDomain:YAParticipantErrorDomain code:YAParticipantErrorCodeFailedToRemoveParticipantFromConversation localizedDescription:YAParticipantErrorFailedToRemoveParticipantFromConversation underlyingError:nil];
	[[self participantErrorCreator] errorWithCode:YAParticipantErrorCodeFailedToRemoveParticipantFromConversation];

	[[[self errorCreatorMock] expect] errorWithDomain:YAParticipantErrorDomain code:YAParticipantErrorCodeFailedToRemotelyValidateParticipant localizedDescription:YAParticipantErrorFailedToRemotelyValidateParticipant underlyingError:nil];
	[[self participantErrorCreator] errorWithCode:YAParticipantErrorCodeFailedToRemotelyValidateParticipant];

	[[[self errorCreatorMock] expect] errorWithDomain:YAParticipantErrorDomain code:YAParticipantErrorCodeFailedToSaveParticipantLocally localizedDescription:YAParticipantErrorFailedToSaveParticipantLocally underlyingError:nil];
	[[self participantErrorCreator] errorWithCode:YAParticipantErrorCodeFailedToSaveParticipantLocally];

    [[self errorCreatorMock] verify];
}

- (void)testCreatesErrorWithUnderlyingErrorIfPresent
{
    NSError *underlyingError = [NSError errorWithDomain:@"domain" code:1234 userInfo:nil];
    
    [[[self errorCreatorMock] expect] errorWithDomain:OCMOCK_ANY code:1 localizedDescription:OCMOCK_ANY underlyingError:underlyingError];
    
    [[self participantErrorCreator] errorWithCode:1 underlyingError:underlyingError];
    
    [[self errorCreatorMock] verify];
}

- (void)testReturnsErrorCreatedByErrorCreator
{
    NSError *error = [NSError errorWithDomain:@"domain" code:1234 userInfo:nil];
    
    [[[[self errorCreatorMock] expect] andReturn:error] errorWithDomain:OCMOCK_ANY code:1 localizedDescription:OCMOCK_ANY underlyingError:OCMOCK_ANY];
    
    STAssertEqualObjects(error, [[self participantErrorCreator] errorWithCode:1], @"Unexpected error returned");
}

@end
