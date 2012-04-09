//
//  YARegistrationStepTokenVerifier.h
//  altoids
//
//  Created by Jon Herron on 9/1/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegistrationStepTokenVerifier.h"
#import "ViewControllerAccessor.h"
#import "RegistrationVerifyTokenDelegate.h"
#import "RegistrationService.h"
#import "RegistrationTransientStateMutator.h"
#import "RegistrationStepDelegate.h"
#import "UIAlertViewFactory.h"
#import "UIAlertViewDismisser.h"

@protocol ActivityIndicatorOverlayInstanceFactory;

@interface YARegistrationStepTokenVerifier : NSObject <RegistrationStepTokenVerifier, RegistrationVerifyTokenDelegate, UIAlertViewDelegate>

- (id)initWithRegistrationTransientStateMutator:(id<RegistrationTransientStateMutator>)registrationTransientStateMutator
                     registrationTransientState:(YARegistrationTransientState *)aTransientState
        activityIndicatorOverlayInstanceFactory:(id<ActivityIndicatorOverlayInstanceFactory>)activityIndicatorOverlayInstanceFactory
                          currentViewController:(id<ViewControllerAccessor>)aCurrentViewController
                            registrationService:(id<RegistrationService>)aRegistrationService
                                       delegate:(id<RegistrationStepDelegate>)aRegistrationStepDelegate;

@end
