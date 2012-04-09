//
//  YAMessageGapDetectorTests.m
//  altoids
//
//  Created by Anand Biligiri on 11/3/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAMessage.h"
#import "YAMessageGapDetectorTests.h"
#import "YAMessageGapDetector.h"
#import "YAMessageInfo.h"

@interface YAMessageGapDetectorTests ()
@property (nonatomic, strong) id messageHandlerMock;
@property (nonatomic, strong) YAMessageGapDetector *messageGapDetector;
@end

@implementation YAMessageGapDetectorTests
@synthesize messageHandlerMock = messageHandlerMock_;
@synthesize messageGapDetector = messageGapDetector_;

// All code under test must be linked into the Unit Test bundle
- (void)setUp
{
    [super setUp];
    [self setMessageHandlerMock:[OCMockObject mockForProtocol:@protocol(MessageHandler)]];
    [self setMessageGapDetector:[[YAMessageGapDetector alloc] init]];
    [[self messageGapDetector] setMessageHandler:[self messageHandlerMock]];
}

- (void)testGapWithoutExistingMessages
{
    
    id serverMessageFirstMock = [OCMockObject mockForClass:[YAMessage class]];
    id serverMessageSecondMock = [OCMockObject mockForClass:[YAMessage class]];
    id serverMessageLastMock = [OCMockObject mockForClass:[YAMessage class]];
    
    [[[[self messageHandlerMock] expect] andReturn:[NSDate dateWithTimeIntervalSince1970:2]] timestampForMessage:serverMessageFirstMock];
    [[[[self messageHandlerMock] expect] andReturn:[NSDate dateWithTimeIntervalSince1970:1]] timestampForMessage:serverMessageSecondMock];
    [[[[self messageHandlerMock] expect] andReturn:[NSDate dateWithTimeIntervalSince1970:0]] timestampForMessage:serverMessageLastMock];
    
    id messageInfoMock = [OCMockObject mockForClass:[YAMessageInfo class]];
    NSSet *newMessages = [NSSet setWithObjects:serverMessageFirstMock, serverMessageSecondMock, serverMessageLastMock, nil];
    NSArray *messageInfos = [NSArray arrayWithObject:messageInfoMock];
    
    YAMessage *messageBeforeGap = [[self messageGapDetector] messageImmediatelyBeforePossibleGapWithExistingMessages:nil newMessages:newMessages
                                                                                       messageInfosWithIdOnly:messageInfos];
    STAssertEqualObjects(messageBeforeGap, serverMessageLastMock, @"Expecting messageBeforeGap to be serverMessageLastMock");
    [[self messageHandlerMock] verify];
}

- (void)testGapWithExistingNewAndMessageInfos
{
    id serverMessageFirstMock = [OCMockObject mockForClass:[YAMessage class]];
    id serverMessageSecondMock = [OCMockObject mockForClass:[YAMessage class]];
    id serverMessageLastMock = [OCMockObject mockForClass:[YAMessage class]];
    
    id existingMessageOneMock = [OCMockObject mockForClass:[YAMessage class]];
    id existingMessageTwoMock = [OCMockObject mockForClass:[YAMessage class]];
    id existingMessageThreeMock = [OCMockObject mockForClass:[YAMessage class]];
    
    id messageInfoMock = [OCMockObject mockForClass:[YAMessageInfo class]];
    [[[messageInfoMock expect] andReturn:@"S0"] messageID];

    [[[[self messageHandlerMock] expect] andReturn:[NSDate dateWithTimeIntervalSince1970:2]] timestampForMessage:existingMessageThreeMock];
    [[[[self messageHandlerMock] expect] andReturn:[NSDate dateWithTimeIntervalSince1970:0]] timestampForMessage:existingMessageOneMock];
    [[[[self messageHandlerMock] expect] andReturn:[NSDate dateWithTimeIntervalSince1970:1]] timestampForMessage:existingMessageTwoMock];

    [[[[self messageHandlerMock] expect] andReturn:[NSDate dateWithTimeIntervalSince1970:2]] timestampForMessage:existingMessageThreeMock];
    [[[[self messageHandlerMock] expect] andReturn:[NSDate dateWithTimeIntervalSince1970:0]] timestampForMessage:existingMessageOneMock];
    [[[[self messageHandlerMock] expect] andReturn:[NSDate dateWithTimeIntervalSince1970:1]] timestampForMessage:existingMessageTwoMock];

    [[[[self messageHandlerMock] expect] andReturn:@"E3"] messageIDForMessage:existingMessageThreeMock];
    [[[[self messageHandlerMock] expect] andReturn:@"E1"] messageIDForMessage:existingMessageOneMock];

    [[[[self messageHandlerMock] expect] andReturn:@"E1"] messageIDForMessage:existingMessageOneMock];
    [[[[self messageHandlerMock] expect] andReturn:@"E2"] messageIDForMessage:existingMessageTwoMock];
    [[[[self messageHandlerMock] expect] andReturn:@"E3"] messageIDForMessage:existingMessageThreeMock];
    
    NSSet *existingMessages = [NSSet setWithObjects:existingMessageThreeMock, existingMessageTwoMock, existingMessageOneMock, nil];
    NSSet *newMessages = [NSSet setWithObjects:serverMessageFirstMock, serverMessageSecondMock, serverMessageLastMock, nil];
    NSArray *messageInfos = [NSArray arrayWithObject:messageInfoMock];
    
    YAMessage *messageBeforeGap = [[self messageGapDetector] messageImmediatelyBeforePossibleGapWithExistingMessages:existingMessages newMessages:newMessages
                                                                                       messageInfosWithIdOnly:messageInfos];
    
    STAssertEqualObjects(messageBeforeGap, existingMessageThreeMock, @"Expecting messageBeforeGap to be existingMessageThreeMock");
    [messageInfoMock verify];
    [[self messageHandlerMock] verify];
    
}

