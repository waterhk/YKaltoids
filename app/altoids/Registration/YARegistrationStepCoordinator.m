//
//  YARegistrationStepCoordinator.m
//  altoids
//
//  Created by Jon Herron on 9/2/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YARegistrationStepCoordinator.h"

// Private class extension
@interface YARegistrationStepCoordinator ()

// @property definitions
@property (strong, nonatomic) id<RegistrationStep> registrationStep;
@property (strong, nonatomic) id<RegistrationStepCoordinatorDelegate> registrationStepCoordinatorDelegate;
@property (strong, nonatomic) id<RegistrationStepSelector> registrationStepSelector;
@property (strong, nonatomic) id<RegistrationTransientStateMutator> registrationTransientStateMutator;

// methods
- (void)executeRegistrationStepBasedOnTransientState:(YARegistrationTransientState *)aRegistrationTransientState;

@end

@implementation YARegistrationStepCoordinator

// Class methods
#pragma mark -
#pragma mark Class methods

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)initWithRegistrationStepSelector:(id<RegistrationStepSelector>)aRegistrationStepSelector registrationTransientStateMutator:(id<RegistrationTransientStateMutator>)aRegistrationTransientStateMutator delegate:(id<RegistrationStepCoordinatorDelegate>)aDelegate

{
  self = [super init];
    
  if (self) 
  {
      [self setRegistrationStep:nil];
      [self setRegistrationStepSelector:aRegistrationStepSelector];
      [self setRegistrationTransientStateMutator:aRegistrationTransientStateMutator];
      [self setRegistrationStepCoordinatorDelegate:aDelegate];
  }
  
  return self;
}

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize registrationStep;
@synthesize registrationStepCoordinatorDelegate;
@synthesize registrationStepSelector;
@synthesize registrationTransientStateMutator;

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark <RegistrationStepDelegate> delegate methods

- (void)stepDidCompleteWithMutatedTransientState:(YARegistrationTransientState *)aRegistrationTransientState
{
    if ([aRegistrationTransientState registrationCompleted])
    {
        YALogTrace(@"Registration completed with state : %@\n", aRegistrationTransientState);
        [[self registrationStepCoordinatorDelegate] registrationDidCompleteWithPhoneNumber:[aRegistrationTransientState phoneNumber]
                                                                                 bindToken:[aRegistrationTransientState token]
                                                                            expirationDate:[aRegistrationTransientState expirationDate]];
    }
    else if ([aRegistrationTransientState registrationAborted] || [aRegistrationTransientState registrationFailed])
    {
        [[self registrationStepCoordinatorDelegate] registrationDidFail];
    }
    else
    {
        [self executeRegistrationStepBasedOnTransientState:aRegistrationTransientState];
    }
}

// Public methods
#pragma mark -
#pragma mark Public methods

- (void)performRegistrationFromCurrentViewController:(id<ViewControllerAccessor>)aViewControllerAccessor
{
    YARegistrationTransientState *registrationTransientState = [[YARegistrationTransientState alloc] init];
    
    [[self registrationTransientStateMutator] updateRegistrationTransientState:registrationTransientState withCurrentViewControllerAccessor:aViewControllerAccessor];
    
    [self executeRegistrationStepBasedOnTransientState:registrationTransientState];
}

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YARegistrationStepCoordinator ()

- (void)executeRegistrationStepBasedOnTransientState:(YARegistrationTransientState *)aRegistrationTransientState
{
    [self setRegistrationStep:[[self registrationStepSelector] registrationStepBasedOnTransientState:aRegistrationTransientState delegate:self]];
    
    YALogTrace(@"About to execute step = %@ with state = %@", [self registrationStep], aRegistrationTransientState);
    [[self registrationStep] execute];
}

@end
