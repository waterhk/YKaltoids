//
//  YAConversationCreateRequestDataBuilderTests.m
//  altoids
//
//  Created by Jon Herron on 10/5/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAConversationCreateRequestDataBuilderTests.h"
#import "YAConversationCreateRequestDataBuilder.h"
#import "YAConversation.h"
#import "YAMessage.h"
#import "YAParticipant.h"
#import "ParticipantsRequestDataBuilder.h"
#import "ConversationHandler.h"
#import "MessageHandler.h"
#import "MutableDictionaryCreator.h"
#import "ParticipantRequestDataBuilder.h"

@interface YAConversationCreateRequestDataBuilderTests()

@property (strong, nonatomic) id participantsRequestDataBuilderMock;
@property (strong, nonatomic) id conversationHandlerMock;
@property (strong, nonatomic) id conversationMock;
@property (strong, nonatomic) id messageHandlerMock;
@property (strong, nonatomic) id messageMock;
@property (strong, nonatomic) id mutableDictionaryCreatorMock;
@property (strong, nonatomic) id mutableDictionaryMock;
@property (strong, nonatomic) id participantRequestDataBuilderMock;
@property (strong, nonatomic) id participantsMock;
@property (strong, nonatomic) id senderMock;
@property (strong, nonatomic) YAConversationCreateRequestDataBuilder *conversationCreateRequestDataBuilder;

@end

@implementation YAConversationCreateRequestDataBuilderTests

@synthesize participantsRequestDataBuilderMock = participantsRequestDataBuilderMock_;
@synthesize conversationHandlerMock = conversationHandlerMock_;
@synthesize conversationMock = conversationMock_;
@synthesize messageHandlerMock = messageHandleMock_;
@synthesize messageMock = messageMock_;
@synthesize mutableDictionaryCreatorMock = mutableDictionaryCreatorMock_;
@synthesize mutableDictionaryMock = mutableDictionaryMock_;
@synthesize participantRequestDataBuilderMock = participantRequestDataBuilderMock_;
@synthesize participantsMock = participantsMock_;
@synthesize senderMock = senderMock_;
@synthesize conversationCreateRequestDataBuilder = conversationCreateRequestDataBuilder_;

- (void)setUp
{
    [self setParticipantRequestDataBuilderMock:[OCMockObject mockForProtocol:@protocol(ParticipantRequestDataBuilder)]];
    [self setParticipantsRequestDataBuilderMock:[OCMockObject mockForProtocol:@protocol(ParticipantsRequestDataBuilder)]];
    [self setConversationHandlerMock:[OCMockObject mockForProtocol:@protocol(ConversationHandler)]];
    [self setConversationMock:[OCMockObject mockForClass:[YAConversation class]]];
    [self setMessageHandlerMock:[OCMockObject mockForProtocol:@protocol(MessageHandler)]];
    [self setMessageMock:[OCMockObject mockForClass:[YAMessage class]]];
    [self setMutableDictionaryCreatorMock:[OCMockObject mockForProtocol:@protocol(MutableDictionaryCreator)]];
    [self setMutableDictionaryMock:[OCMockObject mockForClass:[NSMutableDictionary class]]];
    [self setParticipantsMock:[OCMockObject mockForClass:[NSSet class]]];
    [self setSenderMock:[OCMockObject mockForClass:[YAParticipant class]]];

    [self setConversationCreateRequestDataBuilder:[[YAConversationCreateRequestDataBuilder alloc] init]];
    [[self conversationCreateRequestDataBuilder] setParticipantsRequestDataBuilder:[self participantsRequestDataBuilderMock]];
    [[self conversationCreateRequestDataBuilder] setConversationHandler:[self conversationHandlerMock]];
    [[self conversationCreateRequestDataBuilder] setMessageHandler:[self messageHandlerMock]];
    [[self conversationCreateRequestDataBuilder] setMutableDictionaryCreator:[self mutableDictionaryCreatorMock]];
    [[self conversationCreateRequestDataBuilder] setParticipantRequestDataBuilder:[self participantRequestDataBuilderMock]];
}

- (void)testCanBuildRequestDataWithCreatorInfoMessageBodyAndParticipants
{
    NSArray *participantsRequestData = [NSArray array];
    NSDictionary *creatorInfo = [NSDictionary dictionary];
    NSDictionary *requestData = nil;
    NSString *messageBody = @"msgbody";
    NSSet *messages = [NSSet setWithObject:[self messageMock]];
    
    [[[self mutableDictionaryMock] expect] setObject:creatorInfo forKey:@"creatorInfo"];
    [[[self mutableDictionaryMock] expect] setObject:messageBody forKey:@"message"];
    [[[self mutableDictionaryMock] expect] setObject:participantsRequestData forKey:@"participants"];
    
    [[[[self mutableDictionaryCreatorMock] expect] andReturn:[self mutableDictionaryMock]] mutableDictionaryWithCapacity:3];
    [[[[self conversationHandlerMock] expect] andReturn:[self senderMock]] senderForConversation:[self conversationMock]];
    [[[[self conversationHandlerMock] expect] andReturn:[self participantsMock]] participantsForConversation:[self conversationMock]];
    [[[[self conversationHandlerMock] expect] andReturn:messages] messagesForConversation:[self conversationMock]];
    
    [[[[self messageHandlerMock] expect] andReturn:messageBody] bodyForMessage:[self messageMock]];
    
    [[[[self participantRequestDataBuilderMock] expect] andReturn:creatorInfo] requestDataForParticipant:[self senderMock]];
    
    [[[[self participantsRequestDataBuilderMock] expect] andReturn:participantsRequestData] requestDataForParticipants:[self participantsMock]];
    
    requestData = [[self conversationCreateRequestDataBuilder] requestDataForConversation:[self conversationMock]];
    
    [[self conversationMock] verify];
    [[self messageMock] verify];
    [[self mutableDictionaryMock] verify];
    [[self mutableDictionaryCreatorMock] verify];
    [[self participantRequestDataBuilderMock] verify];
    [[self participantsRequestDataBuilderMock] verify];
}

@end
