//
//  YARegistrationStepCarrierVerifier.h
//  altoids
//
//  Created by Jon Herron on 9/2/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegistrationStepCarrierVerifier.h"
#import "RegistrationTransientStateMutator.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YARegistrationStepCarrierVerifier : NSObject <RegistrationStepCarrierVerifier>

#pragma mark @property declarations

#pragma mark  Class methods

#pragma mark Instance methods

- (id)initWithRegistrationTransientStateMutator:(id<RegistrationTransientStateMutator>)aRegistrationTransientStateMutator
                     registrationTransientState:(YARegistrationTransientState *)aRegistrationTransientState delegate:(id<RegistrationStepDelegate>)aDelegate;

@end
