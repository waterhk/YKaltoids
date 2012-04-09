//
//  YARegistrationStepCarrierVerifierTests.m
//  altoids
//
//  Created by Jon Herron on 9/14/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YARegistrationStepCarrierVerifierTests.h"
#import "RegistrationStepDelegate.h"
#import "RegistrationTransientStateMutator.h"
#import "YARegistrationStepCarrierVerifier.h"
#import "YARegistrationTransientState.h"
#import "YARegistrationTransientStateInternals.h"

#define kValidSMSShortCode @"92500"

@interface YARegistrationStepCarrierVerifierTests()

@property (strong, nonatomic) id registrationStepDelegateMock;
@property (strong, nonatomic) id registrationTransientStateMutatorMock;
@property (strong, nonatomic) YARegistrationStepCarrierVerifier *registrationStepCarrierVerifier;
@property (strong, nonatomic) YARegistrationTransientState *registrationTransientState;

@end

@implementation YARegistrationStepCarrierVerifierTests

@synthesize registrationStepDelegateMock = registrationStepDelegateMock_;
@synthesize registrationTransientStateMutatorMock = registrationTransientStateMutatorMock_;
@synthesize registrationStepCarrierVerifier = registrationStepCarrierVerifier_;
@synthesize registrationTransientState = registrationTransientState_;

- (void)setUp
{
    [self setRegistrationStepDelegateMock:[OCMockObject mockForProtocol:@protocol(RegistrationStepDelegate)]];
    [self setRegistrationTransientStateMutatorMock:[OCMockObject mockForProtocol:@protocol(RegistrationTransientStateMutator)]];
    [self setRegistrationTransientState:[[YARegistrationTransientState alloc] init]];
    [self setRegistrationStepCarrierVerifier:[[YARegistrationStepCarrierVerifier alloc] initWithRegistrationTransientStateMutator:[self registrationTransientStateMutatorMock] registrationTransientState:[self registrationTransientState] delegate:[self registrationStepDelegateMock]]];
}

- (void)testIfSMSShortCodeIsValidTransientStateIsUpdatedViaMutatorToSetCarrierIsSupportedToTrue
{
    [[self registrationTransientState] setSmsShortCode:kValidSMSShortCode];
    
    [[[self registrationTransientStateMutatorMock] expect] updateRegistrationTransientState:[self registrationTransientState] withCarrierIsSupported:[NSNumber numberWithBool:YES]];
    
    [[[self registrationStepDelegateMock] stub] stepDidCompleteWithMutatedTransientState:OCMOCK_ANY];
    
    [[self registrationStepCarrierVerifier] execute];
    
    [[self registrationTransientStateMutatorMock] verify];
}

- (void)testIfSMSShortCodeIsInvalidTransientStateIsUpdatedViaMutatorToSetCarrierIsSupportedToFalse
{
    [[self registrationTransientState] setSmsShortCode:@"Invalid Short Code"];
    
    [[[self registrationTransientStateMutatorMock] expect] updateRegistrationTransientState:[self registrationTransientState] withCarrierIsSupported:[NSNumber numberWithBool:NO]];
    
    [[[self registrationStepDelegateMock] stub] stepDidCompleteWithMutatedTransientState:OCMOCK_ANY];
    
    [[self registrationStepCarrierVerifier] execute];
    
    [[self registrationTransientStateMutatorMock] verify];
}

- (void)testStepNotifiesDelegateOnCompletionWithTransientState
{
    [[[self registrationTransientStateMutatorMock] stub] updateRegistrationTransientState:OCMOCK_ANY withCarrierIsSupported:OCMOCK_ANY];
    
    [[[self registrationStepDelegateMock] expect] stepDidCompleteWithMutatedTransientState:[self registrationTransientState]];
    
    [[self registrationStepCarrierVerifier] execute];
    
    [[self registrationStepDelegateMock] verify];

}

@end
