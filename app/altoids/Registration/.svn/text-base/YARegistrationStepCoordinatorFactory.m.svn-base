//
//  YARegistrationStepCoordinatorFactory.m
//  altoids
//
//  Created by Jon Herron on 9/6/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YARegistrationStepCoordinatorFactory.h"
#import "YARegistrationStepCoordinator.h"

// Private class extension
@interface YARegistrationStepCoordinatorFactory ()

// @property definitions

// methods

@end

@implementation YARegistrationStepCoordinatorFactory

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
@synthesize registrationStepSelector;
@synthesize registrationTransientStateMutator;

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark <Protocol Name> delegate methods

// Public methods
#pragma mark -
#pragma mark Public methods

- (id<RegistrationStepCoordinator>)registrationStepCoordinatorWithDelegate:(id<RegistrationStepCoordinatorDelegate>)aDelegate
{
    return [[YARegistrationStepCoordinator alloc] initWithRegistrationStepSelector:[self registrationStepSelector] registrationTransientStateMutator:[self registrationTransientStateMutator] delegate:aDelegate];
}

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YARegistrationStepCoordinatorFactory ()

@end
