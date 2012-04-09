//
//  YARegistrationStepSelectorTests.m
//  altoids
//
//  Created by Jon Herron on 9/6/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <OCMock/OCMock.h>
#import "RegistrationStep.h"
#import "RegistrationStepDelegate.h"
#import "RegistrationStepFactory.h"
#import "YARegistrationTransientStateInternals.h"
#import "YARegistrationStepSelector.h"
#import "YARegistrationTransientState.h"

@interface YARegistrationStepSelectorTests : SenTestCase

@property (strong, nonatomic) id registrationStepMock;
@property (strong, nonatomic) id registrationStepDelegateMock;
@property (strong, nonatomic) id registrationStepFactoryMock;
@property (strong, nonatomic) YARegistrationStepSelector *registrationStepSelector;
@property (strong, nonatomic) YARegistrationTransientState *registrationTransientState;

@end

@implementation YARegistrationStepSelectorTests

@synthesize registrationStepMock = registrationStepMock_;
@synthesize registrationStepDelegateMock = registrationStepDelegateMock_;
@synthesize registrationStepFactoryMock = registrationStepFactoryMock_;
@synthesize registrationStepSelector = registrationStepSelector_;
@synthesize registrationTransientState = registrationTransientState_;

- (void)setUp
{
    [self setRegistrationStepMock:[OCMockObject mockForProtocol:@protocol(RegistrationStep)]];
    [self setRegistrationStepDelegateMock:[OCMockObject mockForProtocol:@protocol(RegistrationStepDelegate)]];
    [self setRegistrationStepFactoryMock:[OCMockObject mockForProtocol:@protocol(RegistrationStepFactory)]];
    
    [self setRegistrationStepSelector:[[YARegistrationStepSelector alloc] init]];
    [[self registrationStepSelector] setRegistrationStepFactory:[self registrationStepFactoryMock]];
    
    [self setRegistrationTransientState:[[YARegistrationTransientState alloc] init]];
}

- (void)testWithInitialTransientStateCarrierInformationStepIsReturnedViaFactory
{
    id<RegistrationStep> returnedStep = nil;
    
    [[[[self registrationStepFactoryMock] expect] andReturn:[self registrationStepMock]] registrationStepCarrierInformationRetrieverWithTransientState:[self registrationTransientState] delegate:[self registrationStepDelegateMock]];
    
    returnedStep = [[self registrationStepSelector] registrationStepBasedOnTransientState:[self registrationTransientState] delegate:[self registrationStepDelegateMock]];
    
    [[self registrationStepFactoryMock] verify];
    
    STAssertNotNil(returnedStep, @"Unexpected nil step");
    STAssertEquals([self registrationStepMock], returnedStep, @"Unexpected step returned from factory");
}

- (void)testIfRegistrationWasAbortedNilIsReturned
{
    [[self registrationTransientState] setRegistrationAborted:YES];
    
    STAssertNil([[self registrationStepSelector] registrationStepBasedOnTransientState:[self registrationTransientState] delegate:[self registrationStepDelegateMock]], @"Expected nil step returned");
}

- (void)testIfRegistrationWasCompletedNilIsReturned
{
    [[self registrationTransientState] setRegistrationCompleted:YES];
    
    STAssertNil([[self registrationStepSelector] registrationStepBasedOnTransientState:[self registrationTransientState] delegate:[self registrationStepDelegateMock]], @"Expected nil step returned");
}

- (void)testIfSMSVerificationFailedSMSVerificationFailedAlertIsReturnedViaFactory
{
    // not implemented yet
}

- (void)testIfCarrierInformationHasNotBeenRetrievedCarrierInformationRetrieverStepIsReturnedFromFactory
{
    id<RegistrationStep> returnedStep = nil;
    
    [[[[self registrationStepFactoryMock] expect] andReturn:[self registrationStepMock]] registrationStepCarrierInformationRetrieverWithTransientState:[self registrationTransientState] delegate:[self registrationStepDelegateMock]];
    
    returnedStep = [[self registrationStepSelector] registrationStepBasedOnTransientState:[self registrationTransientState] delegate:[self registrationStepDelegateMock]];
    
    [[self registrationStepFactoryMock] verify];
    
    STAssertNotNil(returnedStep, @"Unexpected nil step");
    STAssertEquals([self registrationStepMock], returnedStep, @"Unexpected step returned from factory");
}

