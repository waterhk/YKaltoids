//
//  YAConversationErrorCreatorTests.m
//  altoids
//
//  Created by Jon Herron on 11/15/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAConversationErrorCreatorTests.h"
#import "YAConversationErrorCreator.h"
#import "ErrorCreator.h"

@interface YAConversationErrorCreatorTests()

@property (strong, nonatomic) id errorCreatorMock;
@property (strong, nonatomic) YAConversationErrorCreator *conversationErrorCreator;

@end

@implementation YAConversationErrorCreatorTests

@synthesize errorCreatorMock = errorCreatorMock_;
@synthesize conversationErrorCreator = conversationErrorCreator_;

- (void)setUp
{
    [self setErrorCreatorMock:[OCMockObject mockForProtocol:@protocol(ErrorCreator)]];
    [self setConversationErrorCreator:[[YAConversationErrorCreator alloc] init]];
    [[self conversationErrorCreator] setErrorCreator:[self errorCreatorMock]];
}

- (void)testCreatesErrorWithinConversationErrorDomainAndGivenErrorCode
{
    [[[self errorCreatorMock] expect] errorWithDomain:YAConversationErrorDomain code:100 localizedDescription:OCMOCK_ANY underlyingError:OCMOCK_ANY];
    
    [[self conversationErrorCreator] errorWithCode:100];
    
    [[self errorCreatorMock] verify];
}

