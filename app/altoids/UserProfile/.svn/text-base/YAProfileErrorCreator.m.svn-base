//
//  YAProfileErrorCreator.m
//  altoids
//
//  Created by Jon Herron on 11/15/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAProfileErrorCreator.h"

// Private class extension
@interface YAProfileErrorCreator ()

// @property definitions

// methods
- (NSString *)localizedDescriptionForErrorCode:(YAProfileErrorCodes)theErrorCode;

@end

@implementation YAProfileErrorCreator

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
#pragma mark ProfileErrorCreator delegate methods

- (NSError *)errorWithCode:(YAProfileErrorCodes)theErrorCode
{
    return [self errorWithCode:theErrorCode underlyingError:nil];
}

- (NSError *)errorWithCode:(YAProfileErrorCodes)theErrorCode underlyingError:(NSError *)theUnderlyingError
{
    NSString *localizedDescription = [self localizedDescriptionForErrorCode:theErrorCode];
    
    return [[self errorCreator] errorWithDomain:YAProfileErrorDomain code:theErrorCode localizedDescription:localizedDescription underlyingError:theUnderlyingError];
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
#pragma mark YAProfileErrorCreator ()

- (NSString *)localizedDescriptionForErrorCode:(YAProfileErrorCodes)theErrorCode
{
    switch (theErrorCode) 
    {
		case YAProfileErrorCodeFailedToCreateUserProfileLocally:
			return YAProfileErrorFailedToCreateUserProfileLocally;
		case YAProfileErrorCodeFailedToFetchUserProfileFromLocalStorage:
			return YAProfileErrorFailedToFetchUserProfileFromLocalStorage;
		case YAProfileErrorCodeFailedToRetrieveUserProfile:
			return YAProfileErrorFailedToRetrieveUserProfile;
		case YAProfileErrorCodeFailedToSaveUserProfile:
			return YAProfileErrorFailedToSaveUserProfile;
        default:
            return YAProfileErrorUnknownError;
    }
}

@end
