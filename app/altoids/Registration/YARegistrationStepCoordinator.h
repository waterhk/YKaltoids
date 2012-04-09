//
//  YARegistrationStepCoordinator.h
//  altoids
//
//  Created by Jon Herron on 9/2/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegistrationStepCoordinator.h"
#import "RegistrationStep.h"
#import "RegistrationStepDelegate.h"
#import "RegistrationStepSelector.h"
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
@interface YARegistrationStepCoordinator : NSObject <RegistrationStepCoordinator, RegistrationStepDelegate>

#pragma mark @property declarations

#pragma mark  Class methods

#pragma mark Instance methods

- (id)initWithRegistrationStepSelector:(id<RegistrationStepSelector>)aRegistrationStepSelector
     registrationTransientStateMutator:(id<RegistrationTransientStateMutator>)aRegistrationTransientStateMutator
                              delegate:(id<RegistrationStepCoordinatorDelegate>)aDelegate;

@end
