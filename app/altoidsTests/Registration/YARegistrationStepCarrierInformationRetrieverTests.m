//
//  YARegistrationStepCarrierInformationRetrieverTests.m
//  altoids
//
//  Created by Jon Herron on 9/13/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YARegistrationStepCarrierInformationRetrieverTests.h"
#import <CoreTelephony/CTCarrier.h>
#import <OCMock/OCMock.h>

@interface YARegistrationStepCarrierInformationRetrieverTests()

@property (strong, nonatomic) id carrierInformationMock;
@property (strong, nonatomic) id carrierInformationCreatorMock;
@property (strong, nonatomic) id registrationStepDelegateMock;
@property (strong, nonatomic) id registrationTransientStateMutatorMock;

@property (strong, nonatomic) YARegistrationStepCarrierInformationRetriever *registrationStepCarrierInformationRetriever;
@property (strong, nonatomic) YARegistrationTransientState *registrationTransientState;

@end

@implementation YARegistrationStepCarrierInformationRetrieverTests

@synthesize carrierInformationMock = carrierInformationMock_;
@synthesize carrierInformationCreatorMock = carrierInformationCreatorMock_;
@synthesize registrationStepDelegateMock = registrationStepDelegateMock_;
@synthesize registrationTransientStateMutatorMock = registrationTransientStateMutatorMock_;
@synthesize registrationStepCarrierInformationRetriever = registrationStepCarrierInformationRetriever_;
@synthesize registrationTransientState = registrationTransientState_;

- (void)setUp
{
    [self setCarrierInformationMock:[OCMockObject mockForClass:[CTCarrier class]]];
    [self setCarrierInformationCreatorMock:[OCMockObject mockForProtocol:@protocol(CarrierInformationCreator)]];
    [self setRegistrationStepDelegateMock:[OCMockObject mockForProtocol:@protocol(RegistrationStepDelegate)]];
    [self setRegistrationTransientStateMutatorMock:[OCMockObject mockForProtocol:@protocol(RegistrationTransientStateMutator)]];
    
    [self setRegistrationTransientState:[[YARegistrationTransientState alloc] init]];
    [self setRegistrationStepCarrierInformationRetriever:[[YARegistrationStepCarrierInformationRetriever alloc] initWithRegistrationTransientStateMutator:[self registrationTransientStateMutatorMock] registrationTransientState:[self registrationTransientState] carrierInformationCreator:[self carrierInformationCreatorMock] delegate:[self registrationStepDelegateMock]]];
}

- (void)testUsesCarrierInformationCreatorToManufactureCTCarrierInstance
{
    [[[self carrierInformationCreatorMock] expect] carrierInformation];
    
    [[[self registrationTransientStateMutatorMock] stub] updateRegistrationTransientState:OCMOCK_ANY withMobileNetworkCode:OCMOCK_ANY];
    [[[self registrationTransientStateMutatorMock] stub] updateRegistrationTransientState:OCMOCK_ANY withMobileCountryCode:OCMOCK_ANY];
    [[[self registrationStepDelegateMock] stub] stepDidCompleteWithMutatedTransientState:OCMOCK_ANY];
    
    [[self registrationStepCarrierInformationRetriever] execute];
    
    [[self carrierInformationCreatorMock] verify];
}

- (void)testUpdatesTransientStateViaMutatorWithMobileNetworkAndCountryCodeFromCarrierInformation
{
    NSString *mobileCountryCode = @"Mobile Country Code";
    NSString *mobileNetworkCode = @"Mobile Network Code";
    
    [[[[self carrierInformationMock] expect] andReturn:mobileCountryCode] mobileCountryCode];
    [[[[self carrierInformationMock] expect] andReturn:mobileNetworkCode] mobileNetworkCode];
    
    [[[[self carrierInformationCreatorMock] stub] andReturn:[self carrierInformationMock]] carrierInformation];
    
    [[[self registrationTransientStateMutatorMock] expect] updateRegistrationTransientState:[self registrationTransientState] withMobileCountryCode:mobileCountryCode];
    [[[self registrationTransientStateMutatorMock] expect] updateRegistrationTransientState:[self registrationTransientState] withMobileNetworkCode:mobileNetworkCode];
    
    [[[self registrationStepDelegateMock] stub] stepDidCompleteWithMutatedTransientState:OCMOCK_ANY];
    
    [[self registrationStepCarrierInformationRetriever] execute];
    
    [[self carrierInformationMock] verify];
    [[self registrationStepDelegateMock] verify];
}

- (void)testNotifiesDelegateThatStepIsCompleteWithTransientState
{
    [[[self carrierInformationCreatorMock] stub] carrierInformation];
    
    [[[self registrationTransientStateMutatorMock] stub] updateRegistrationTransientState:OCMOCK_ANY withMobileNetworkCode:OCMOCK_ANY];
    [[[self registrationTransientStateMutatorMock] stub] updateRegistrationTransientState:OCMOCK_ANY withMobileCountryCode:OCMOCK_ANY];
    
    [[[self registrationStepDelegateMock] expect] stepDidCompleteWithMutatedTransientState:[self registrationTransientState]];
    
    [[self registrationStepCarrierInformationRetriever] execute];
    
    [[self registrationStepDelegateMock] verify];
}

@end