- (void)testNoGapWithMessageInfoSameAsLastExistingMessage
{
    id serverMessageFirstMock = [OCMockObject mockForClass:[YAMessage class]];
    id serverMessageSecondMock = [OCMockObject mockForClass:[YAMessage class]];
    id serverMessageLastMock = [OCMockObject mockForClass:[YAMessage class]];
    
    id existingMessageOneMock = [OCMockObject mockForClass:[YAMessage class]];
    id existingMessageTwoMock = [OCMockObject mockForClass:[YAMessage class]];
    id existingMessageThreeMock = [OCMockObject mockForClass:[YAMessage class]];
    
    id messageInfoMock = [OCMockObject mockForClass:[YAMessageInfo class]];
    [[[messageInfoMock expect] andReturn:@"E3"] messageID];
    
    [[[[self messageHandlerMock] expect] andReturn:[NSDate dateWithTimeIntervalSince1970:0]] timestampForMessage:existingMessageOneMock]; 
    [[[[self messageHandlerMock] expect] andReturn:[NSDate dateWithTimeIntervalSince1970:1]] timestampForMessage:existingMessageTwoMock];
    [[[[self messageHandlerMock] expect] andReturn:[NSDate dateWithTimeIntervalSince1970:2]] timestampForMessage:existingMessageThreeMock];
    
    [[[[self messageHandlerMock] expect] andReturn:@"E3"] messageIDForMessage:existingMessageThreeMock];
    
    NSSet *existingMessages = [NSSet setWithObjects:existingMessageThreeMock, existingMessageTwoMock, existingMessageOneMock, nil];
    NSSet *newMessages = [NSSet setWithObjects:serverMessageFirstMock, serverMessageSecondMock, serverMessageLastMock, nil];
    NSArray *messageInfos = [NSArray arrayWithObject:messageInfoMock];
    
    YAMessage *messageBeforeGap = [[self messageGapDetector] messageImmediatelyBeforePossibleGapWithExistingMessages:existingMessages newMessages:newMessages
                                                                                       messageInfosWithIdOnly:messageInfos];
    
    STAssertNil(messageBeforeGap, @"Expecting messageBeforeGap to be nil");
    [messageInfoMock verify];
    [[self messageHandlerMock] verify];
}

- (void)testNoGapWithoutExistingMessages
{
    id serverMessageFirstMock = [OCMockObject mockForClass:[YAMessage class]];
    id serverMessageSecondMock = [OCMockObject mockForClass:[YAMessage class]];
    id serverMessageLastMock = [OCMockObject mockForClass:[YAMessage class]];
    
    NSSet *newMessages = [NSSet setWithObjects:serverMessageFirstMock, serverMessageSecondMock, serverMessageLastMock, nil];
    
    YAMessage *messageBeforeGap = [[self messageGapDetector] messageImmediatelyBeforePossibleGapWithExistingMessages:nil newMessages:newMessages
                                                                                       messageInfosWithIdOnly:nil];
    STAssertNil(messageBeforeGap, @"Expecting messageBeforeGap to be nil");
    [[self messageHandlerMock] verify];
}

- (void)testNoGapWithoutMessageInfos
{
    id serverMessageFirstMock = [OCMockObject mockForClass:[YAMessageInfo class]];
    id serverMessageSecondMock = [OCMockObject mockForClass:[YAMessageInfo class]];
    id serverMessageLastMock = [OCMockObject mockForClass:[YAMessageInfo class]];
    
    id existingMessageOneMock = [OCMockObject mockForClass:[YAMessage class]];
    id existingMessageTwoMock = [OCMockObject mockForClass:[YAMessage class]];
    id existingMessageThreeMock = [OCMockObject mockForClass:[YAMessage class]];
    
    NSSet *newMessages = [NSSet setWithObjects:serverMessageFirstMock, serverMessageSecondMock, serverMessageLastMock, nil];
    NSSet *existingMessages = [NSSet setWithObjects:existingMessageThreeMock, existingMessageTwoMock, existingMessageOneMock, nil];
    
    YAMessage *messageBeforeGap = [[self messageGapDetector] messageImmediatelyBeforePossibleGapWithExistingMessages:existingMessages newMessages:newMessages
                                                                                       messageInfosWithIdOnly:nil];
    STAssertNil(messageBeforeGap, @"Expecting messageBeforeGap to be nil");
    [[self messageHandlerMock] verify];
}
@end
