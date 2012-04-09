//
//  YAAppConfiguration.m
//  altoids
//
//  Created by Anand Biligiri on 11/16/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAAppConfiguration.h"

// Private class extension
@interface YAAppConfiguration ()

// @property definitions

// methods

@end

@implementation YAAppConfiguration

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
#pragma mark AppConfiguration methods
- (BOOL)resetOnLaunch
{
    return [[self configurationHandler] boolForKey:kConfigKeyResetOnLaunch];
}

- (void)setResetOnLaunch:(BOOL)resetOnLaunch
{
    [[self configurationHandler] setBool:resetOnLaunch forKey:kConfigKeyResetOnLaunch];
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
#pragma mark YAAppConfiguration ()

@end
