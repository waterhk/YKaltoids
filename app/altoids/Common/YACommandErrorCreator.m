//
//  YACommandErrorCreator.m
//  altoids
//
//  Created by Jon Herron on 11/23/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YACommandErrorCreator.h"

// Private class extension
@interface YACommandErrorCreator ()

// @property definitions

// methods
- (NSString *)localizedDescriptionForErrorCode:(YACommandErrorCodes)theErrorCode;

@end

@implementation YACommandErrorCreator

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
#pragma mark CommandErrorCreator delegate methods

- (NSError *)errorWithCode:(YACommandErrorCodes)theErrorCode
{
    return [self errorWithCode:theErrorCode underlyingError:nil];
}

- (NSError *)errorWithCode:(YACommandErrorCodes)theErrorCode underlyingError:(NSError *)theUnderlyingError
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
#pragma mark YACommandErrorCreator ()

- (NSString *)localizedDescriptionForErrorCode:(YACommandErrorCodes)theErrorCode
{
    switch (theErrorCode) {
        case YACommandErrorCodeNilURLRequest:
            return YACommandErrorNilURLRequest;
        case YACommandErrorCodeNilParsedJSONResponse:
            return YACommandErrorNilParsedJSONResponse;
        case YACommandErrorCodeException:
            return YACommandErrorException;
        default:
            return nil;
    }
}

@end
