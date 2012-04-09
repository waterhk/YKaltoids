//
//  YARegistrationStepCarrierErrorTests.m
//  altoids
//
//  Created by Jon Herron on 9/6/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <OCMock/OCMock.h>
#import "RegistrationStepDelegate.h"
#import "RegistrationTransientStateMutator.h"
#import "UIAlertViewFactory.h"
#import "YARegistrationStepCarrierError.h"
#import "YARegistrationTransientState.h"

@interface YARegistrationStepCarrierErrorTests : SenTestCase

@property (strong, nonatomic) id alertViewMock;
@property (strong, nonatomic) id registrationStepDelegateMock;
@property (strong, nonatomic) id registrationTransientStateMutatorMock;
@property (strong, nonatomic) id UIAlertViewFactoryMock;
@property (strong, nonatomic) id UIAlertViewSelectionDetectorMock;
@property (strong, nonatomic) YARegistrationStepCarrierError *registrationStepCarrierError;
@property (strong, nonatomic) YARegistrationTransientState *registrationTransientState;

@end

@implementation YARegistrationStepCarrierErrorTests

@synthesize alertViewMock = alertViewMock_;
@synthesize registrationStepDelegateMock = registrationStepDelegateMock_;
@synthesize registrationTransientStateMutatorMock = registrationTransientStateMutatorMock_;
@synthesize UIAlertViewFactoryMock = UIAlertViewFactoryMock_;
@synthesize UIAlertViewSelectionDetectorMock = UIAlertViewSelectionDetectorMock_;
@synthesize registrationStepCarrierError = registrationStepCarrierError_;
@synthesize registrationTransientState = registrationTransientState_;

- (void)testSetup
{
    [self setAlertViewMock:[OCMockObject mockForClass:[UIAlertView class]]];
    [self setRegistrationStepDelegateMock:[OCMockObject mockForProtocol:@protocol(RegistrationStepDelegate)]];
    [self setRegistrationTransientStateMutatorMock:[OCMockObject mockForProtocol:@protocol(RegistrationTransientStateMutator)]];
    [self setUIAlertViewFactoryMock:[OCMockObject mockForProtocol:@protocol(UIAlertViewFactory)]];
    [self setUIAlertViewSelectionDetectorMock:[OCMockObject mockForProtocol:@protocol(UIAlertViewSelectionDetector)]];
    
    [self setRegistrationTransientState:[[YARegistrationTransientState alloc] init]];
    
    [self setRegistrationStepCarrierError:[[YARegistrationStepCarrierError alloc] initWithRegistrationTransientStateMutator:[self registrationTransientStateMutatorMock] uiAlertViewFactory:[self UIAlertViewFactoryMock] uiAlertViewSelectionDetector:[self UIAlertViewSelectionDetectorMock] registrationTransientState:[self registrationTransientState] delegate:[self registrationStepDelegateMock]]];
}

- (void)testWhenExecuteIsCalledStepCreatesUIAlertViewWithAppropriateTitleMessageButtonsAndDelegateThenShowsTheAlertView
{
    [[[[self UIAlertViewFactoryMock] expect] andReturn:[self alertViewMock]] createWithTitle:REGISTRATION_STEP_CARRIER_ERROR_TITLE message:REGISTRATION_STEP_CARRIER_ERROR_MESSAGE delegate:[self registrationStepCarrierError] cancelButtonTitle:REGISTRATION_STEP_CARRIER_ERROR_CANCEL otherButtonTitles:[NSArray arrayWithObject:REGISTRATION_STEP_CARRIER_ERROR_RETRY]];
    
    [[self registrationStepCarrierError] execute];
    
    [[self UIAlertViewFactoryMock] verify];
}

- (void)testIfUserCancelsTheAlertViewTransientStateIsUpdatedToMarkRegistrationAsAborted
{
    NSInteger cancelButtonIndex = 0;
    
    [[[[self UIAlertViewSelectionDetectorMock] expect] andReturn:[NSNumber numberWithBool:YES]] clickedButtonIndex:cancelButtonIndex isCancelButtonIndexForUIAlertView:[self alertViewMock]];
    
    [[[self registrationTransientStateMutatorMock] expect] updateRegistrationTransientState:[self registrationTransientState] withRegistrationAborted:YES];
    
    [[[self registrationStepDelegateMock] stub] stepDidCompleteWithMutatedTransientState:[self registrationTransientState]];
    
    [[self registrationStepCarrierError] alertView:[self alertViewMock] clickedButtonAtIndex:cancelButtonIndex];
    
    [[self UIAlertViewSelectionDetectorMock] verify];
    [[self registrationTransientStateMutatorMock] verify];
}

- (void)testIfUserAcceptsTheAlertViewTransientStateIsUpdatedToMarkNeedForSMSVerificationIsNotAcknowledged
{
    NSInteger okButtonIndex = 0;
    
    [[[[self UIAlertViewSelectionDetectorMock] expect] andReturn:nil] clickedButtonIndex:okButtonIndex isCancelButtonIndexForUIAlertView:[self alertViewMock]];
    
    [[[self registrationTransientStateMutatorMock] expect] updateRegistrationTransientState:[self registrationTransientState] withCarrierIsSupported:nil];
    
    [[[self registrationStepDelegateMock] stub] stepDidCompleteWithMutatedTransientState:[self registrationTransientState]];
    
    [[self registrationStepCarrierError] alertView:[self alertViewMock] clickedButtonAtIndex:okButtonIndex];
    
    [[self UIAlertViewSelectionDetectorMock] verify];
    [[self registrationTransientStateMutatorMock] verify];
}

- (void)testWhenAlertViewIsClickedRegistrationStepDelegateIsCalledUpUpdatedTransientState
{
    NSInteger okButtonIndex = 0;
    
    [[[[self UIAlertViewSelectionDetectorMock] expect] andReturn:nil] clickedButtonIndex:okButtonIndex isCancelButtonIndexForUIAlertView:[self alertViewMock]];
    
    [[[self registrationStepDelegateMock] expect] stepDidCompleteWithMutatedTransientState:[self registrationTransientState]];
    
    [[self registrationStepCarrierError] alertView:[self alertViewMock] clickedButtonAtIndex:okButtonIndex];
    
    [[self registrationStepDelegateMock] verify];
    [[self UIAlertViewSelectionDetectorMock] verify];
}

@end
