//
//  YAConversationRepositoryTests.m
//  altoids
//
//  Created by Jon Herron on 9/19/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <OCMock/OCMock.h>
#import "ConversationCommandFactory.h"
#import "ConversationGapDetector.h"
#import "ConversationGapPlaceholderClearer.h"
#import "ConversationHandler.h"
#import "ConversationListToDictionaryTransformer.h"
#import "ConversationLocator.h"
#import "TransactionCommand.h"
#import "Command.h"
#import "CommandTransaction.h"
#import "CommandQueue.h"
#import "ManagedObjectContextFactory.h"
#import "MessageHandler.h"
#import "MessageRepository.h"
#import "MessageDeleter.h"
#import "MessageGapDetector.h"
#import "MessageGapPlaceholderClearer.h"
#import "ParticipantRepository.h"
#import "MutableArrayCreator.h"
#import "ConversationDeleter.h"
#import "YAConversationRepository.h"
#import "ParticipantHandler.h"
#import "ConversationErrorCreator.h"
#import "ParticipantErrorCreator.h"
#import "YAMessage.h"

@interface YAConversationRepositoryTests : SenTestCase

@property (strong, nonatomic) id conversationHandlerMock;
@property (strong, nonatomic) id managedObjectContextFactoryMock;
@property (strong, nonatomic) id participantRepositoryMock;
@property (strong, nonatomic) id messageRepositoryMock;
@property (strong, nonatomic) id conversationCommandFactoryMock;
@property (strong, nonatomic) id commandQueueMock;
@property (strong, nonatomic) id transactionCommandMock;
@property (strong, nonatomic) id commandMock;
@property (strong, nonatomic) id mutableArrayCreatorMock;
@property (strong, nonatomic) id conversationLocatorMock;
@property (strong, nonatomic) id converationGapPlaceholderClearerMock;
@property (strong, nonatomic) id conversationListToDictionaryTransformerMock;
@property (strong, nonatomic) id conversationGapDetectorMock;
@property (strong, nonatomic) id conversationDeleter;
@property (strong, nonatomic) id messageGapPlaceholderClearerMock;
@property (strong, nonatomic) id messageGapDetectorMock;
@property (strong, nonatomic) id messageDeleterMock;
@property (strong, nonatomic) id userProfileRepositoryMock;
@property (strong, nonatomic) id registrationFetcherMock;
@property (strong, nonatomic) id messageHandlerMock;
@property (strong, nonatomic) id participantHandlerMock;
@property (strong, nonatomic) id conversationErrorCreator;
@property (strong, nonatomic) id participantErrorCreator;
@property (strong, nonatomic) id messageStatusUpdater;
@property (strong, nonatomic) id transactionMock;
@property (strong, nonatomic) YAConversationRepository *conversationRepository;

- (void)verifyMocks;
@end

@implementation YAConversationRepositoryTests

@synthesize conversationHandlerMock = conversationHandlerMock_;
@synthesize managedObjectContextFactoryMock = managedObjectContextFactoryMock_;
@synthesize participantRepositoryMock = participantRepositoryMock_;
@synthesize messageRepositoryMock = messageRepositoryMock_;
@synthesize conversationCommandFactoryMock = conversationCommandFactoryMock_;
@synthesize commandQueueMock = commandQueueMock_;
@synthesize commandMock = commandMock_;
@synthesize transactionCommandMock = transactionCommandMock_;
@synthesize mutableArrayCreatorMock = mutableArrayCreatorMock_;
@synthesize conversationLocatorMock = conversationLocatorMock_;
@synthesize converationGapPlaceholderClearerMock = converationGapPlaceholderClearerMock_;
@synthesize conversationListToDictionaryTransformerMock = conversationListToDictionaryTransformerMock_;
@synthesize conversationGapDetectorMock = conversationGapDetectorMock_;
@synthesize conversationRepository = conversationRepository_;
@synthesize conversationDeleter = conversationDeleter_;
@synthesize messageGapPlaceholderClearerMock = messageGapPlaceholderClearerMock_;
@synthesize messageGapDetectorMock = messageGapDetectorMock_;
@synthesize messageDeleterMock = messageDeleterMock_;
@synthesize userProfileRepositoryMock = userProfileRepositoryMock_;
@synthesize registrationFetcherMock = registrationFetcherMock_;
@synthesize messageHandlerMock = messageHandlerMock_;
@synthesize participantHandlerMock = participantHandlerMock_;
@synthesize conversationErrorCreator = conversationErrorCreator_;
@synthesize participantErrorCreator = participantErrorCreator_;
@synthesize messageStatusUpdater = messageStatusUpdater_;
@synthesize transactionMock = transactionMock_;

