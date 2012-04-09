//
//  YAErrorCreator.m
//  altoids
//
//  Created by Jon Herron on 11/11/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAErrorCreator.h"

#define kUserInfoCapacity 2

// Private class extension
@interface YAErrorCreator ()

// @property definitions

// methods

@end

@implementation YAErrorCreator

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize mutableDictionaryCreator = mutableDictionaryCreator_;

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
#pragma mark ErrorCreator delegate methods

- (NSError *)errorFromError:(NSError *)theError withUnderlyingError:(NSError *)theUnderlyingError
{
    NSParameterAssert(theError);
    
    if (!theUnderlyingError) 
    {
        return theError;
    }
    
    NSError *error;
    NSMutableDictionary *userInfo = [[self mutableDictionaryCreator] mutableDictionaryWithDictionary:[theError userInfo]];
    
    [userInfo setObject:theUnderlyingError forKey:NSUnderlyingErrorKey];
    
    error = [NSError errorWithDomain:[theError domain] code:[theError code] userInfo:userInfo];
    
    return error;
}

- (NSError *)errorWithDomain:(NSString *)theErrorDomain code:(NSInteger)theErrorCode localizedDescription:(NSString *)theLocalizedDescription underlyingError:(NSError *)theUnderlyingError
{
    NSParameterAssert(theErrorDomain);
    NSParameterAssert(theLocalizedDescription);
    
    NSMutableDictionary *userInfo;
    NSError *error;
    
    userInfo = [[self mutableDictionaryCreator] mutableDictionaryWithCapacity:kUserInfoCapacity];
    
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
#pragma mark YAErrorCreator ()

@end
