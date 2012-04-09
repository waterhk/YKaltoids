//
//  YARegistrationStepSMSSender.h
//  altoids
//
//  Created by Jon Herron on 9/1/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import "RegistrationConfiguration.h"
#import "RegistrationStepDelegate.h"
#import "RegistrationStepSMSSender.h"
#import "RegistrationTransientStateMutator.h"
#import "ViewControllerAccessor.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YARegistrationStepSMSSender : NSObject <RegistrationStepSMSSender, MFMessageComposeViewControllerDelegate>

#pragma mark @property declarations

#pragma mark  Class methods

#pragma mark Instance methods

- (id)initWithRegistrationTransientStateMutator:(id<RegistrationTransientStateMutator>)aRegistrationTransientStateMutator
                     registrationTransientState:(YARegistrationTransientState *)aRegistrationTransientState delegate:(id<RegistrationStepDelegate>)aDelegate
                      registrationConfiguration:(id<RegistrationConfiguration>)registrationConfiguration;

@end
