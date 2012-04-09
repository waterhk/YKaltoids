//
//  YARegistrationStepFactory.m
//  altoids
//
//  Created by Jon Herron on 9/2/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YARegistrationStepFactory.h"
#import "YARegistrationStepCarrierError.h"
#import "YARegistrationStepCarrierInformationRetriever.h"
#import "YARegistrationStepCarrierVerifier.h"
#import "YARegistrationStepBindTokenRetriever.h"
#import "YARegistrationStepSMSSender.h"
#import "YARegistrationStepTokenVerifier.h"
#import "YAAppFactory.h"

@interface YARegistrationStepFactory ()

@end

@implementation YARegistrationStepFactory

@synthesize UIAlertViewFactory;
@synthesize UIAlertViewSelectionDetector;
@synthesize UIAlertViewDismisser;
@synthesize registrationTransientStateMutator;
@synthesize registrationService;
@synthesize carrierInformationCreator;
@synthesize registrationConfiguration = registrationConfiguration_;
@synthesize activityIndicatorOverlayInstanceFactory = activityIndicatorOverlayInstanceFactory_;

- (id<RegistrationStepCarrierError>)registrationStepCarrierErrorWithTransientState:(YARegistrationTransientState *)aRegistrationTransientState
                                                                          delegate:(id<RegistrationStepDelegate>)aDelegate
{
    return [[YARegistrationStepCarrierError alloc] initWithRegistrationTransientStateMutator:[self registrationTransientStateMutator]
                                                                          uiAlertViewFactory:[self UIAlertViewFactory]
                                                                uiAlertViewSelectionDetector:[self UIAlertViewSelectionDetector]
                                                                  registrationTransientState:aRegistrationTransientState delegate:aDelegate];
}

- (id<RegistrationStepCarrierInformationRetriever>)registrationStepCarrierInformationRetrieverWithTransientState:(YARegistrationTransientState *)aRegistrationTransientState delegate:(id<RegistrationStepDelegate>)aDelegate
{
    return [[YARegistrationStepCarrierInformationRetriever alloc] initWithRegistrationTransientStateMutator:[self registrationTransientStateMutator] registrationTransientState:aRegistrationTransientState carrierInformationCreator:[self carrierInformationCreator] delegate:aDelegate];
}

- (id<RegistrationStepCarrierVerifier>)registrationStepCarrierVerifierWithTransientState:(YARegistrationTransientState *)aRegistrationTransientState
                                                                                delegate:(id<RegistrationStepDelegate>)aDelegate
{
    return [[YARegistrationStepCarrierVerifier alloc] initWithRegistrationTransientStateMutator:[self registrationTransientStateMutator]
                                                                     registrationTransientState:aRegistrationTransientState delegate:aDelegate];
}

- (id<RegistrationStepBindTokenRetriever>)registrationStepBindTokenRetrieverWithTransientState:(YARegistrationTransientState *)aRegistrationTransientState
                                                                          delegate:(id<RegistrationStepDelegate>)aDelegate
{
    return [[YARegistrationStepBindTokenRetriever alloc] initWithRegistrationTransientStateMutator:[self registrationTransientStateMutator]
                                                                  registrationTransientState:aRegistrationTransientState delegate:aDelegate
                                                                         registrationService:[self registrationService]];
}

- (id<RegistrationStepSMSSender>)registrationStepSMSSenderWithTransientState:(YARegistrationTransientState *)aRegistrationTransientState
                                                                    delegate:(id<RegistrationStepDelegate>)aDelegate
{
    return [[YARegistrationStepSMSSender alloc] initWithRegistrationTransientStateMutator:[self registrationTransientStateMutator]
                                                               registrationTransientState:aRegistrationTransientState delegate:aDelegate
                                                                registrationConfiguration:[self registrationConfiguration]];
}

- (id<RegistrationStepTokenVerifier>)registrationStepTokenVerifierWithTransientState:(YARegistrationTransientState *)aRegistrationTransientState
                                                                            delegate:(id<RegistrationStepDelegate>)aDelegate
{
    return [[YARegistrationStepTokenVerifier alloc] initWithRegistrationTransientStateMutator:[self registrationTransientStateMutator]
                                                                   registrationTransientState:aRegistrationTransientState
                                                      activityIndicatorOverlayInstanceFactory:activityIndicatorOverlayInstanceFactory_ 
                                                                        currentViewController:[aRegistrationTransientState currentViewControllerAccessor]
                                                                          registrationService:[self registrationService]
                                                                                     delegate:aDelegate];
}

@end
