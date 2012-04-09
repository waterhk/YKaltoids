//
//  YAServerConfiguration.m
//  altoids
//
//  Created by Anand Subba Rao on 8/23/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAServerConfiguration.h"

// Private class extension
@interface YAServerConfiguration ()

// @property definitions

// methods

@end

@implementation YAServerConfiguration

// Class methods
#pragma mark -
#pragma mark Class methods

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize configurationHandler = configurationHandler_;

// Overrides
#pragma mark -
#pragma mark Overrides
- (NSString *)mmcServerHostname 
{
    return [[self configurationHandler] environmentSpecificStringForKey:kConfigKeyMMCServerHostname];
}

- (NSString *)registrationServer
{
    return [[self configurationHandler] environmentSpecificStringForKey:kConfigKeyRegistrationServerHostname];
}

- (NSString *)mmcServiceName
{
    // We need to know what's this is in altoids, maybe "mmc_altoids" ?
    return [[self configurationHandler] environmentSpecificStringForKey:kConfigKeyMMCServiceName];
}

// Delegate methods
#pragma mark -
#pragma mark <Protocol Name> delegate methods

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
#pragma mark YAServerConfiguration ()

@end
