//
//  YSMAuthenticationErrorCreator.m
//  altoids
//
//  Created by Jon Herron on 11/15/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YSMAuthenticationErrorCreator.h"

// Private class extension
@interface YSMAuthenticationErrorCreator ()

// @property definitions

// methods
- (NSString *)localizedDescriptionForErrorCode:(YSMAuthenticationErrorCodes)theErrorCode;

@end

@implementation YSMAuthenticationErrorCreator

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize

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
#pragma mark AuthenticationErrorCreator delegate methods

- (NSError *)errorWithCode:(YSMAuthenticationErrorCodes)theErrorCode
{
    return [self errorWithCode:theErrorCode underlyingError:nil];
}

- (NSError *)errorWithCode:(YSMAuthenticationErrorCodes)theErrorCode underlyingError:(NSError *)theUnderlyingError
{
    NSString *localizedDescription = [self localizedDescriptionForErrorCode:theErrorCode];
    
    return [self errorWithDomain:YSMAuthenticationErrorDomain code:theErrorCode localizedDescription:localizedDescription underlyingError:theUnderlyingError];
}

- (NSError *)errorWithDomain:(NSString *)theErrorDomain code:(NSInteger)theErrorCode localizedDescription:(NSString *)theLocalizedDescription underlyingError:(NSError *)theUnderlyingError
{
    NSParameterAssert(theErrorDomain);
    NSParameterAssert(theLocalizedDescription);
    
    NSMutableDictionary *userInfo;
    NSError *error;
    
    userInfo = [NSMutableDictionary dictionary];
    
    [userInfo setObject:theLocalizedDescription forKey:NSLocalizedDescriptionKey];
    
    if (theUnderlyingError) 
    {
        [userInfo setObject:theUnderlyingError forKey:NSUnderlyingErrorKey];
    }
    
    error = [NSError errorWithDomain:theErrorDomain code:theErrorCode userInfo:userInfo];
    
    return error;
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
#pragma mark YSMAuthenticationErrorCreator ()

- (NSString *)localizedDescriptionForErrorCode:(YSMAuthenticationErrorCodes)theErrorCode
{
    switch (theErrorCode) 
    {
		case YSMAuthenticationErrorCodeFailedToRetrieveSessionCrumb:
			return YSMAuthenticationErrorFailedToRetrieveSessionCrumb;
		case YSMAuthenticationErrorCodeFailedToRetrieveProfileCrumb:
			return YSMAuthenticationErrorFailedToRetrieveProfileCrumb;
		case YSMAuthenticationErrorCodeSessionCrumbExpired:
			return YSMAuthenticationErrorSessionCrumbExpired;
		case YSMAuthenticationErrorCodeProfileCrumbExpired:
			return YSMAuthenticationErrorProfileCrumbExpired;
		case YSMAuthenticationErrorCodeCookiesExpired:
			return YSMAuthenticationErrorCookiesExpired;
		case YSMAuthenticationErrorCodeSessionHasExpired:
			return YSMAuthenticationErrorSessionHasExpired;
        case YSMAuthenticationErrorCodeEmptyUsernameOrPassword:
            return YSMAuthenticationErrorEmptyUsernameOrPassword;
        case YSMAuthenticationErrorCodeInvalidUsernameOrPassword:
            return YSMAuthenticationErrorInvalidUsernameOrPassword;
        default:
            return nil;
    }
}

@end