- (void)testCreatesErrorWithCorrectLocalizedStringForErrorCode
{
	[[[self errorCreatorMock] expect] errorWithDomain:YAConversationErrorDomain code:YAConversationErrorCodeFailedToFetchConversationFromLocalStorage localizedDescription:YAConversationErrorFailedToFetchConversationFromLocalStorage underlyingError:nil];
	[[self conversationErrorCreator] errorWithCode:YAConversationErrorCodeFailedToFetchConversationFromLocalStorage];

	[[[self errorCreatorMock] expect] errorWithDomain:YAConversationErrorDomain code:YAConversationErrorCodeFailedToFetchConversationsFromLocalStorage localizedDescription:YAConversationErrorFailedToFetchConversationsFromLocalStorage underlyingError:nil];
	[[self conversationErrorCreator] errorWithCode:YAConversationErrorCodeFailedToFetchConversationsFromLocalStorage];

	[[[self errorCreatorMock] expect] errorWithDomain:YAConversationErrorDomain code:YAConversationErrorCodeFailedToRetrieveConversationFromServer localizedDescription:YAConversationErrorFailedToRetrieveConversationFromServer underlyingError:nil];
	[[self conversationErrorCreator] errorWithCode:YAConversationErrorCodeFailedToRetrieveConversationFromServer];

	[[[self errorCreatorMock] expect] errorWithDomain:YAConversationErrorDomain code:YAConversationErrorCodeFailedToRetrieveConversationsFromServer localizedDescription:YAConversationErrorFailedToRetrieveConversationsFromServer underlyingError:nil];
	[[self conversationErrorCreator] errorWithCode:YAConversationErrorCodeFailedToRetrieveConversationsFromServer];

	[[[self errorCreatorMock] expect] errorWithDomain:YAConversationErrorDomain code:YAConversationErrorCodeFailedToCreateConversationLocally localizedDescription:YAConversationErrorFailedToCreateConversationLocally underlyingError:nil];
	[[self conversationErrorCreator] errorWithCode:YAConversationErrorCodeFailedToCreateConversationLocally];

	[[[self errorCreatorMock] expect] errorWithDomain:YAConversationErrorDomain code:YAConversationErrorCodeFailedToCreateConversationRemotely localizedDescription:YAConversationErrorFailedToCreateConversationRemotely underlyingError:nil];
	[[self conversationErrorCreator] errorWithCode:YAConversationErrorCodeFailedToCreateConversationRemotely];

	[[[self errorCreatorMock] expect] errorWithDomain:YAConversationErrorDomain code:YAConversationErrorCodeFailedToEditConversationRemotely localizedDescription:YAConversationErrorFailedToEditConversationRemotely underlyingError:nil];
	[[self conversationErrorCreator] errorWithCode:YAConversationErrorCodeFailedToEditConversationRemotely];

	[[[self errorCreatorMock] expect] errorWithDomain:YAConversationErrorDomain code:YAConversationErrorCodeFailedToSaveConversationLocally localizedDescription:YAConversationErrorFailedToSaveConversationLocally underlyingError:nil];
	[[self conversationErrorCreator] errorWithCode:YAConversationErrorCodeFailedToSaveConversationLocally];

	[[[self errorCreatorMock] expect] errorWithDomain:YAConversationErrorDomain code:YAConversationErrorCodeFailedToSaveConversationsLocally localizedDescription:YAConversationErrorFailedToSaveConversationsLocally underlyingError:nil];
	[[self conversationErrorCreator] errorWithCode:YAConversationErrorCodeFailedToSaveConversationsLocally];

	[[[self errorCreatorMock] expect] errorWithDomain:YAConversationErrorDomain code:YAConversationErrorCodeFailedToAddMessageToConversation localizedDescription:YAConversationErrorFailedToAddMessageToConversation underlyingError:nil];
	[[self conversationErrorCreator] errorWithCode:YAConversationErrorCodeFailedToAddMessageToConversation];

	[[[self errorCreatorMock] expect] errorWithDomain:YAConversationErrorDomain code:YAConversationErrorCodeFailedToDeleteAllConversation localizedDescription:YAConversationErrorFailedToDeleteAllConversation underlyingError:nil];
	[[self conversationErrorCreator] errorWithCode:YAConversationErrorCodeFailedToDeleteAllConversation];

	[[[self errorCreatorMock] expect] errorWithDomain:YAConversationErrorDomain code:YAConversationErrorCodeFailedToDeleteConversation localizedDescription:YAConversationErrorFailedToDeleteConversation underlyingError:nil];
	[[self conversationErrorCreator] errorWithCode:YAConversationErrorCodeFailedToDeleteConversation];

	[[[self errorCreatorMock] expect] errorWithDomain:YAConversationErrorDomain code:YAConversationErrorCodeFailedToReplyToConversation localizedDescription:YAConversationErrorFailedToReplyToConversation underlyingError:nil];
	[[self conversationErrorCreator] errorWithCode:YAConversationErrorCodeFailedToReplyToConversation];

	[[[self errorCreatorMock] expect] errorWithDomain:YAConversationErrorDomain code:YAConversationErrorCodeFailedToLeaveConversation localizedDescription:YAConversationErrorFailedToLeaveConversation underlyingError:nil];
	[[self conversationErrorCreator] errorWithCode:YAConversationErrorCodeFailedToLeaveConversation];
    
	[[[self errorCreatorMock] expect] errorWithDomain:YAConversationErrorDomain code:YAConversationErrorCodeFailedToAddParticipantToConversation localizedDescription:YAConversationErrorFailedToAddParticipantToConversation underlyingError:nil];
	[[self conversationErrorCreator] errorWithCode:YAConversationErrorCodeFailedToAddParticipantToConversation];
    
	[[[self errorCreatorMock] expect] errorWithDomain:YAConversationErrorDomain code:YAConversationErrorCodeFailedToAddParticipantsToConversation localizedDescription:YAConversationErrorFailedToAddParticipantsToConversation underlyingError:nil];
	[[self conversationErrorCreator] errorWithCode:YAConversationErrorCodeFailedToAddParticipantsToConversation];
    
	[[[self errorCreatorMock] expect] errorWithDomain:YAConversationErrorDomain code:YAConversationErrorCodeFailedToUpdateParticipantsInConversation localizedDescription:YAConversationErrorFailedToUpdateParticipantsInConversation underlyingError:nil];
	[[self conversationErrorCreator] errorWithCode:YAConversationErrorCodeFailedToUpdateParticipantsInConversation];

    [[self errorCreatorMock] verify];
}

- (void)testCreatesErrorWithUnderlyingErrorIfPresent
{
    NSError *underlyingError = [NSError errorWithDomain:@"domain" code:1234 userInfo:nil];
    
    [[[self errorCreatorMock] expect] errorWithDomain:OCMOCK_ANY code:1 localizedDescription:OCMOCK_ANY underlyingError:underlyingError];
    
    [[self conversationErrorCreator] errorWithCode:1 underlyingError:underlyingError];
    
    [[self errorCreatorMock] verify];
}

- (void)testReturnsErrorCreatedByErrorCreator
{
    NSError *error = [NSError errorWithDomain:@"domain" code:1234 userInfo:nil];
    
    [[[[self errorCreatorMock] expect] andReturn:error] errorWithDomain:OCMOCK_ANY code:1 localizedDescription:OCMOCK_ANY underlyingError:OCMOCK_ANY];
    
    STAssertEqualObjects(error, [[self conversationErrorCreator] errorWithCode:1], @"Unexpected error returned");
}

@end
