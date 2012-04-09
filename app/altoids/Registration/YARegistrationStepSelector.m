//
//  YARegistrationStepSelector.m
//  altoids
//
//  Created by Jon Herron on 9/2/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YARegistrationStepSelector.h"

// Private class extension
@interface YARegistrationStepSelector ()

// @property definitions

// methods


@end

@implementation YARegistrationStepSelector

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
@synthesize registrationStepFactory;

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark <Protocol Name> delegate methods

// Public methods
#pragma mark -
#pragma mark Public methods

- (id<RegistrationStep>)registrationStepBasedOnTransientState:(YARegistrationTransientState *)aTransientState delegate:(id<RegistrationStepDelegate>)aDelegate
{
    if ([aTransientState registrationAborted] || [aTransientState registrationCompleted]) 
    {
        return nil;
    }
    
    if ([aTransientState smsVerificationFailed]) 
    {
        // return sms verification failed step when implemented
        return nil;
    }
    
    if (![aTransientState mobileCountryCode] || ![aTransientState mobileNetworkCode])
    {
        return [[self registrationStepFactory] registrationStepCarrierInformationRetrieverWithTransientState:aTransientState delegate:aDelegate];
    }
    
    if (![aTransientState token])
    {
        return [[self registrationStepFactory] registrationStepBindTokenRetrieverWithTransientState:aTransientState delegate:aDelegate];
    }
    
    if ([aTransientState carrierIsSupported] == nil) 
    {
        return [[self registrationStepFactory] registrationStepCarrierVerifierWithTransientState:aTransientState delegate:aDelegate];
    }
    
    if ([[aTransientState carrierIsSupported] boolValue] != YES) 
    {
        return [[self registrationStepFactory] registrationStepCarrierErrorWithTransientState:aTransientState delegate:aDelegate];
    }
        
    if ([aTransientState token] && ![aTransientState verificationSmsSent]) 
    {
        return [[self registrationStepFactory] registrationStepSMSSenderWithTransientState:aTransientState delegate:aDelegate];
    }
    
    if ([aTransientState token] && [aTransientState verificationSmsSent] && ![aTransientState tokenHasBeenValidated]) 
    {
        return [[self registrationStepFactory] registrationStepTokenVerifierWithTransientState:aTransientState delegate:aDelegate];
    }
    
    if ([aTransientState token] && [aTransientState tokenHasBeenValidated]) 
    {
        // congrats
    }

    return nil;
}

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YARegistrationStepSelector ()

@end
