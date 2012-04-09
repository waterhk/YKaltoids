//
//  YARegistrationErrorCreatorTests.m
//  altoids
//
//  Created by Jon Herron on 11/15/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YARegistrationErrorCreatorTests.h"
#import "YARegistrationErrorCreator.h"
#import "ErrorCreator.h"

@interface YARegistrationErrorCreatorTests()

@property (strong, nonatomic) id errorCreatorMock;
@property (strong, nonatomic) YARegistrationErrorCreator *registrationErrorCreator;

@end

@implementation YARegistrationErrorCreatorTests

@synthesize errorCreatorMock = errorCreatorMock_;
@synthesize registrationErrorCreator = registrationErrorCreator_;

- (void)setUp
{
    [self setErrorCreatorMock:[OCMockObject mockForProtocol:@protocol(ErrorCreator)]];
    [self setRegistrationErrorCreator:[[YARegistrationErrorCreator alloc] init]];
    [[self registrationErrorCreator] setErrorCreator:[self errorCreatorMock]];
}

- (void)testCreatesErrorWithinRegistrationErrorDomainAndGivenErrorCode
{
    [[[self errorCreatorMock] expect] errorWithDomain:YARegistrationErrorDomain code:100 localizedDescription:OCMOCK_ANY underlyingError:OCMOCK_ANY];
    
    [[self registrationErrorCreator] errorWithCode:100];
    
    [[self errorCreatorMock] verify];
}

- (void)testCreatesErrorWithCorrectLocalizedStringForErrorCode
{
	[[[self errorCreatorMock] expect] errorWithDomain:YARegistrationErrorDomain code:YARegistrationErrorCodeFailedToFetchRegistrationInformationFromLocalStorage localizedDescription:YARegistrationErrorFailedToFetchRegistrationInformationFromLocalStorage underlyingError:nil];
	[[self registrationErrorCreator] errorWithCode:YARegistrationErrorCodeFailedToFetchRegistrationInformationFromLocalStorage];

	[[[self errorCreatorMock] expect] errorWithDomain:YARegistrationErrorDomain code:YARegistrationErrorCodeFailedToSaveRegistrationInformationLocally localizedDescription:YARegistrationErrorFailedToSaveRegistrationInformationLocally underlyingError:nil];
	[[self registrationErrorCreator] errorWithCode:YARegistrationErrorCodeFailedToSaveRegistrationInformationLocally];

	[[[self errorCreatorMock] expect] errorWithDomain:YARegistrationErrorDomain code:YARegistrationErrorCodeFailedToRetrieveToken localizedDescription:YARegistrationErrorFailedToRetrieveToken underlyingError:nil];
	[[self registrationErrorCreator] errorWithCode:YARegistrationErrorCodeFailedToRetrieveToken];

	[[[self errorCreatorMock] expect] errorWithDomain:YARegistrationErrorDomain code:YARegistrationErrorCodeFailedToVerifyToken localizedDescription:YARegistrationErrorFailedToVerifyToken underlyingError:nil];
	[[self registrationErrorCreator] errorWithCode:YARegistrationErrorCodeFailedToVerifyToken];

	[[[self errorCreatorMock] expect] errorWithDomain:YARegistrationErrorDomain code:YARegistrationErrorCodeFailedToRenewRegistration localizedDescription:YARegistrationErrorFailedToRenewRegistration underlyingError:nil];
	[[self registrationErrorCreator] errorWithCode:YARegistrationErrorCodeFailedToRenewRegistration];

	[[[self errorCreatorMock] expect] errorWithDomain:YARegistrationErrorDomain code:YARegistrationErrorCodeFailedToVerfiyCarrier localizedDescription:YARegistrationErrorFailedToVerfiyCarrier underlyingError:nil];
	[[self registrationErrorCreator] errorWithCode:YARegistrationErrorCodeFailedToVerfiyCarrier];

	[[[self errorCreatorMock] expect] errorWithDomain:YARegistrationErrorDomain code:YARegistrationErrorCodeUnableToSendSMS localizedDescription:YARegistrationErrorUnableToSendSMS underlyingError:nil];
	[[self registrationErrorCreator] errorWithCode:YARegistrationErrorCodeUnableToSendSMS];

	[[[self errorCreatorMock] expect] errorWithDomain:YARegistrationErrorDomain code:YARegistrationErrorCodeFailedToSaveRegistrationInformation localizedDescription:YARegistrationErrorFailedToSaveRegistrationInformation underlyingError:nil];
	[[self registrationErrorCreator] errorWithCode:YARegistrationErrorCodeFailedToSaveRegistrationInformation];

    [[self errorCreatorMock] verify];
}

- (void)testCreatesErrorWithUnderlyingErrorIfPresent
{
    NSError *underlyingError = [NSError errorWithDomain:@"domain" code:1234 userInfo:nil];
    
    [[[self errorCreatorMock] expect] errorWithDomain:OCMOCK_ANY code:1 localizedDescription:OCMOCK_ANY underlyingError:underlyingError];
    
    [[self registrationErrorCreator] errorWithCode:1 underlyingError:underlyingError];
    
    [[self errorCreatorMock] verify];
}

- (void)testReturnsErrorCreatedByErrorCreator
{
    NSError *error = [NSError errorWithDomain:@"domain" code:1234 userInfo:nil];
    
    [[[[self errorCreatorMock] expect] andReturn:error] errorWithDomain:OCMOCK_ANY code:1 localizedDescription:OCMOCK_ANY underlyingError:OCMOCK_ANY];
    
    STAssertEqualObjects(error, [[self registrationErrorCreator] errorWithCode:1], @"Unexpected error returned");
}

@end
