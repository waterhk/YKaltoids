//
//  YAConversationListDetailTextFormatter.m
//  altoids
//
//  Created by Jon Herron on 11/17/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "ConversationHandler.h"
#import "MessageHandler.h"
#import "ParticipantNameFormatter.h"
#import "YAConversation.h"
#import "YAMessage.h"
#import "YAParticipant.h"
#import "YAConversationListDetailTextFormatter.h"

#import <SenTestingKit/SenTestingKit.h>

@interface YAConversationListDetailTextFormatterTests : SenTestCase

@property (strong, nonatomic) id conversationMock;
@property (strong, nonatomic) id messageMock;
@property (strong, nonatomic) id participantMock;
@property (strong, nonatomic) id conversationHandlerMock;
@property (strong, nonatomic) id messageHandlerMock;
@property (strong, nonatomic) id participantNameFormatterMock;
@property (strong, nonatomic) YAConversationListDetailTextFormatter *conversationListDetailTextFormatter;

- (void)verifyMocks;

@end

@implementation YAConversationListDetailTextFormatterTests

@synthesize conversationMock = conversationMock_;
@synthesize messageMock = messageMock_;
@synthesize participantMock = participantMock_;
@synthesize conversationHandlerMock = conversationHandlerMock_;
@synthesize messageHandlerMock = messasgeHandlerMock_;
@synthesize participantNameFormatterMock = participantNameFormatterMock_;
@synthesize conversationListDetailTextFormatter = conversationListDetailTextFormatter_;

- (void)setUp
{
    [self setConversationMock:[OCMockObject mockForClass:[YAConversation class]]];
    [self setMessageMock:[OCMockObject mockForClass:[YAMessage class]]];
    [self setParticipantMock:[OCMockObject mockForClass:[YAParticipant class]]];
    [self setConversationHandlerMock:[OCMockObject mockForProtocol:@protocol(ConversationHandler)]];
    [self setMessageHandlerMock:[OCMockObject mockForProtocol:@protocol(MessageHandler)]];
    [self setParticipantNameFormatterMock:[OCMockObject mockForProtocol:@protocol(ParticipantNameFormatter)]];

    [self setConversationListDetailTextFormatter:[[YAConversationListDetailTextFormatter alloc] init]];
    [[self conversationListDetailTextFormatter] setConversationHandler:[self conversationHandlerMock]];
    [[self conversationListDetailTextFormatter] setMessageHandler:[self messageHandlerMock]];
    [[self conversationListDetailTextFormatter] setParticipantNameFormatter:[self participantNameFormatterMock]];
}

- (void)testSenderDisplayNameForConversationReturnsEmptyStringIfConversationDoesNotHaveMostRecentMessage
{
    NSString *detailText;
    
    [[[[self conversationHandlerMock] expect] andReturn:nil] mostRecentMessageForConversation:[self conversationMock]];
    
    detailText = [[self conversationListDetailTextFormatter] senderDisplayNameForConversation:[self conversationMock]];
    
    STAssertTrue([detailText isEqualToString:@""], @"Unexpected detailText returned");
    
    [self verifyMocks];
}

- (void)testSenderDisplayNameForConversationReturnsMostRecentMessageSenderShortNameIfAvailable
{
    NSString *detailText;
    NSString *expectedText;
    NSString *shortName = @"bob";
    
    [[[[self conversationHandlerMock] expect] andReturn:[self messageMock]] mostRecentMessageForConversation:[self conversationMock]];
    [[[[self messageHandlerMock] expect] andReturn:[self participantMock]] senderForMessage:[self messageMock]];
    [[[[self participantNameFormatterMock] expect] andReturn:shortName] formatShortNameForParticipant:[self participantMock]];
    
    detailText = [[self conversationListDetailTextFormatter] senderDisplayNameForConversation:[self conversationMock]];
    expectedText = [NSString stringWithFormat:@"%@: ", shortName];
    
    STAssertTrue([detailText isEqualToString:expectedText], @"Unexpected detail text");
    
    [self verifyMocks];
}

- (void)testSenderDisplayNameForConversationReturnsEmptyStringIfShortNameIsEmpty
{
    NSString *detailText;
    NSString *shortName = @"";
    
    [[[[self conversationHandlerMock] expect] andReturn:[self messageMock]] mostRecentMessageForConversation:[self conversationMock]];
    [[[[self messageHandlerMock] expect] andReturn:[self participantMock]] senderForMessage:[self messageMock]];
    [[[[self participantNameFormatterMock] expect] andReturn:shortName] formatShortNameForParticipant:[self participantMock]];
    
    detailText = [[self conversationListDetailTextFormatter] senderDisplayNameForConversation:[self conversationMock]];
    
    STAssertTrue([detailText isEqualToString:@""], @"Unexpected detail text");
    
    [self verifyMocks];
}

- (void)verifyMocks
{
    [[self conversationMock] verify];
    [[self messageMock] verify];
    [[self participantMock] verify];
    [[self conversationHandlerMock] verify];
    [[self messageHandlerMock] verify];
    [[self participantNameFormatterMock] verify];
}

@end
