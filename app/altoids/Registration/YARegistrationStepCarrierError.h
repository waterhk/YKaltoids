//
//  YARegistrationStepCarrierError.h
//  altoids
//
//  Created by Jon Herron on 9/1/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegistrationStepDelegate.h"
#import "RegistrationStepCarrierError.h"
#import "RegistrationTransientStateMutator.h"
#import "UIAlertViewFactory.h"
#import "UIAlertViewSelectionDetector.h"

// #define
#pragma mark #defines
#define REGISTRATION_STEP_CARRIER_ERROR_TITLE     NSLocalizedString(@"", @"Carrier Error Alert Title")
#define REGISTRATION_STEP_CARRIER_ERROR_MESSAGE   NSLocalizedString(@"Sorry, your carrier is not supported. SMS not sent.", @"Carrier Error Alert Message")
#define REGISTRATION_STEP_CARRIER_ERROR_CANCEL    NSLocalizedString(@"Cancel", @"Carrier Error Alert Cancel Button Text")
#define REGISTRATION_STEP_CARRIER_ERROR_RETRY     NSLocalizedString(@"Retry", @"Carrier Error Alert Retry Button Text")


// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YARegistrationStepCarrierError : NSObject <RegistrationStepCarrierError, UIAlertViewDelegate>

#pragma mark @property declarations

#pragma mark  Class methods

#pragma mark Instance methods

- (id)initWithRegistrationTransientStateMutator:(id<RegistrationTransientStateMutator>)aRegistrationTransientStateMutator
                             uiAlertViewFactory:(id<UIAlertViewFactory>)aUIAlertViewFactory
                   uiAlertViewSelectionDetector:(id<UIAlertViewSelectionDetector>)aUIAlertViewSelectionDetector
                     registrationTransientState:(YARegistrationTransientState *)aRegistrationTransientState delegate:(id<RegistrationStepDelegate>)aDelegate;

@end
