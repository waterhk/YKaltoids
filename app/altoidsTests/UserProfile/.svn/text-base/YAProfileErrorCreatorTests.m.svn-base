//
//  YAProfileErrorCreatorTests.m
//  altoids
//
//  Created by Jon Herron on 11/15/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAProfileErrorCreatorTests.h"
#import "YAProfileErrorCreator.h"
#import "ErrorCreator.h"

@interface YAProfileErrorCreatorTests()

@property (strong, nonatomic) id errorCreatorMock;
@property (strong, nonatomic) YAProfileErrorCreator *profileErrorCreator;

@end

@implementation YAProfileErrorCreatorTests

@synthesize errorCreatorMock = errorCreatorMock_;
@synthesize profileErrorCreator = profileErrorCreator_;

- (void)setUp
{
    [self setErrorCreatorMock:[OCMockObject mockForProtocol:@protocol(ErrorCreator)]];
    [self setProfileErrorCreator:[[YAProfileErrorCreator alloc] init]];
    [[self profileErrorCreator] setErrorCreator:[self errorCreatorMock]];
}

- (void)testCreatesErrorWithinProfileErrorDomainAndGivenErrorCode
{
    [[[self errorCreatorMock] expect] errorWithDomain:YAProfileErrorDomain code:100 localizedDescription:OCMOCK_ANY underlyingError:OCMOCK_ANY];
    
    [[self profileErrorCreator] errorWithCode:100];
    
    [[self errorCreatorMock] verify];
}

- (void)testCreatesErrorWithCorrectLocalizedStringForErrorCode
{
	[[[self errorCreatorMock] expect] errorWithDomain:YAProfileErrorDomain code:YAProfileErrorCodeFailedToCreateUserProfileLocally localizedDescription:YAProfileErrorFailedToCreateUserProfileLocally underlyingError:nil];
	[[self profileErrorCreator] errorWithCode:YAProfileErrorCodeFailedToCreateUserProfileLocally];

	[[[self errorCreatorMock] expect] errorWithDomain:YAProfileErrorDomain code:YAProfileErrorCodeFailedToFetchUserProfileFromLocalStorage localizedDescription:YAProfileErrorFailedToFetchUserProfileFromLocalStorage underlyingError:nil];
	[[self profileErrorCreator] errorWithCode:YAProfileErrorCodeFailedToFetchUserProfileFromLocalStorage];

	[[[self errorCreatorMock] expect] errorWithDomain:YAProfileErrorDomain code:YAProfileErrorCodeFailedToRetrieveUserProfile localizedDescription:YAProfileErrorFailedToRetrieveUserProfile underlyingError:nil];
	[[self profileErrorCreator] errorWithCode:YAProfileErrorCodeFailedToRetrieveUserProfile];

	[[[self errorCreatorMock] expect] errorWithDomain:YAProfileErrorDomain code:YAProfileErrorCodeFailedToSaveUserProfile localizedDescription:YAProfileErrorFailedToSaveUserProfile underlyingError:nil];
	[[self profileErrorCreator] errorWithCode:YAProfileErrorCodeFailedToSaveUserProfile];

    [[self errorCreatorMock] verify];
}

- (void)testCreatesErrorWithUnderlyingErrorIfPresent
{
    NSError *underlyingError = [NSError errorWithDomain:@"domain" code:1234 userInfo:nil];
    
    [[[self errorCreatorMock] expect] errorWithDomain:OCMOCK_ANY code:1 localizedDescription:OCMOCK_ANY underlyingError:underlyingError];
    
    [[self profileErrorCreator] errorWithCode:1 underlyingError:underlyingError];
    
    [[self errorCreatorMock] verify];
}

- (void)testReturnsErrorCreatedByErrorCreator
{
    NSError *error = [NSError errorWithDomain:@"domain" code:1234 userInfo:nil];
    
    [[[[self errorCreatorMock] expect] andReturn:error] errorWithDomain:OCMOCK_ANY code:1 localizedDescription:OCMOCK_ANY underlyingError:OCMOCK_ANY];
    
    STAssertEqualObjects(error, [[self profileErrorCreator] errorWithCode:1], @"Unexpected error returned");
}

@end
