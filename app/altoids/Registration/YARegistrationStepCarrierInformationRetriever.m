//
//  YARegistrationStepCarrierInformationRetriever.m
//  altoids
//
//  Created by Jon Herron on 9/13/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YARegistrationStepCarrierInformationRetriever.h"
#import "YACarrierInformation.h"

// Private class extension
@interface YARegistrationStepCarrierInformationRetriever ()

// @property definitions
@property (strong, nonatomic) id<CarrierInformationCreator> carrierInformationCreator;
@property (strong, nonatomic) id<RegistrationStepDelegate> registrationStepDelegate;
@property (strong, nonatomic) id<RegistrationTransientStateMutator> registrationTransientStateMutator;
@property (strong, nonatomic) YARegistrationTransientState *registrationTransientState;

// methods

@end

@implementation YARegistrationStepCarrierInformationRetriever

// Class methods
#pragma mark -
#pragma mark Class methods

// Designated initializer
#pragma mark -
#pragma mark Designated initializer


- (id)initWithRegistrationTransientStateMutator:(id<RegistrationTransientStateMutator>)aRegistrationTransientStateMutator registrationTransientState:(YARegistrationTransientState *)aRegistrationTransientState carrierInformationCreator:(id<CarrierInformationCreator>)aCarrierInformationCreator delegate:(id<RegistrationStepDelegate>)aDelegate
{
  self = [super init];
    
  if (self) 
  {
      [self setCarrierInformationCreator:aCarrierInformationCreator];
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
@synthesize carrierInformationCreator;
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
    YACarrierInformation *carrierInformation = [[self carrierInformationCreator] carrierInformation];
    
    [[self registrationTransientStateMutator] updateRegistrationTransientState:[self registrationTransientState] withMobileNetworkCode:[carrierInformation mobileNetworkCode]];
    
    [[self registrationTransientStateMutator] updateRegistrationTransientState:[self registrationTransientState] withMobileCountryCode:[carrierInformation mobileCountryCode]];
    
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
#pragma mark YARegistrationStepCarrierInformationRetriever ()

@end