- (void)setUp
{
    [self setConversationHandlerMock:[OCMockObject mockForProtocol:@protocol(ConversationHandler)]];
    [self setManagedObjectContextFactoryMock:[OCMockObject mockForProtocol:@protocol(ManagedObjectContextFactory)]];
    [self setParticipantRepositoryMock:[OCMockObject mockForProtocol:@protocol(ParticipantRepository)]];
    [self setMessageRepositoryMock:[OCMockObject mockForProtocol:@protocol(MessageRepository)]];
    [self setConversationCommandFactoryMock:[OCMockObject mockForProtocol:@protocol(ConversationCommandFactory)]];
    [self setCommandQueueMock:[OCMockObject mockForProtocol:@protocol(CommandQueue)]];
    [self setTransactionCommandMock:[OCMockObject mockForProtocol:@protocol(TransactionCommand)]];
    [self setCommandMock:[OCMockObject mockForProtocol:@protocol(Command)]];
    [self setMutableArrayCreatorMock:[OCMockObject mockForProtocol:@protocol(MutableArrayCreator)]];
    [self setConversationLocatorMock:[OCMockObject mockForProtocol:@protocol(ConversationLocator)]];
    [self setConverationGapPlaceholderClearerMock:[OCMockObject mockForProtocol:@protocol(ConversationGapPlaceholderClearer)]];
    [self setConversationListToDictionaryTransformerMock:[OCMockObject mockForProtocol:@protocol(ConversationListToDictionaryTransformer)]];
    [self setConversationGapDetectorMock:[OCMockObject mockForProtocol:@protocol(ConversationGapDetector)]];
    [self setConversationDeleter:[OCMockObject mockForProtocol:@protocol(ConversationDeleter)]];
    [self setMessageGapPlaceholderClearerMock:[OCMockObject mockForProtocol:@protocol(MessageGapPlaceholderClearer)]];
    [self setMessageGapDetectorMock:[OCMockObject mockForProtocol:@protocol(MessageGapDetector)]];
    [self setMessageDeleterMock:[OCMockObject mockForProtocol:@protocol(MessageDeleter)]];
    [self setUserProfileRepositoryMock:[OCMockObject mockForProtocol:@protocol(UserProfileRepository)]];
    [self setRegistrationFetcherMock:[OCMockObject mockForProtocol:@protocol(RegistrationFetcher)]];
    [self setMessageHandlerMock:[OCMockObject mockForProtocol:@protocol(MessageHandler)]];
    [self setParticipantHandlerMock:[OCMockObject mockForProtocol:@protocol(ParticipantHandler)]];
    [self setConversationErrorCreator:[OCMockObject mockForProtocol:@protocol(ConversationErrorCreator)]];
    [self setParticipantErrorCreator:[OCMockObject mockForProtocol:@protocol(ParticipantErrorCreator)]];
    [self setMessageStatusUpdater:[OCMockObject mockForProtocol:@protocol(MessageStatusUpdater)]];
    [self setTransactionMock:[OCMockObject mockForProtocol:@protocol(CommandTransaction)]];
    
    [self setConversationRepository:[[YAConversationRepository alloc] init]];
    [conversationRepository_ setConversationHandler:conversationHandlerMock_];
    [conversationRepository_ setManagedObjectContextFactory:managedObjectContextFactoryMock_];
    [conversationRepository_ setParticipantRepository:participantRepositoryMock_];
    [conversationRepository_ setMessageRepository:messageRepositoryMock_];
    [conversationRepository_ setUserProfileRepository:userProfileRepositoryMock_];
    [conversationRepository_ setRegistrationFetcher:registrationFetcherMock_];
    [conversationRepository_ setConversationCommandFactory:conversationCommandFactoryMock_];
    [conversationRepository_ setMmcCommandQueue:commandQueueMock_];
    [conversationRepository_ setMutableArrayCreator:mutableArrayCreatorMock_];
    [conversationRepository_ setConversationLocator:conversationLocatorMock_];
    [conversationRepository_ setConversationGapPlaceholderClearer:converationGapPlaceholderClearerMock_];
    [conversationRepository_ setConversationListToDictionaryTransformer:conversationListToDictionaryTransformerMock_];
    [conversationRepository_ setConversationGapDetector:conversationGapDetectorMock_];
    [conversationRepository_ setConversationDeleter:conversationDeleter_];
    [conversationRepository_ setMessageGapPlaceholderClearer:messageGapPlaceholderClearerMock_];
    [conversationRepository_ setMessageGapDetector:messageGapDetectorMock_];
    [conversationRepository_ setMessageDeleter:messageDeleterMock_];
    [conversationRepository_ setMessageHandler:messageHandlerMock_ ];
    [conversationRepository_ setParticipantHandler:participantHandlerMock_];
    [conversationRepository_ setConversationErrorCreator:conversationErrorCreator_];
    [conversationRepository_ setParticipantErrorCreator:participantErrorCreator_];
    [conversationRepository_ setMessageStatusUpdater:messageStatusUpdater_];
}