- (void)testIfCarrierInformationHasBeenRetrievedAndNoBindTokenExistsBindTokenRetrieverStepIsReturnedViaFactory
{
    id<RegistrationStep> returnedStep = nil;
    
    [[self registrationTransientState] setMobileNetworkCode:@"MNC"];
    [[self registrationTransientState] setMobileCountryCode:@"MCC"];
    
    [[[[self registrationStepFactoryMock] expect] andReturn:[self registrationStepMock]] registrationStepBindTokenRetrieverWithTransientState:[self registrationTransientState] delegate:[self registrationStepDelegateMock]];
    
    returnedStep = [[self registrationStepSelector] registrationStepBasedOnTransientState:[self registrationTransientState] delegate:[self registrationStepDelegateMock]];
    
    [[self registrationStepFactoryMock] verify];
    
    STAssertNotNil(returnedStep, @"Unexpected nil step");
    STAssertEquals([self registrationStepMock], returnedStep, @"Unexpected step returned from factory");
}

- (void)testIfBindTokenHasBeenRetrievedAndCarrierIsSupportedIsNilCarrierVerificationStepIsReturnedViaFactory
{
    id<RegistrationStep> returnedStep = nil;
    
    [[self registrationTransientState] setMobileNetworkCode:@"MNC"];
    [[self registrationTransientState] setMobileCountryCode:@"MCC"];
    [[self registrationTransientState] setToken:@"Token"];
    
    [[[[self registrationStepFactoryMock] expect] andReturn:[self registrationStepMock]] registrationStepCarrierVerifierWithTransientState:[self registrationTransientState] delegate:[self registrationStepDelegateMock]];
    
    returnedStep = [[self registrationStepSelector] registrationStepBasedOnTransientState:[self registrationTransientState] delegate:[self registrationStepDelegateMock]];
    
    [[self registrationStepFactoryMock] verify];
    
    STAssertNotNil(returnedStep, @"Unexpected nil step");
    STAssertEquals([self registrationStepMock], returnedStep, @"Unexpected step returned from factory");}

- (void)testIfCarrierIsUnsupportedCarrierErrorAlertStepIsReturnedViaFactory
{
     id<RegistrationStep> returnedStep = nil;
     
     [[self registrationTransientState] setMobileNetworkCode:@"MNC"];
     [[self registrationTransientState] setMobileCountryCode:@"MCC"];
     [[self registrationTransientState] setToken:@"Token"];
     [[self registrationTransientState] setCarrierIsSupported:[NSNumber numberWithBool:NO]];
     
     [[[[self registrationStepFactoryMock] expect] andReturn:[self registrationStepMock]] registrationStepCarrierErrorWithTransientState:[self registrationTransientState] delegate:[self registrationStepDelegateMock]];
     
     returnedStep = [[self registrationStepSelector] registrationStepBasedOnTransientState:[self registrationTransientState] delegate:[self registrationStepDelegateMock]];
     
     [[self registrationStepFactoryMock] verify];
     
     STAssertNotNil(returnedStep, @"Unexpected nil step");
     STAssertEquals([self registrationStepMock], returnedStep, @"Unexpected step returned from factory");
}

- (void)testIfBindTokenExistsButNoPhoneNumberSendSMSStepIsReturnedViaFactory
{
    id<RegistrationStep> returnedStep = nil;
    
    [[self registrationTransientState] setMobileNetworkCode:@"MNC"];
    [[self registrationTransientState] setMobileCountryCode:@"MCC"];
    [[self registrationTransientState] setCarrierIsSupported:[NSNumber numberWithBool:YES]];
    [[self registrationTransientState] setToken:@"A Bind Token"];
    
    [[[[self registrationStepFactoryMock] expect] andReturn:[self registrationStepMock]] registrationStepSMSSenderWithTransientState:[self registrationTransientState] delegate:[self registrationStepDelegateMock]];
    
    returnedStep = [[self registrationStepSelector] registrationStepBasedOnTransientState:[self registrationTransientState] delegate:[self registrationStepDelegateMock]];
    
    [[self registrationStepFactoryMock] verify];
    
    STAssertNotNil(returnedStep, @"Unexpected nil step");
    STAssertEquals([self registrationStepMock], returnedStep, @"Unexpected step returned from factory");
}

@end
