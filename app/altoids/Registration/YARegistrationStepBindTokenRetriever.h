//
//  YARegistrationStepGetBindToken.h
//  altoids
//
//  Created by Jon Herron on 9/5/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegistrationService.h"
#import "RegistrationStepBindTokenRetriever.h"
#import "RegistrationTransientStateMutator.h"
#import "RegistrationTokenRetrieverDelegate.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YARegistrationStepBindTokenRetriever : NSObject <RegistrationStepBindTokenRetriever, RegistrationTokenRetrieverDelegate>

#pragma mark @property declarations

#pragma mark  Class methods

#pragma mark Instance methods

- (id)initWithRegistrationTransientStateMutator:(id<RegistrationTransientStateMutator>)aRegistrationTransientStateMutator
                     registrationTransientState:(YARegistrationTransientState *)aRegistrationTransientState
                                       delegate:(id<RegistrationStepDelegate>)aDelegate
                            registrationService:(id<RegistrationService>)aRegistrationService;

@end
