//
//  YAAddressErrorCreatorTests.m
//  altoids
//
//  Created by Jon Herron on 11/15/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAAddressErrorCreatorTests.h"
#import "YAAddressErrorCreator.h"
#import "ErrorCreator.h"

@interface YAAddressErrorCreatorTests()

@property (strong, nonatomic) id errorCreatorMock;
@property (strong, nonatomic) YAAddressErrorCreator *addressErrorCreator;

@end

@implementation YAAddressErrorCreatorTests

@synthesize errorCreatorMock = errorCreatorMock_;
@synthesize addressErrorCreator = addressErrorCreator_;

- (void)setUp
{
    [self setErrorCreatorMock:[OCMockObject mockForProtocol:@protocol(ErrorCreator)]];

    [self setAddressErrorCreator:[[YAAddressErrorCreator alloc] init]];
    [[self addressErrorCreator] setErrorCreator:[self errorCreatorMock]];
}

- (void)testCreatesErrorWithinAddressErrorDomainAndGivenErrorCode
{
    [[[self errorCreatorMock] expect] errorWithDomain:YAAddressErrorDomain code:100 localizedDescription:OCMOCK_ANY underlyingError:OCMOCK_ANY];
    
    [[self addressErrorCreator] errorWithCode:100];
    
    [[self errorCreatorMock] verify];
}

- (void)testCreatesErrorWithCorrectLocalizedStringForErrorCode
{
	[[[self errorCreatorMock] expect] errorWithDomain:YAAddressErrorDomain code:YAAddressErrorCodeFailedToCreateAddressLocally localizedDescription:YAAddressErrorFailedToCreateAddressLocally underlyingError:nil];
	[[self addressErrorCreator] errorWithCode:YAAddressErrorCodeFailedToCreateAddressLocally];

	[[[self errorCreatorMock] expect] errorWithDomain:YAAddressErrorDomain code:YAAddressErrorCodeFailedToFormatAddress localizedDescription:YAAddressErrorFailedToFormatAddress underlyingError:nil];
	[[self addressErrorCreator] errorWithCode:YAAddressErrorCodeFailedToFormatAddress];

	[[[self errorCreatorMock] expect] errorWithDomain:YAAddressErrorDomain code:YAAddressErrorCodeFailedToNormalizeAddress localizedDescription:YAAddressErrorFailedToNormalizeAddress underlyingError:nil];
	[[self addressErrorCreator] errorWithCode:YAAddressErrorCodeFailedToNormalizeAddress];

	[[[self errorCreatorMock] expect] errorWithDomain:YAAddressErrorDomain code:YAAddressErrorCodeUnknownAddressType localizedDescription:YAAddressErrorUnknownAddressType underlyingError:nil];
	[[self addressErrorCreator] errorWithCode:YAAddressErrorCodeUnknownAddressType];

    [[self errorCreatorMock] verify];
}

- (void)testCreatesErrorWithUnderlyingErrorIfPresent
{
    NSError *underlyingError = [NSError errorWithDomain:@"domain" code:1234 userInfo:nil];
    
    [[[self errorCreatorMock] expect] errorWithDomain:OCMOCK_ANY code:1 localizedDescription:OCMOCK_ANY underlyingError:underlyingError];
    
    [[self addressErrorCreator] errorWithCode:1 underlyingError:underlyingError];
    
    [[self errorCreatorMock] verify];
}

- (void)testReturnsErrorCreatedByErrorCreator
{
    NSError *error = [NSError errorWithDomain:@"domain" code:1234 userInfo:nil];
    
    [[[[self errorCreatorMock] expect] andReturn:error] errorWithDomain:OCMOCK_ANY code:1 localizedDescription:OCMOCK_ANY underlyingError:OCMOCK_ANY];
    
    STAssertEqualObjects(error, [[self addressErrorCreator] errorWithCode:1], @"Unexpected error returned");
}

@end
