//
//  YAConversationErrorCreator.m
//  altoids
//
//  Created by Jon Herron on 11/15/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationErrorCreator.h"

// Private class extension
@interface YAConversationErrorCreator ()

// @property definitions

// methods
- (NSString *)localizedDescriptionForErrorCode:(YAConversationErrorCodes)theErrorCode;

@end

@implementation YAConversationErrorCreator

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize errorCreator = errorCreator_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark ConversationErrorCreator delegate methods

- (NSError *)errorWithCode:(YAConversationErrorCodes)theErrorCode
{
    return [self errorWithCode:theErrorCode underlyingError:nil];
}

- (NSError *)errorWithCode:(YAConversationErrorCodes)theErrorCode underlyingError:(NSError *)theUnderlyingError
{
    NSString *localizedDescription = [self localizedDescriptionForErrorCode:theErrorCode];
    
    return [[self errorCreator] errorWithDomain:YAConversationErrorDomain code:theErrorCode localizedDescription:localizedDescription underlyingError:theUnderlyingError];
}

// Public methods
#pragma mark -
#pragma mark Public methods

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YAConversationErrorCreator ()

- (NSString *)localizedDescriptionForErrorCode:(YAConversationErrorCodes)theErrorCode
{
    switch (theErrorCode) 
    {
		case YAConversationErrorCodeFailedToFetchConversationFromLocalStorage:
			return YAConversationErrorFailedToFetchConversationFromLocalStorage;
		case YAConversationErrorCodeFailedToFetchConversationsFromLocalStorage:
			return YAConversationErrorFailedToFetchConversationsFromLocalStorage;
		case YAConversationErrorCodeFailedToRetrieveConversationFromServer:
			return YAConversationErrorFailedToRetrieveConversationFromServer;
		case YAConversationErrorCodeFailedToRetrieveConversationsFromServer:
			return YAConversationErrorFailedToRetrieveConversationsFromServer;
		case YAConversationErrorCodeFailedToCreateConversationLocally:
			return YAConversationErrorFailedToCreateConversationLocally;
		case YAConversationErrorCodeFailedToCreateConversationRemotely:
			return YAConversationErrorFailedToCreateConversationRemotely;
		case YAConversationErrorCodeFailedToEditConversationRemotely:
			return YAConversationErrorFailedToEditConversationRemotely;
		case YAConversationErrorCodeFailedToSaveConversationLocally:
			return YAConversationErrorFailedToSaveConversationLocally;
		case YAConversationErrorCodeFailedToSaveConversationsLocally:
			return YAConversationErrorFailedToSaveConversationsLocally;
		case YAConversationErrorCodeFailedToAddMessageToConversation:
			return YAConversationErrorFailedToAddMessageToConversation;
		case YAConversationErrorCodeFailedToDeleteAllConversation:
			return YAConversationErrorFailedToDeleteAllConversation;
		case YAConversationErrorCodeFailedToDeleteConversation:
			return YAConversationErrorFailedToDeleteConversation;
		case YAConversationErrorCodeFailedToReplyToConversation:
			return YAConversationErrorFailedToReplyToConversation;
		case YAConversationErrorCodeFailedToLeaveConversation:
			return YAConversationErrorFailedToLeaveConversation;
        case YAConversationErrorCodeFailedToAddParticipantToConversation:
            return YAConversationErrorFailedToAddParticipantToConversation;
        case YAConversationErrorCodeFailedToAddParticipantsToConversation:
            return YAConversationErrorFailedToAddParticipantsToConversation;
        case YAConversationErrorCodeFailedToUpdateParticipantsInConversation:
            return YAConversationErrorFailedToUpdateParticipantsInConversation;
        default:
            return nil;
    }
}

@end
