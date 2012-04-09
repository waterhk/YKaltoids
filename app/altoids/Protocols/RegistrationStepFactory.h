//
//  RegistrationStepFactory.h
//  altoids
//
//  Created by Jon Herron on 9/2/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegistrationStepDelegate.h"
#import "RegistrationStepCarrierError.h"
#import "RegistrationStepCarrierInformationRetriever.h"
#import "RegistrationStepCarrierVerifier.h"
#import "RegistrationStepBindTokenRetriever.h"
#import "RegistrationStepSMSSender.h"
#import "RegistrationStepSMSVerifier.h"
#import "RegistrationStepTokenVerifier.h"
#import "ViewControllerAccessor.h"

@protocol RegistrationStepFactory <NSObject>

#pragma mark -
#pragma mark @required
@required

- (id<RegistrationStepCarrierError>)registrationStepCarrierErrorWithTransientState:(YARegistrationTransientState *)aRegistrationTransientState delegate:(id<RegistrationStepDelegate>)aDelegate;

- (id<RegistrationStepCarrierInformationRetriever>)registrationStepCarrierInformationRetrieverWithTransientState:(YARegistrationTransientState *)aRegistrationTransientState delegate:(id<RegistrationStepDelegate>)aDelegate;

- (id<RegistrationStepCarrierVerifier>)registrationStepCarrierVerifierWithTransientState:(YARegistrationTransientState *)aRegistrationTransientState delegate:(id<RegistrationStepDelegate>)aDelegate;

- (id<RegistrationStepBindTokenRetriever>)registrationStepBindTokenRetrieverWithTransientState:(YARegistrationTransientState *)aRegistrationTransientState delegate:(id<RegistrationStepDelegate>)aDelegate;

- (id<RegistrationStepSMSSender>)registrationStepSMSSenderWithTransientState:(YARegistrationTransientState *)aRegistrationTransientState delegate:(id<RegistrationStepDelegate>)aDelegate;

- (id<RegistrationStepTokenVerifier>)registrationStepTokenVerifierWithTransientState:(YARegistrationTransientState *)aRegistrationTransientState delegate:(id<RegistrationStepDelegate>)aDelegate;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