- (void)testLoadMostRecentConversationsCreatesConversationListCommandThroughConversationCommandFactory
{
    [[transactionCommandMock_ stub] transaction];
    [[[conversationCommandFactoryMock_ expect] andReturn:transactionCommandMock_] conversationListCommandForMostRecentConversationsWithDelegate:(id<ConversationListCommandDelegate>)conversationRepository_ transactionDelegate:nil];
    
    [[commandQueueMock_ stub] append:OCMOCK_ANY];

    [conversationRepository_ loadMostRecentConversationsWithTransactionDelegate:nil];
    [self verifyMocks];
}

- (void)testLoadMostRecentConversationsAddsConversationListCommandToCommandQueueAndReturnsCommandTransaction
{
    [[transactionCommandMock_ stub] transaction];
    [[[conversationCommandFactoryMock_ stub] andReturn:transactionCommandMock_] conversationListCommandForMostRecentConversationsWithDelegate:(id<ConversationListCommandDelegate>)conversationRepository_ transactionDelegate:nil];
    
    [[commandQueueMock_ expect] append:transactionCommandMock_];
    
    [conversationRepository_ loadMostRecentConversationsWithTransactionDelegate:nil];
    [self verifyMocks];
}

- (void)testLoadMostRecentConversationsReturnsCommandTransaction
{
    [[[conversationCommandFactoryMock_ stub] andReturn:transactionCommandMock_] conversationListCommandForMostRecentConversationsWithDelegate:(id<ConversationListCommandDelegate>)conversationRepository_ transactionDelegate:nil];
    
    [[commandQueueMock_ stub] append:OCMOCK_ANY];

    [[[transactionCommandMock_ expect] andReturn:transactionMock_] transaction];

    STAssertEquals(transactionMock_, [conversationRepository_ loadMostRecentConversationsWithTransactionDelegate:nil], nil);
    [self verifyMocks];
}

