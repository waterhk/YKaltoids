//
//  YAValidationErrorCreatorTests.m
//  altoids
//
//  Created by Jon Herron on 11/15/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAValidationErrorCreatorTests.h"
#import "YAValidationErrorCreator.h"
#import "ErrorCreator.h"

@interface YAValidationErrorCreatorTests()

@property (strong, nonatomic) id errorCreatorMock;
@property (strong, nonatomic) YAValidationErrorCreator *validationErrorCreator;

@end

@implementation YAValidationErrorCreatorTests

@synthesize errorCreatorMock = errorCreatorMock_;
@synthesize validationErrorCreator = validationErrorCreator_;

- (void)setUp
{
    [self setErrorCreatorMock:[OCMockObject mockForProtocol:@protocol(ErrorCreator)]];
    [self setValidationErrorCreator:[[YAValidationErrorCreator alloc] initWithErrorCreator:[self errorCreatorMock]]];
}

- (void)testCreatesErrorWithinValidationErrorDomainAndGivenErrorCode
{
    [[[self errorCreatorMock] expect] errorWithDomain:YAValidationErrorDomain code:100 localizedDescription:OCMOCK_ANY underlyingError:OCMOCK_ANY];
    
    [[self validationErrorCreator] errorWithCode:100];
    
    [[self errorCreatorMock] verify];
}

- (void)testCreatesErrorWithCorrectLocalizedStringForErrorCode
{
	[[[self errorCreatorMock] expect] errorWithDomain:YAValidationErrorDomain code:YAValidationErrorCodeConversationIsNil localizedDescription:YAValidationErrorConversationIsNil underlyingError:nil];
	[[self validationErrorCreator] errorWithCode:YAValidationErrorCodeConversationIsNil];

	[[[self errorCreatorMock] expect] errorWithDomain:YAValidationErrorDomain code:YAValidationErrorCodeConversationIDIsNil localizedDescription:YAValidationErrorConversationIDIsNil underlyingError:nil];
	[[self validationErrorCreator] errorWithCode:YAValidationErrorCodeConversationIDIsNil];

	[[[self errorCreatorMock] expect] errorWithDomain:YAValidationErrorDomain code:YAValidationErrorCodeConversationSenderIsNil localizedDescription:YAValidationErrorConversationSenderIsNil underlyingError:nil];
	[[self validationErrorCreator] errorWithCode:YAValidationErrorCodeConversationSenderIsNil];

	[[[self errorCreatorMock] expect] errorWithDomain:YAValidationErrorDomain code:YAValidationErrorCodeConversationHasNoMessages localizedDescription:YAValidationErrorConversationHasNoMessages underlyingError:nil];
	[[self validationErrorCreator] errorWithCode:YAValidationErrorCodeConversationHasNoMessages];

	[[[self errorCreatorMock] expect] errorWithDomain:YAValidationErrorDomain code:YAValidationErrorCodeConversationHasNoParticipants localizedDescription:YAValidationErrorConversationHasNoParticipants underlyingError:nil];
	[[self validationErrorCreator] errorWithCode:YAValidationErrorCodeConversationHasNoParticipants];

	[[[self errorCreatorMock] expect] errorWithDomain:YAValidationErrorDomain code:YAValidationErrorCodeMessageIsNil localizedDescription:YAValidationErrorMessageIsNil underlyingError:nil];
	[[self validationErrorCreator] errorWithCode:YAValidationErrorCodeMessageIsNil];

	[[[self errorCreatorMock] expect] errorWithDomain:YAValidationErrorDomain code:YAValidationErrorCodeMessageSenderIsNil localizedDescription:YAValidationErrorMessageSenderIsNil underlyingError:nil];
	[[self validationErrorCreator] errorWithCode:YAValidationErrorCodeMessageSenderIsNil];

	[[[self errorCreatorMock] expect] errorWithDomain:YAValidationErrorDomain code:YAValidationErrorCodeParticipantIsNil localizedDescription:YAValidationErrorParticipantIsNil underlyingError:nil];
	[[self validationErrorCreator] errorWithCode:YAValidationErrorCodeParticipantIsNil];

	[[[self errorCreatorMock] expect] errorWithDomain:YAValidationErrorDomain code:YAValidationErrorCodeAddressIsNil localizedDescription:YAValidationErrorAddressIsNil underlyingError:nil];
	[[self validationErrorCreator] errorWithCode:YAValidationErrorCodeAddressIsNil];

	[[[self errorCreatorMock] expect] errorWithDomain:YAValidationErrorDomain code:YAValidationErrorCodeInvalidAddressType localizedDescription:YAValidationErrorInvalidAddressType underlyingError:nil];
	[[self validationErrorCreator] errorWithCode:YAValidationErrorCodeInvalidAddressType];

	[[[self errorCreatorMock] expect] errorWithDomain:YAValidationErrorDomain code:YAValidationErrorCodeInvalidAddressHandle localizedDescription:YAValidationErrorInvalidAddressHandle underlyingError:nil];
	[[self validationErrorCreator] errorWithCode:YAValidationErrorCodeInvalidAddressHandle];

    [[self errorCreatorMock] verify];
}

- (void)testCreatesErrorWithUnderlyingErrorIfPresent
{
    NSError *underlyingError = [NSError errorWithDomain:@"domain" code:1234 userInfo:nil];
    
    [[[self errorCreatorMock] expect] errorWithDomain:OCMOCK_ANY code:1 localizedDescription:OCMOCK_ANY underlyingError:underlyingError];
    
    [[self validationErrorCreator] errorWithCode:1 underlyingError:underlyingError];
    
    [[self errorCreatorMock] verify];
}

- (void)testReturnsErrorCreatedByErrorCreator
{
    NSError *error = [NSError errorWithDomain:@"domain" code:1234 userInfo:nil];
    
    [[[[self errorCreatorMock] expect] andReturn:error] errorWithDomain:OCMOCK_ANY code:1 localizedDescription:OCMOCK_ANY underlyingError:OCMOCK_ANY];
    
    STAssertEqualObjects(error, [[self validationErrorCreator] errorWithCode:1], @"Unexpected error returned");
}

@end
