//
//  YAMessageUpdaterTests.m
//  altoids
//
//  Created by Jon Herron on 11/16/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAMessageUpdaterTests.h"
#import "MessageHandler.h"
#import "YAMessage.h"
#import "YAMessageInfo.h"
#import "YAMessageUpdater.h"
#import "YAParticipant.h"

@interface YAMessageUpdaterTests()

@property (strong, nonatomic) id messageHandlerMock;
@property (strong, nonatomic) id messageMock;
@property (strong, nonatomic) id messageInfoMock;
@property (strong, nonatomic) id participantMock;
@property (strong, nonatomic) YAMessageUpdater *messageUpdater;

- (void)verifyMocks;

@end

@implementation YAMessageUpdaterTests

@synthesize messageHandlerMock = messageHandlerMock_;
@synthesize messageMock = messageMock_;
@synthesize messageInfoMock = messageInfoMock_;
@synthesize participantMock = participantMock_;
@synthesize messageUpdater = messageUpdater_;

- (void)setUp
{
    [self setMessageMock:[OCMockObject mockForClass:[YAMessage class]]];
    [self setMessageInfoMock:[OCMockObject mockForClass:[YAMessageInfo class]]];
    [self setParticipantMock:[OCMockObject mockForClass:[YAParticipant class]]];
    [self setMessageHandlerMock:[OCMockObject mockForProtocol:@protocol(MessageHandler)]];

    [self setMessageUpdater:[[YAMessageUpdater alloc] init]];
    [[self messageUpdater] setMessageHandler:[self messageHandlerMock]];
}

- (void)testUpdatesMIDOnlyBySettingsMessageIDAndStatus
{
    BOOL isMIDOnly = YES;
    NSString *messageID = @"mid";
    
    [[[[self messageInfoMock] expect] andReturn:messageID] messageID];
    [[[[self messageInfoMock] expect] andReturnValue:OCMOCK_VALUE(isMIDOnly)] isMessageIdOnly];
    
    [[[self messageHandlerMock] expect] setMessageID:messageID forMessage:[self messageMock]];
    [[[self messageHandlerMock] expect] setRead:YES forMessage:[self messageMock]];
    [[[self messageHandlerMock] expect] setStatusAsGapPlaceholderForMessage:[self messageMock]];
    
    [[self messageUpdater] updateMessage:[self messageMock] fromMessageInfo:[self messageInfoMock] withSender:nil];
    
    [self verifyMocks];
}

- (void)testUpdatesSystemMessagesWithStatusAndSystemMessageAsBody
{
    BOOL isSystemMessage = YES;
    BOOL read = YES;
    NSString *messageID = @"mid";
    NSString *systemMessage = @"sysmsg";
    NSString *snippet = @"snippet";
    NSDate *timestamp = [NSDate date];
    
    [[[self messageInfoMock] stub] isMessageIdOnly];
    
    [[[[self messageInfoMock] expect] andReturn:messageID] messageID];
    [[[[self messageInfoMock] expect] andReturnValue:OCMOCK_VALUE(isSystemMessage)] isSystemMessage];
    [[[[self messageInfoMock] expect] andReturn:systemMessage] systemMessage];
    [(YAMessageInfo *)[[[self messageInfoMock] expect] andReturnValue:OCMOCK_VALUE(read)] read];
    [[[[self messageInfoMock] expect] andReturn:snippet] snippet];
    [(YAMessageInfo *)[[[self messageInfoMock] expect] andReturn:timestamp] timestamp];
    
    [[[self messageHandlerMock] expect] setMessageID:messageID forMessage:[self messageMock]];
    [[[self messageHandlerMock] expect] setStatusAsSystemMessageForMessage:[self messageMock]];
    [[[self messageHandlerMock] expect] setBody:systemMessage forMessage:[self messageMock]];
    [[[self messageHandlerMock] expect] setRead:read forMessage:[self messageMock]];
    [[[self messageHandlerMock] expect] setSnippet:snippet forMessage:[self messageMock]];
    [[[self messageHandlerMock] expect] setTimestamp:timestamp forMessage:[self messageMock]];
    [[[self messageHandlerMock] expect] setParticipantAsSender:[self participantMock] ofMessage:[self messageMock]];
    
    [[self messageUpdater] updateMessage:[self messageMock] fromMessageInfo:[self messageInfoMock] withSender:[self participantMock]];
    
    [self verifyMocks];
}

- (void)testUpdatesRegularMessagesFromMessageInfo
{
    BOOL read = YES;
    NSString *messageID = @"mid";
    NSString *messageBody = @"msgbody";
    NSString *snippet = @"snippet";
    NSDate *timestamp = [NSDate date];
    
    [[[self messageInfoMock] stub] isMessageIdOnly];
    [[[self messageInfoMock] stub] isSystemMessage];
    
    [[[[self messageInfoMock] expect] andReturn:messageID] messageID];
    [[[[self messageInfoMock] expect] andReturn:messageBody] body];
    [(YAMessageInfo *)[[[self messageInfoMock] expect] andReturnValue:OCMOCK_VALUE(read)] read];
    [[[[self messageInfoMock] expect] andReturn:snippet] snippet];
    [(YAMessageInfo *)[[[self messageInfoMock] expect] andReturn:timestamp] timestamp];
    
    [[[self messageHandlerMock] expect] setMessageID:messageID forMessage:[self messageMock]];
    [[[self messageHandlerMock] expect] setBody:messageBody forMessage:[self messageMock]];
    [[[self messageHandlerMock] expect] setRead:read forMessage:[self messageMock]];
    [[[self messageHandlerMock] expect] setSnippet:snippet forMessage:[self messageMock]];
    [[[self messageHandlerMock] expect] setTimestamp:timestamp forMessage:[self messageMock]];
    [[[self messageHandlerMock] expect] setParticipantAsSender:[self participantMock] ofMessage:[self messageMock]];
    
    [[self messageUpdater] updateMessage:[self messageMock] fromMessageInfo:[self messageInfoMock] withSender:[self participantMock]];
    
    [self verifyMocks];
}

- (void)verifyMocks
{
    [[self messageMock] verify];
    [[self messageInfoMock] verify];
    [[self messageHandlerMock] verify];
    [[self participantMock] verify];
}

@end
