//
//  YAParticipantErrorCreator.m
//  altoids
//
//  Created by Jon Herron on 11/15/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAParticipantErrorCreator.h"

// Private class extension
@interface YAParticipantErrorCreator ()

// @property definitions

// methods
- (NSString *)localizedDescriptionForErrorCode:(YAParticipantErrorCodes)theErrorCode;

@end

@implementation YAParticipantErrorCreator

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
#pragma mark ParticipantErrorCreator delegate methods

- (NSError *)errorWithCode:(YAParticipantErrorCodes)theErrorCode
{
    return [self errorWithCode:theErrorCode underlyingError:nil];
}

- (NSError *)errorWithCode:(YAParticipantErrorCodes)theErrorCode underlyingError:(NSError *)theUnderlyingError
{
    NSString *localizedDescription = [self localizedDescriptionForErrorCode:theErrorCode];
    
    return [[self errorCreator] errorWithDomain:YAParticipantErrorDomain code:theErrorCode localizedDescription:localizedDescription underlyingError:theUnderlyingError];
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
#pragma mark YAParticipantErrorCreator ()

- (NSString *)localizedDescriptionForErrorCode:(YAParticipantErrorCodes)theErrorCode
{
    switch (theErrorCode) 
    {
		case YAParticipantErrorCodeFailedToCreateParticipantLocally:
			return YAParticipantErrorFailedToCreateParticipantLocally;
		case YAParticipantErrorCodeMaximumNumberOfParticipantsExceeded:
			return YAParticipantErrorMaximumNumberOfParticipantsExceeded;
		case YAParticipantErrorCodeFailedToAddParticipantAsContact:
			return YAParticipantErrorFailedToAddParticipantAsContact;
		case YAParticipantErrorCodeFailedToRetrieveImageForParticipant:
			return YAParticipantErrorFailedToRetrieveImageForParticipant;
		case YAParticipantErrorCodeFailedToRemoveParticipantFromConversation:
			return YAParticipantErrorFailedToRemoveParticipantFromConversation;
		case YAParticipantErrorCodeFailedToRemotelyValidateParticipant:
			return YAParticipantErrorFailedToRemotelyValidateParticipant;
		case YAParticipantErrorCodeFailedToSaveParticipantLocally:
			return YAParticipantErrorFailedToSaveParticipantLocally;
        case YAParticipantErrorCodeFailedToFindUserInParticipantList:
            return YAParticipantErrorFailedToFindUserInParticipantList;
        default:
            return nil;
    }
}

@end
