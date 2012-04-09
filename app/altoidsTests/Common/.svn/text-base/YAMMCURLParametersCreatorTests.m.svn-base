//
//  YAMMCURLParametersCreatorTests.m
//  altoids
//
//  Created by Jon Herron on 9/30/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <OCMock/OCMock.h>
#import "YAConversation.h"
#import "YAMMCURLParametersCreator.h"
#import "YAMessage.h"
#import "MessageHandler.h"
#import "URLParameterEncoder.h"


@interface YAMMCURLParametersCreatorTests : SenTestCase

@property (strong, nonatomic) id conversationHandlerMock;
@property (strong, nonatomic) id conversationMock;
@property (strong, nonatomic) id messageHandlerMock;
@property (strong, nonatomic) id messageMock;
@property (strong, nonatomic) id urlParameterEncoderMock;
@property (strong, nonatomic) YAMMCURLParametersCreator *mmcURLParametersCreator;

- (void)validateParameters:(NSDictionary *)theParameters withConversationID:(NSString *)theConversationID;
- (void)validateParameters:(NSDictionary *)theParameters withMessageID:(NSString *)theMessageID messageDate:(NSDate *)theMessageDate;

@end

@implementation YAMMCURLParametersCreatorTests

@synthesize conversationHandlerMock = conversationHandlerMock_;
@synthesize conversationMock = conversationMock_;
@synthesize messageHandlerMock = messageHandlerMock_;
@synthesize messageMock = messageMock_;
@synthesize mmcURLParametersCreator = mmcURLParametersCreator_;
@synthesize urlParameterEncoderMock = urlParameterEncoderMock_;

- (void)setUp
{
    [self setConversationHandlerMock:[OCMockObject mockForProtocol:@protocol(ConversationHandler)]];
    [self setConversationMock:[OCMockObject mockForClass:[YAConversation class]]];
    [self setMessageHandlerMock:[OCMockObject mockForProtocol:@protocol(MessageHandler)]];
    [self setMessageMock:[OCMockObject mockForClass:[YAMessage class]]];
    [self setUrlParameterEncoderMock:[OCMockObject mockForProtocol:@protocol(URLParameterEncoder)]];

    [self setMmcURLParametersCreator:[[YAMMCURLParametersCreator alloc] init]];
    [[self mmcURLParametersCreator] setConversationHandler:[self conversationHandlerMock]];
    [[self mmcURLParametersCreator] setMessageHandler:[self messageHandlerMock]];
    [[self mmcURLParametersCreator] setUrlParameterEncoder:[self urlParameterEncoderMock]];
}

- (void)testCanCreateURLParametersToRetrieveConversationListFromGivenConversation
{
    NSDictionary *params = nil;
    NSString *conversationID = @"id";
    NSString *messageID = @"mid";
    NSDate *messageDate = [NSDate date];
    
    [[[[self messageHandlerMock] expect] andReturn:messageID] messageIDForMessage:[self messageMock]];
    [[[[self messageHandlerMock] expect] andReturn:messageDate] timestampForMessage:[self messageMock]];
    
    [[[[self conversationHandlerMock] expect] andReturn:conversationID] conversationIDForConversation:[self conversationMock]];
    [[[[self conversationHandlerMock] expect] andReturn:[self messageMock]] mostRecentMessageForConversation:[self conversationMock]];
    
    params = [[self mmcURLParametersCreator] urlParametersForConversationListFromConversation:[self conversationMock]];
    
    [self validateParameters:params withConversationID:conversationID];
    
    STAssertTrue([[params objectForKey:@"mid"] isEqualToString:messageID], @"Unexpected messageID");
    STAssertTrue([[params objectForKey:@"midDate"] doubleValue] == [messageDate timeIntervalSince1970], @"Unexpected messageDate");
    
    [[self conversationMock] verify];
    [[self messageMock] verify];
}

- (void)testCanCreateURLParametersToRetrieveConversationListFromMostRecentConversation
{
    NSDictionary *params = nil;
    
    params = [[self mmcURLParametersCreator] urlParametersForConversationListFromMostRecentConversation];
    
    [self validateParameters:params withConversationID:nil];
}

