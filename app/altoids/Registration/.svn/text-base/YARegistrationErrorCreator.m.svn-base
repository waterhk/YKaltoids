//
//  YARegistrationErrorCreator.m
//  altoids
//
//  Created by Jon Herron on 11/15/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YARegistrationErrorCreator.h"

// Private class extension
@interface YARegistrationErrorCreator ()

// @property definitions

// methods
- (NSString *)localizedDescriptionForErrorCode:(YARegistrationErrorCodes)theErrorCode;

@end

@implementation YARegistrationErrorCreator

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
#pragma mark RegistrationErrorCreator delegate methods

- (NSError *)errorWithCode:(YARegistrationErrorCodes)theErrorCode
{
    return [self errorWithCode:theErrorCode underlyingError:nil];
}

- (NSError *)errorWithCode:(YARegistrationErrorCodes)theErrorCode underlyingError:(NSError *)theUnderlyingError
{
    NSString *localizedDescription = [self localizedDescriptionForErrorCode:theErrorCode];
    
    return [[self errorCreator] errorWithDomain:YARegistrationErrorDomain code:theErrorCode localizedDescription:localizedDescription underlyingError:theUnderlyingError];
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
#pragma mark YARegistrationErrorCreator ()

- (NSString *)localizedDescriptionForErrorCode:(YARegistrationErrorCodes)theErrorCode
{
    switch (theErrorCode) 
    {
		case YARegistrationErrorCodeFailedToFetchRegistrationInformationFromLocalStorage:
			return YARegistrationErrorFailedToFetchRegistrationInformationFromLocalStorage;
		case YARegistrationErrorCodeFailedToSaveRegistrationInformationLocally:
			return YARegistrationErrorFailedToSaveRegistrationInformationLocally;
		case YARegistrationErrorCodeFailedToRetrieveToken:
			return YARegistrationErrorFailedToRetrieveToken;
		case YARegistrationErrorCodeFailedToVerifyToken:
			return YARegistrationErrorFailedToVerifyToken;
		case YARegistrationErrorCodeFailedToRenewRegistration:
			return YARegistrationErrorFailedToRenewRegistration;
		case YARegistrationErrorCodeFailedToVerfiyCarrier:
			return YARegistrationErrorFailedToVerfiyCarrier;
		case YARegistrationErrorCodeUnableToSendSMS:
			return YARegistrationErrorUnableToSendSMS;
		case YARegistrationErrorCodeFailedToSaveRegistrationInformation:
			return YARegistrationErrorFailedToSaveRegistrationInformation;
        case YARegistrationErrorCodeGeneralError:
            return YARegistrationErrorGeneralError;
        default:
            return nil;
    }
}

@end
