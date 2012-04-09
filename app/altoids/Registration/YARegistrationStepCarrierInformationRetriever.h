//
//  YARegistrationStepCarrierInformationRetriever.h
//  altoids
//
//  Created by Jon Herron on 9/13/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CarrierInformationCreator.h"
#import "RegistrationStepCarrierInformationRetriever.h"
#import "RegistrationStepDelegate.h"
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
@interface YARegistrationStepCarrierInformationRetriever : NSObject <RegistrationStepCarrierInformationRetriever>

#pragma mark @property declarations

#pragma mark  Class methods

#pragma mark Instance methods

- (id)initWithRegistrationTransientStateMutator:(id<RegistrationTransientStateMutator>)aRegistrationTransientStateMutator registrationTransientState:(YARegistrationTransientState *)aRegistrationTransientState carrierInformationCreator:(id<CarrierInformationCreator>)aCarrierInformationCreator delegate:(id<RegistrationStepDelegate>)aDelegate;

@end
