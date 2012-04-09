//
//  YAMessageRepositoryTests.m
//  altoids
//
//  Created by Jon Herron on 9/14/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAMessageRepositoryTests.h"
#import "MessageHandler.h"
#import "YAMessage.h"
#import "YAMessageHandler.h"
#import "YAMessageRepository.h"
#import "YAManagedObjectContextFactory.h"
#import "YAParticipant.h"
#import "YAParticipantHandler.h"
#import "MessageDeleter.h"
#import "MessageUpdater.h"
#import "MessageErrorCreator.h"
#import "YAMessageInfo.h"
#import "YAParticipantInfo.h"

@interface YAMessageRepositoryTests()

@property (strong, nonatomic) id messageMock;
@property (strong, nonatomic) id messageInfoMock;
@property (strong, nonatomic) id participantMock;
@property (strong, nonatomic) id participantInfoMock;
@property (strong, nonatomic) id managedObjectContextMock;
@property (strong, nonatomic) id messageDeleterMock;
@property (strong, nonatomic) id messageHandlerMock;
@property (strong, nonatomic) id participantRepositoryMock;
@property (strong, nonatomic) id messageUpdaterMock;
@property (strong, nonatomic) id messageErrorCreatorMock;
@property (strong, nonatomic) YAMessageRepository *messageRepository;

- (void)verifyMocks;

@end

@implementation YAMessageRepositoryTests

@synthesize messageMock = messageMock_;
@synthesize managedObjectContextMock = managedObjectContextMock_;
@synthesize messageDeleterMock = messageDeleterMock_;
@synthesize messageHandlerMock = messageHandlerMock_;
@synthesize messageRepository = messageRepository_;
@synthesize participantMock = participantMock_;
@synthesize messageUpdaterMock = messageUpdaterMock_;
@synthesize messageInfoMock = messageInfoMock_;
@synthesize participantInfoMock = participantInfoMock_;
@synthesize messageErrorCreatorMock = messageErrorCreatorMock_;
@synthesize participantRepositoryMock = participantRepositoryMock_;

- (void)setUp
{
    [self setManagedObjectContextMock:[OCMockObject mockForClass:[NSManagedObjectContext class]]];
    [self setMessageHandlerMock:[OCMockObject mockForProtocol:@protocol(MessageHandler)]];
    [self setMessageDeleterMock:[OCMockObject mockForProtocol:@protocol(MessageDeleter)]];
    [self setParticipantRepositoryMock:[OCMockObject mockForProtocol:@protocol(ParticipantRepository)]];
    [self setMessageMock:[OCMockObject mockForClass:[YAMessage class]]];
    [self setParticipantMock:[OCMockObject mockForClass:[YAParticipant class]]];
    [self setMessageInfoMock:[OCMockObject mockForClass:[YAMessageInfo class]]];
    [self setParticipantInfoMock:[OCMockObject mockForClass:[YAParticipantInfo class]]];
    [self setMessageUpdaterMock:[OCMockObject mockForProtocol:@protocol(MessageUpdater)]];
    [self setMessageErrorCreatorMock:[OCMockObject mockForProtocol:@protocol(MessageErrorCreator)]];
    
    [self setMessageRepository:[[YAMessageRepository alloc] init]];
    [[self messageRepository] setMessageHandler:[self messageHandlerMock]];
    [[self messageRepository] setMessageDeleter:[self messageDeleterMock]];
    [[self messageRepository] setParticipantRepository:[self participantRepositoryMock]];
    [[self messageRepository] setMessageErrorCreator:[self messageErrorCreatorMock]];
    [[self messageRepository] setMessageUpdater:[self messageUpdaterMock]];
}

- (void)testCanCreateMessageInGivenManagedObjectContext
{
    NSError *error;
    
    [[[[self messageHandlerMock] expect] andReturn:[self messageMock]] createMessageEntityInManagedObjectContext:[self managedObjectContextMock]];
    [[[[self messageInfoMock] expect] andReturn:[self participantInfoMock]] sender];
    [[[[self participantRepositoryMock] expect] andReturn:[self participantMock]] createParticipantFromParticipantInfo:[self participantInfoMock] inManagedObjectContext:[self managedObjectContextMock] error:[OCMArg setTo:nil]];
    [[[self messageUpdaterMock] expect] updateMessage:[self messageMock] fromMessageInfo:[self messageInfoMock] withSender:[self participantMock]];
    
    STAssertEqualObjects([self messageMock], [[self messageRepository] createMessageFromMessageInfo:[self messageInfoMock] inManagedObjectContext:[self managedObjectContextMock] error:&error], @"Unexpected message returned");
    
    STAssertNil(error, @"Unexpected error");
    
    [self verifyMocks];
}

