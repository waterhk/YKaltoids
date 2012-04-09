//
//  YAMessageStatusUpdaterTests.m
//  altoids
//
//  Created by Jon Herron on 12/1/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAMessageStatusUpdaterTests.h"
#import "ArraySplitter.h"
#import "CommandQueue.h"
#import "ConversationCommandFactory.h"
#import "MessageListToArrayOfMessageIDsConverter.h"
#import "MessageHandler.h"
#import "YAMessageStatusUpdater.h"
#import "YAConversation.h"

@interface YAMessageStatusUpdaterTests()

@property (strong, nonatomic) id arraySplitterMock;
@property (strong, nonatomic) id commandQueueMock;
@property (strong, nonatomic) id conversationCommandFactoryMock;
@property (strong, nonatomic) id messageListToArrayOfMessageIDsConverter;
@property (strong, nonatomic) id messageHandlerMock;
@property (strong, nonatomic) YAMessageStatusUpdater *messageStatusUpdater;

@end

@implementation YAMessageStatusUpdaterTests

@synthesize arraySplitterMock = arraySplitterMock_;
@synthesize commandQueueMock = commandQueueMock_;
@synthesize conversationCommandFactoryMock = conversationCommandFactoryMock_;
@synthesize messageListToArrayOfMessageIDsConverter = messageListToArrayOfMessageIDsConverterMock_;
@synthesize messageHandlerMock = messageHandlerMock_;
@synthesize messageStatusUpdater = messageStatusUpdater_;

- (void)setUp
{
    [self setArraySplitterMock:[OCMockObject mockForProtocol:@protocol(ArraySplitter)]];
    [self setCommandQueueMock:[OCMockObject mockForProtocol:@protocol(CommandQueue)]];
    [self setConversationCommandFactoryMock:[OCMockObject mockForProtocol:@protocol(ConversationCommandFactory)]];
    [self setMessageListToArrayOfMessageIDsConverter:[OCMockObject mockForProtocol:@protocol(MessageListToArrayOfMessageIDsConverter)]];
    [self setMessageHandlerMock:[OCMockObject mockForProtocol:@protocol(MessageHandler)]];
    
    [self setMessageStatusUpdater:[[YAMessageStatusUpdater alloc] init]];
    [[self messageStatusUpdater] setMmcCommandQueue:[self commandQueueMock]];
    [[self messageStatusUpdater] setArraySplitter:[self arraySplitterMock]];
    [[self messageStatusUpdater] setConversationCommandFactory:[self conversationCommandFactoryMock]];
    [[self messageStatusUpdater] setMessageListToArrayOfMessageIDsConverter:[self messageListToArrayOfMessageIDsConverter]];
    [[self messageStatusUpdater] setMessageHandler:[self messageHandlerMock]];
}

- (void)testForEachGroupOfUnreadMessagesCreatesCommandToMarkMessagesAsReadAndAddsCommandToCommandQueue
{
    id command1Mock = [OCMockObject mockForProtocol:@protocol(Command)];
    id command2Mock = [OCMockObject mockForProtocol:@protocol(Command)];
    id command3Mock = [OCMockObject mockForProtocol:@protocol(Command)];
    id managedObjectContextMock = [OCMockObject mockForClass:[NSManagedObjectContext class]];
    id conversationMock = [OCMockObject mockForClass:[YAConversation class]];
    NSArray *unreadMessageBatch1 = [NSArray array];
    NSArray *unreadMessageBatch2 = [NSArray array];
    NSArray *unreadMessageBatch3 = [NSArray array];
    NSArray *splitMessages = [NSArray arrayWithObjects:unreadMessageBatch1, unreadMessageBatch2, unreadMessageBatch3, nil];
    NSArray *messageIDs = [NSArray arrayWithObjects:@"mid1", @"mid2", @"mid3", @"mid4", @"mid5", @"mid6", @"mid7", @"mid8", @"mid9", @"mid10", @"mid11", @"mid12", 
                           @"mid13", @"mid14",  @"mid15", @"mid16", @"mid17", @"mid18", @"mid19", @"mid20", @"mid21", @"mid22", @"mid23", @"mid24", @"mid25", @"mid26",
                           @"mid27", @"mid28", @"mid29", @"mid30", @"mid31",nil];
    NSArray *unreadMessages = [NSArray array];
    
    [[[[self messageListToArrayOfMessageIDsConverter] expect] andReturn:messageIDs] arrayOfMessageIDsFromArrayOfMessages:unreadMessages];
    [[[[self arraySplitterMock] expect] andReturn:splitMessages] splitArray:messageIDs intoGroupsOfSize:10];
    [[[conversationMock expect] andReturn:managedObjectContextMock] managedObjectContext];
    [[managedObjectContextMock stub] save:[OCMArg setTo:nil]];
    
    [[[[self conversationCommandFactoryMock] expect] andReturn:command1Mock] conversationMessagesFlagAsReadCommandWithConversation:conversationMock messageIDs:unreadMessageBatch1];
    [[[[self conversationCommandFactoryMock] expect] andReturn:command2Mock] conversationMessagesFlagAsReadCommandWithConversation:conversationMock messageIDs:unreadMessageBatch2];
    [[[[self conversationCommandFactoryMock] expect] andReturn:command3Mock] conversationMessagesFlagAsReadCommandWithConversation:conversationMock messageIDs:unreadMessageBatch3];
    
    [[[self commandQueueMock] expect] append:command1Mock];
    [[[self commandQueueMock] expect] append:command2Mock];
    [[[self commandQueueMock] expect] append:command3Mock];
    
    [[self messageStatusUpdater] markMesssageAsRead:unreadMessages forConversation:conversationMock];
 
    [[self messageListToArrayOfMessageIDsConverter] verify];
    [[self arraySplitterMock] verify];
    [[self commandQueueMock] verify];
}

@end