- (void)testIfDoesNotTryToMarkMessagesAsReadInAConversationNotAvailableOnServer
{
    id conversationMock = [OCMockObject mockForClass:[YAConversation class]];
    BOOL result = NO;
    [[[conversationHandlerMock_ expect] andReturnValue:[NSValue value:&result withObjCType:@encode(BOOL)]] conversationCreatedOnServer:conversationMock];

    [conversationRepository_ markUnreadMessagesAsRead:nil forConversation:conversationMock];
    
    [self verifyMocks];
}

- (void)testCreateConversationGapPlaceholderWillUseConversationIDFromGivenConvoAndMessageIDAndTimestampOfMostRecentMessage
{
    NSString *conversationID = @"cid";
    
    id convoMock = [OCMockObject mockForClass:[YAConversation class]];
    id gapConvoMock = [OCMockObject mockForClass:[YAConversation class]];
    id mostRecentMessageMock = [OCMockObject mockForClass:[YAMessage class]];
    id mostRecentMessageCopyMock = [OCMockObject mockForClass:[YAMessage class]];
    id managedObjectContextMock = [OCMockObject mockForClass:[NSManagedObjectContext class]];
    
    [[[conversationHandlerMock_ expect] andReturn:conversationID] conversationIDForConversation:convoMock];
    [[[conversationHandlerMock_ expect] andReturn:gapConvoMock] createConversationEntityInManagedObjectContext:managedObjectContextMock];
    [[[conversationHandlerMock_ expect] andReturn:mostRecentMessageMock] mostRecentMessageForConversation:convoMock];
    [[[messageHandlerMock_ expect] andReturn:mostRecentMessageCopyMock] createMessageEntityInManagedObjectContext:managedObjectContextMock];
    
    NSString *mid = @"mid";
    NSDate *date = [NSDate date];
    
    [[[messageHandlerMock_ expect] andReturn:mid] messageIDForMessage:mostRecentMessageMock];
    [[[messageHandlerMock_ expect] andReturn:date] timestampForMessage:mostRecentMessageMock];
    
    [[messageHandlerMock_ expect] setMessageID:mid forMessage:mostRecentMessageCopyMock];
    [[messageHandlerMock_ expect] setTimestamp:date forMessage:mostRecentMessageCopyMock];
    
    [[conversationHandlerMock_ expect] setStatusAsGapPlaceholderForConversation:gapConvoMock];
    [[conversationHandlerMock_ expect] setConversationID:conversationID forConversation:gapConvoMock];
    [[conversationHandlerMock_ expect] setMostRecentMessage:mostRecentMessageCopyMock forConversation:gapConvoMock];
    
    STAssertTrue(gapConvoMock == [conversationRepository_ createConversationGapPlaceholderToFollowConversation:convoMock inManagedObjectContext:managedObjectContextMock], nil);
    
    [self verifyMocks];
    [convoMock verify];
    [gapConvoMock verify];
    [mostRecentMessageMock verify];
    [mostRecentMessageCopyMock verify];
    [managedObjectContextMock verify];
}

- (void)verifyMocks
{
    [conversationHandlerMock_ verify];
    [managedObjectContextFactoryMock_ verify];
    [participantRepositoryMock_ verify];
    [messageRepositoryMock_ verify];
    [conversationCommandFactoryMock_ verify];
    [commandQueueMock_ verify];
    [transactionCommandMock_ verify];
    [commandMock_ verify];
    [mutableArrayCreatorMock_ verify];
    [conversationLocatorMock_ verify];
    [converationGapPlaceholderClearerMock_ verify];
    [conversationListToDictionaryTransformerMock_ verify];
    [conversationGapDetectorMock_ verify];
    [conversationDeleter_ verify];
    [messageGapPlaceholderClearerMock_ verify];
    [messageGapDetectorMock_ verify];
    [messageDeleterMock_ verify];
    [userProfileRepositoryMock_ verify];
    [registrationFetcherMock_ verify];
    [messageHandlerMock_ verify];
    [participantHandlerMock_ verify];
    [conversationErrorCreator_ verify];
    [participantErrorCreator_ verify];
    [messageStatusUpdater_ verify];
    [transactionMock_ verify];
}
@end