- (void)testCanCreateMessageWithoutSender
{
    NSError *error;
    
    [[[[self messageHandlerMock] expect] andReturn:[self messageMock]] createMessageEntityInManagedObjectContext:[self managedObjectContextMock]];
    [[[[self messageInfoMock] expect] andReturn:nil] sender];
    [[[self messageUpdaterMock] expect] updateMessage:[self messageMock] fromMessageInfo:[self messageInfoMock] withSender:nil];
    
    STAssertEqualObjects([self messageMock], [[self messageRepository] createMessageFromMessageInfo:[self messageInfoMock] inManagedObjectContext:[self managedObjectContextMock] error:&error], @"Unexpected message returned");
    
    STAssertNil(error, @"Unexpected error");
    
    [self verifyMocks];
}

- (void)testCreateMessageWillReturnNilAndSetErrorIfUnableToCreateParticipantAsSender
{
    NSError *error;
    NSError *errorFromMessageErrorCreator = [NSError errorWithDomain:@"m" code:32 userInfo:nil];
    NSError *errorFromParticipantRepository = [NSError errorWithDomain:@"d" code:12 userInfo:nil];
    
    [[[[self messageHandlerMock] expect] andReturn:[self messageMock]] createMessageEntityInManagedObjectContext:[self managedObjectContextMock]];
    [[[[self messageInfoMock] expect] andReturn:[self participantInfoMock]] sender];
    [[[[self participantRepositoryMock] expect] andReturn:nil] createParticipantFromParticipantInfo:[self participantInfoMock] inManagedObjectContext:[self managedObjectContextMock] error:[OCMArg setTo:errorFromParticipantRepository]];
    [[[[self messageErrorCreatorMock] expect] andReturn:errorFromMessageErrorCreator] errorWithCode:YAMessageErrorCodeFailedToCreateMessageLocally underlyingError:errorFromParticipantRepository];
    
    STAssertNil([[self messageRepository] createMessageFromMessageInfo:[self messageInfoMock] inManagedObjectContext:[self managedObjectContextMock] error:&error], @"Unexpected message returned");
    
    STAssertEqualObjects(errorFromMessageErrorCreator, error, @"Unexpected error returned");
    
    [self verifyMocks];
}

- (void)testUsesMessageDeleterToDeleteAllMessagesInAConversationWithID
{
    BOOL deletedMessages = YES;
    NSError *error;
    NSString *conversationID = @"cid";
    
    [[[[self messageDeleterMock] expect] andReturnValue:OCMOCK_VALUE(deletedMessages)] deleteAllMessagesInConversationWithID:conversationID inManagedObjectContext:[self managedObjectContextMock] error:[OCMArg setTo:nil]];
    
    STAssertTrue([[self messageRepository] deleteAllMessagesInConversationWithID:conversationID inManagedObjectContext:[self managedObjectContextMock] error:&error], @"Unexpected false return");
    
    STAssertNil(error, @"Unexpected error returned");
    
    [self verifyMocks];
}

- (void)testIfMessageDeleterIsInErrorMessageRepositoryWillReturnFalseAndSetError
{
    BOOL deletedMessages = NO;
    NSError *error;
    NSError *errorFromMessageDeleter = [NSError errorWithDomain:@"md" code:11 userInfo:nil];
    NSError *errorFromErrorCreator = [NSError errorWithDomain:@"ec" code:22 userInfo:nil];
    NSString *conversationID = @"cid";
    
    [[[[self messageDeleterMock] expect] andReturnValue:OCMOCK_VALUE(deletedMessages)] deleteAllMessagesInConversationWithID:conversationID inManagedObjectContext:[self managedObjectContextMock] error:[OCMArg setTo:errorFromMessageDeleter]];
    
    [[[[self messageErrorCreatorMock] expect] andReturn:errorFromErrorCreator] errorWithCode:YAMessageErrorCodeFailedToDeleteAllMessagesInConversation underlyingError:errorFromMessageDeleter];
    
    STAssertFalse([[self messageRepository] deleteAllMessagesInConversationWithID:conversationID inManagedObjectContext:[self managedObjectContextMock] error:&error], @"Unexpected false return");
    
    STAssertEqualObjects(errorFromErrorCreator, error, @"Unexpected error returned");
    
    [self verifyMocks];
}

- (void)verifyMocks
{
    [[self messageHandlerMock] verify];
    [[self messageMock] verify];
    [[self managedObjectContextMock] verify];
    [[self messageInfoMock] verify];
    [[self participantMock] verify];
    [[self participantInfoMock] verify];
    [[self participantRepositoryMock] verify];
    [[self messageUpdaterMock] verify];
    [[self messageDeleterMock] verify];
    [[self messageErrorCreatorMock] verify];
}

@end