- (void)testCanCreateURLParametersToCreateConversation
{
    NSDictionary *params = [[self mmcURLParametersCreator] urlParametersForCreateConversation];
    
    STAssertTrue([[params objectForKey:@"rMsgFlds"] isEqualToString:@"snippet"], @"Unexpected rMsgFlds");
    STAssertTrue([[params objectForKey:@"action"] isEqualToString:@"createConv"], @"Unexpected action");
}

- (void)testCanCreateURLParametersToRetrieveConversationMessageListFromMostRecentMessage
{
    NSDictionary *params = [[self mmcURLParametersCreator] urlParametersForConversationMessageListFromMostRecentMessage];
    
    [self validateParameters:params withMessageID:nil messageDate:nil];
}

- (void)testCanCreateURLParametersToRetrieveConversationMessageListFromGivenMessage
{
    NSDate *timestamp = [NSDate date];
    NSString *messageID = @"messageID";
    NSDictionary *params = nil;
    
    [[[[self messageHandlerMock] expect] andReturn:messageID] messageIDForMessage:[self messageMock]];
    [[[[self messageHandlerMock] expect] andReturn:timestamp] timestampForMessage:[self messageMock]];
    [[[[self urlParameterEncoderMock] expect] andReturn:messageID] encodeURLParameter:messageID];
    params = [[self mmcURLParametersCreator] urlParametersForConversationMessageListFromMessage:[self messageMock]];
    
    [self validateParameters:params withMessageID:messageID messageDate:timestamp];
    
    [[self messageHandlerMock] verify];
    [[self messageMock] verify];
    [[self urlParameterEncoderMock] verify];
}

- (void)testCanCreateURLParametersToFlagMessageAsReadOrUnread
{
    NSDictionary *params = [[self mmcURLParametersCreator] urlParametersForFlaggingMessagesAsReadOrUnread];
    
    STAssertTrue([[params objectForKey:@"action"] isEqualToString:@"flagMsgsInConv"], @"Unexpected action");
}

- (void)testCanCreateURLParametersToReplyToConversation
{
    NSDictionary *params = [[self mmcURLParametersCreator] urlParametersForConversationReply];
    
    STAssertTrue([[params objectForKey:@"action"] isEqualToString:@"replyConv"], @"Unexpected action");
}

- (void)validateParameters:(NSDictionary *)theParameters withConversationID:(NSString *)theConversationID
{
    STAssertTrue([[theParameters objectForKey:@"numCids"] isEqualToString:@"11"], @"Unexpected number of cids");
    STAssertTrue([[theParameters objectForKey:@"numCInfos"] isEqualToString:@"10"], @"Unexpected number of cinfos");
    STAssertTrue([[theParameters objectForKey:@"rMsgFlds"] isEqualToString:@"snippet"], @"Unexpected rMsgFlds");
    
    if (theConversationID) 
    {
        STAssertTrue([[theParameters objectForKey:@"cid"] isEqualToString:theConversationID], @"Unexpected cid");
    }
    else
    {
        STAssertNil([theParameters objectForKey:@"cid"], @"Did not expect a cid");
    }
}

- (void)validateParameters:(NSDictionary *)theParameters withMessageID:(NSString *)theMessageID messageDate:(NSDate *)theMessageDate
{
    STAssertTrue([[theParameters objectForKey:@"numMInfos"] isEqualToString:@"10"], @"Unexpected numMInfos");
    STAssertTrue([[theParameters objectForKey:@"numMids"] isEqualToString:@"11"], @"Unexpected numMids");
    STAssertTrue([[theParameters objectForKey:@"rMsgFlds"] isEqualToString:@"flags"], @"Unexpected rMsgFlds");
    STAssertTrue([[theParameters objectForKey:@"mInfoFlds"] isEqualToString:@"flags"], @"Unexpected mInfoFlds");
    
    if (theMessageID) 
    {
        STAssertTrue([[theParameters objectForKey:@"mid"] isEqualToString:theMessageID], @"Unexpected messageID");
    }
    else
    {
        STAssertNil([theParameters objectForKey:@"mid"], @"Did not expect mid");
    }
    
    if (theMessageDate) 
    {
        STAssertTrue([[theParameters objectForKey:@"midDate"] isEqualToNumber:[NSNumber numberWithDouble:[theMessageDate timeIntervalSince1970]]], @"Unexpected messageDate");
    }
    else
    {
        STAssertNil([theParameters objectForKey:@"midDate"], @"Did not expect mid date");
    }
}

@end
