//
//  YARegistrationStepCarrierVerifier.m
//  altoids
//
//  Created by Jon Herron on 9/2/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YARegistrationStepCarrierVerifier.h"

#define kValidSMSShortCode @"92500"

// Private class extension
@interface YARegistrationStepCarrierVerifier ()

// @property definitions
@property (strong, nonatomic) id<RegistrationStepDelegate> registrationStepDelegate;
@property (strong, nonatomic) id<RegistrationTransientStateMutator> registrationTransientStateMutator;
@property (strong, nonatomic) YARegistrationTransientState *registrationTransientState;

// methods

@end

@implementation YARegistrationStepCarrierVerifier

// Class methods
#pragma mark -
#pragma mark Class methods

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)initWithRegistrationTransientStateMutator:(id<RegistrationTransientStateMutator>)aRegistrationTransientStateMutator registrationTransientState:(YARegistrationTransientState *)aRegistrationTransientState delegate:(id<RegistrationStepDelegate>)aDelegate
{
  self = [super init];
    
  if (self) 
  {
      [self setRegistrationTransientStateMutator:aRegistrationTransientStateMutator];
      [self setRegistrationTransientState:aRegistrationTransientState];
      [self setRegistrationStepDelegate:aDelegate];
  }
  
  return self;
}

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize registrationStepDelegate;
@synthesize registrationTransientState;
@synthesize registrationTransientStateMutator;

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark <RegistrationStep> delegate methods

- (void)execute
{
    BOOL smsShortCodeIsValid = [[[self registrationTransientState] smsShortCode] isEqualToString:kValidSMSShortCode];
    
    [[self registrationTransientStateMutator] updateRegistrationTransientState:[self registrationTransientState] withCarrierIsSupported:[NSNumber numberWithBool:smsShortCodeIsValid]];
    
    [[self registrationStepDelegate] stepDidCompleteWithMutatedTransientState:[self registrationTransientState]];
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
#pragma mark YARegistrationStepCarrierVerifier ()

@end
