//
//  YARegistrationConfiguration.m
//  altoids
//
//  Created by Anand Subba Rao on 11/18/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YARegistrationConfiguration.h"

// Private class extension
@interface YARegistrationConfiguration ()

// @property definitions

// methods

@end

@implementation YARegistrationConfiguration

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize configurationHandler = configurationHandler_;

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
#pragma mark RegistrationConfiguration methods
- (NSString *)smsPrefix
{
    return [[self configurationHandler] environmentSpecificStringForKey:kConfigKeyRegistrationSMSPrefix];
}

- (BOOL)shouldSkipRegistrationSMS
{
    return [[self configurationHandler] boolForKey:kConfigKeyRegistrationSkipSMS];
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
#pragma mark YARegistrationConfiguration ()

@end
