//
//  YAAddressErrorCreator.m
//  altoids
//
//  Created by Jon Herron on 11/15/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAAddressErrorCreator.h"

// Private class extension
@interface YAAddressErrorCreator ()

// @property definitions

// methods
- (NSString *)localizedDescriptionForErrorCode:(YAAddressErrorCodes)theErrorCode;

@end

@implementation YAAddressErrorCreator

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
#pragma mark AddressErrorCreator delegate methods

- (NSError *)errorWithCode:(YAAddressErrorCodes)theErrorCode
{
    return [self errorWithCode:theErrorCode underlyingError:nil];
}

- (NSError *)errorWithCode:(YAAddressErrorCodes)theErrorCode underlyingError:(NSError *)theUnderlyingError
{
    NSString *localizedDescription = [self localizedDescriptionForErrorCode:theErrorCode];
    
    return [[self errorCreator] errorWithDomain:YAAddressErrorDomain code:theErrorCode localizedDescription:localizedDescription underlyingError:theUnderlyingError];
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
#pragma mark YAAddressErrorCreator ()

- (NSString *)localizedDescriptionForErrorCode:(YAAddressErrorCodes)theErrorCode
{
    switch (theErrorCode) 
    {
		case YAAddressErrorCodeFailedToCreateAddressLocally:
			return YAAddressErrorFailedToCreateAddressLocally;
		case YAAddressErrorCodeFailedToFormatAddress:
			return YAAddressErrorFailedToFormatAddress;
		case YAAddressErrorCodeFailedToNormalizeAddress:
			return YAAddressErrorFailedToNormalizeAddress;
		case YAAddressErrorCodeUnknownAddressType:
			return YAAddressErrorUnknownAddressType;
        default:
            return nil;
    }
}

@end
