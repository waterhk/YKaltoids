//
//  YARegistrationStepGetBindToken.m
//  altoids
//
//  Created by Jon Herron on 9/5/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YARegistrationStepBindTokenRetriever.h"

// Private class extension
@interface YARegistrationStepBindTokenRetriever ()

// @property definitions
@property (strong, nonatomic) id<RegistrationService> registrationService;
@property (strong, nonatomic) id<RegistrationStepDelegate> registrationStepDelegate;
@property (strong, nonatomic) id<RegistrationTransientStateMutator> registrationTransientStateMutator;
@property (strong, nonatomic) YARegistrationTransientState *registrationTransientState;

// methods

@end

@implementation YARegistrationStepBindTokenRetriever

// Class methods
#pragma mark -
#pragma mark Class methods

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)initWithRegistrationTransientStateMutator:(id<RegistrationTransientStateMutator>)aRegistrationTransientStateMutator registrationTransientState:(YARegistrationTransientState *)aRegistrationTransientState delegate:(id<RegistrationStepDelegate>)aDelegate registrationService:(id<RegistrationService>)aRegistrationService
{
  self = [super init];
    
  if (self) 
  {
      [self setRegistrationService:aRegistrationService];
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
@synthesize registrationService;
@synthesize registrationStepDelegate;
@synthesize registrationTransientState;
@synthesize registrationTransientStateMutator;

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark <RegistrationGetTokenDelegate> methods
- (void)didSendGetToken 
{
    
}

- (void)didFailWithError:(NSError *)error
{
    YARegistrationTransientState *transientState = [self registrationTransientState];
    [[self registrationTransientStateMutator] updateRegistrationTransientState:transientState withRegistrationFailed:YES];
    [[self registrationStepDelegate] stepDidCompleteWithMutatedTransientState:transientState];
}

- (void)didReceiveBindToken:(NSString *)bindToken shortCode:(NSString *)shortCode
{
    YARegistrationTransientState *transientState = [self registrationTransientState];
    [[self registrationTransientStateMutator] updateRegistrationTransientState:transientState withSMSShortCode:shortCode];
    [[self registrationTransientStateMutator] updateRegistrationTransientState:transientState withToken:bindToken];
    
    [[self registrationStepDelegate] stepDidCompleteWithMutatedTransientState:transientState];
}
// Public methods
#pragma mark -
#pragma mark Public methods

- (void)execute
{
    [[self registrationService] getTokenWithCountryCode:[[self registrationTransientState] mobileCountryCode]
                                            networkCode:[[self registrationTransientState] mobileNetworkCode]
                                           subscriberID:[[self registrationTransientState] mobileSubscriberId]
                                               delegate:self];
}

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YARegistrationStepGetBindToken ()

@end
