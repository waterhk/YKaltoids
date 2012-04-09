//
//  YAMessageErrorCreator.m
//  altoids
//
//  Created by Jon Herron on 11/15/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAMessageErrorCreator.h"

// Private class extension
@interface YAMessageErrorCreator ()

// @property definitions

// methods
- (NSString *)localizedDescriptionForErrorCode:(YAMessageErrorCodes)theErrorCode;

@end

@implementation YAMessageErrorCreator

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
#pragma mark MessageErrorCreator delegate methods

- (NSError *)errorWithCode:(YAMessageErrorCodes)theErrorCode
{
    return [self errorWithCode:theErrorCode underlyingError:nil];
}

- (NSError *)errorWithCode:(YAMessageErrorCodes)theErrorCode underlyingError:(NSError *)theUnderlyingError
{
    NSString *localizedDescription = [self localizedDescriptionForErrorCode:theErrorCode];
    
    return [[self errorCreator] errorWithDomain:YAMessageErrorDomain code:theErrorCode localizedDescription:localizedDescription underlyingError:theUnderlyingError];
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
#pragma mark YAMessageErrorCreator ()

- (NSString *)localizedDescriptionForErrorCode:(YAMessageErrorCodes)theErrorCode
{
    switch (theErrorCode) 
    {
		case YAMessageErrorCodeFailedToFetchMessagesFromLocalStorage:
			return YAMessageErrorFailedToFetchMessagesFromLocalStorage;
		case YAMessageErrorCodeFailedToRetrieveMessageFromServer:
			return YAMessageErrorFailedToRetrieveMessageFromServer;
		case YAMessageErrorCodeFailedToRetrieveMessagesFromServer:
			return YAMessageErrorFailedToRetrieveMessagesFromServer;
		case YAMessageErrorCodeFailedToCreateMessageLocally:
			return YAMessageErrorFailedToCreateMessageLocally;
		case YAMessageErrorCodeFailedToDeleteAllMessagesInConversation:
			return YAMessageErrorFailedToDeleteAllMessagesInConversation;
		case YAMessageErrorCodeFailedToSaveMessageLocally:
			return YAMessageErrorFailedToSaveMessageLocally;
        default:
            return nil;
    }
}

@end
