//
//  YARegistrationStepCoordinatorFactory.h
//  altoids
//
//  Created by Jon Herron on 9/6/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegistrationStepCoordinatorFactory.h"
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
@interface YARegistrationStepCoordinatorFactory : NSObject <RegistrationStepCoordinatorFactory>

#pragma mark @property declarations
@property (strong, nonatomic) id<RegistrationStepSelector> registrationStepSelector;
@property (strong, nonatomic) id<RegistrationTransientStateMutator> registrationTransientStateMutator;

#pragma mark  Class methods

#pragma mark Instance methods

@end
