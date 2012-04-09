//
//  YAMessageErrorCreatorTests.m
//  altoids
//
//  Created by Jon Herron on 11/15/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAMessageErrorCreatorTests.h"
#import "YAMessageErrorCreator.h"
#import "ErrorCreator.h"

@interface YAMessageErrorCreatorTests()

@property (strong, nonatomic) id errorCreatorMock;
@property (strong, nonatomic) YAMessageErrorCreator *messageErrorCreator;

@end

@implementation YAMessageErrorCreatorTests

@synthesize errorCreatorMock = errorCreatorMock_;
@synthesize messageErrorCreator = messageErrorCreator_;

- (void)setUp
{
    [self setErrorCreatorMock:[OCMockObject mockForProtocol:@protocol(ErrorCreator)]];

    [self setMessageErrorCreator:[[YAMessageErrorCreator alloc] init]];
    [[self messageErrorCreator] setErrorCreator:[self errorCreatorMock]];
}

- (void)testCreatesErrorWithinMessageErrorDomainAndGivenErrorCode
{
    [[[self errorCreatorMock] expect] errorWithDomain:YAMessageErrorDomain code:100 localizedDescription:OCMOCK_ANY underlyingError:OCMOCK_ANY];
    
    [[self messageErrorCreator] errorWithCode:100];
    
    [[self errorCreatorMock] verify];
}

- (void)testCreatesErrorWithCorrectLocalizedStringForErrorCode
{
	[[[self errorCreatorMock] expect] errorWithDomain:YAMessageErrorDomain code:YAMessageErrorCodeFailedToFetchMessagesFromLocalStorage localizedDescription:YAMessageErrorFailedToFetchMessagesFromLocalStorage underlyingError:nil];
	[[self messageErrorCreator] errorWithCode:YAMessageErrorCodeFailedToFetchMessagesFromLocalStorage];

	[[[self errorCreatorMock] expect] errorWithDomain:YAMessageErrorDomain code:YAMessageErrorCodeFailedToRetrieveMessageFromServer localizedDescription:YAMessageErrorFailedToRetrieveMessageFromServer underlyingError:nil];
	[[self messageErrorCreator] errorWithCode:YAMessageErrorCodeFailedToRetrieveMessageFromServer];

	[[[self errorCreatorMock] expect] errorWithDomain:YAMessageErrorDomain code:YAMessageErrorCodeFailedToRetrieveMessagesFromServer localizedDescription:YAMessageErrorFailedToRetrieveMessagesFromServer underlyingError:nil];
	[[self messageErrorCreator] errorWithCode:YAMessageErrorCodeFailedToRetrieveMessagesFromServer];

	[[[self errorCreatorMock] expect] errorWithDomain:YAMessageErrorDomain code:YAMessageErrorCodeFailedToCreateMessageLocally localizedDescription:YAMessageErrorFailedToCreateMessageLocally underlyingError:nil];
	[[self messageErrorCreator] errorWithCode:YAMessageErrorCodeFailedToCreateMessageLocally];

	[[[self errorCreatorMock] expect] errorWithDomain:YAMessageErrorDomain code:YAMessageErrorCodeFailedToDeleteAllMessagesInConversation localizedDescription:YAMessageErrorFailedToDeleteAllMessagesInConversation underlyingError:nil];
	[[self messageErrorCreator] errorWithCode:YAMessageErrorCodeFailedToDeleteAllMessagesInConversation];

	[[[self errorCreatorMock] expect] errorWithDomain:YAMessageErrorDomain code:YAMessageErrorCodeFailedToSaveMessageLocally localizedDescription:YAMessageErrorFailedToSaveMessageLocally underlyingError:nil];
	[[self messageErrorCreator] errorWithCode:YAMessageErrorCodeFailedToSaveMessageLocally];

    [[self errorCreatorMock] verify];
}

- (void)testCreatesErrorWithUnderlyingErrorIfPresent
{
    NSError *underlyingError = [NSError errorWithDomain:@"domain" code:1234 userInfo:nil];
    
    [[[self errorCreatorMock] expect] errorWithDomain:OCMOCK_ANY code:1 localizedDescription:OCMOCK_ANY underlyingError:underlyingError];
    
    [[self messageErrorCreator] errorWithCode:1 underlyingError:underlyingError];
    
    [[self errorCreatorMock] verify];
}

- (void)testReturnsErrorCreatedByErrorCreator
{
    NSError *error = [NSError errorWithDomain:@"domain" code:1234 userInfo:nil];
    
    [[[[self errorCreatorMock] expect] andReturn:error] errorWithDomain:OCMOCK_ANY code:1 localizedDescription:OCMOCK_ANY underlyingError:OCMOCK_ANY];
    
    STAssertEqualObjects(error, [[self messageErrorCreator] errorWithCode:1], @"Unexpected error returned");
}

@end
