//
//  YAParticipantAggregatorTests.m
//  altoids
//
//  Created by Jon Herron on 2/15/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import <SenTestingKit/SenTestingKit.h>
#import "MutableDictionaryCreator.h"
#import "YASMSAddressInfo.h"
#import "YAConversationInfo.h"
#import "YAParticipantAggregator.h"
#import "YAParticipantInfo.h"

@interface YAParticipantAggregatorTests : SenTestCase

@property (strong, nonatomic) id mutableDictionaryCreatorMock;
@property (strong, nonatomic) YAParticipantAggregator *participantAggregator;

- (YAConversationInfo *)conversationWithParticipants:(NSArray *)participants;
- (YAParticipantInfo *)participantWithAddressHandle:(NSString *)addressHandle;

@end

@implementation YAParticipantAggregatorTests

@synthesize mutableDictionaryCreatorMock = mutableDictionaryCreatorMock_;
@synthesize participantAggregator = participantAggregator_;

- (void)setUp
{
    mutableDictionaryCreatorMock_ = [OCMockObject mockForProtocol:@protocol(MutableDictionaryCreator)];
    participantAggregator_ = [[YAParticipantAggregator alloc] init];
    
    [participantAggregator_ setMutableDictionaryCreator:mutableDictionaryCreatorMock_];
}

- (void)testIfEmptyArrayOfConversationInfosIsProvidedAggregatorReturnsEmptyDictionary
{
    [[[mutableDictionaryCreatorMock_ expect] andReturn:[NSMutableDictionary dictionary]] mutableDictionaryWithCapacity:0];
    
    STAssertTrue([[participantAggregator_ participantInfosByAddressHandleInConverstationInfos:[NSArray array]] count] == 0, @"Expected empty dictionary");
    
    [[[mutableDictionaryCreatorMock_ expect] andReturn:[NSMutableDictionary dictionary]] mutableDictionaryWithCapacity:0];
    
    STAssertTrue([[participantAggregator_ participantInfosByAddressHandleInConverstationInfos:nil] count] == 0, @"Expected empty dictionary");
}

- (void)testWillAggregateParticipantsAcrossConversationsAndReturnThemByTheirAddressHandle
{
    NSString *handle1 = @"a";
    NSString *handle2 = @"b";
    NSString *handle3 = @"c";
    
    YAParticipantInfo *participant1 = [self participantWithAddressHandle:handle1];
    YAParticipantInfo *participant2 = [self participantWithAddressHandle:handle2];
    YAParticipantInfo *participant3 = [self participantWithAddressHandle:handle3];
    
    YAConversationInfo *convo1 = [self conversationWithParticipants:[NSArray arrayWithObject:participant1]];
    YAConversationInfo *convo2 = [self conversationWithParticipants:[NSArray arrayWithObject:participant2]];
    YAConversationInfo *convo3 = [self conversationWithParticipants:[NSArray arrayWithObject:participant3]];
    
    [[[mutableDictionaryCreatorMock_ stub] andReturn:[NSMutableDictionary dictionary]] mutableDictionaryWithCapacity:15];
    
    NSDictionary *aggregatedParticipants = [participantAggregator_ participantInfosByAddressHandleInConverstationInfos:[NSArray arrayWithObjects:convo1, convo2, convo3, nil]];
    
    STAssertEqualObjects(participant1, [aggregatedParticipants objectForKey:handle1], @"Incorrect participant for handle");
    STAssertEqualObjects(participant2, [aggregatedParticipants objectForKey:handle2], @"Incorrect participant for handle");
    STAssertEqualObjects(participant3, [aggregatedParticipants objectForKey:handle3], @"Incorrect participant for handle");
}

- (void)testWillUniqueAddressHandlesAcrossConversations
{
    NSString *handle = @"handle";
    
    YAParticipantInfo *participant1 = [self participantWithAddressHandle:handle];
    YAParticipantInfo *participant2 = [self participantWithAddressHandle:handle];
    YAParticipantInfo *participant3 = [self participantWithAddressHandle:handle];
    
    YAConversationInfo *convo1 = [self conversationWithParticipants:[NSArray arrayWithObject:participant1]];
    YAConversationInfo *convo2 = [self conversationWithParticipants:[NSArray arrayWithObjects:participant2, participant3, nil]];
    
    [[[mutableDictionaryCreatorMock_ stub] andReturn:[NSMutableDictionary dictionary]] mutableDictionaryWithCapacity:10];
    
    NSDictionary *aggregatedParticipants = [participantAggregator_ participantInfosByAddressHandleInConverstationInfos:[NSArray arrayWithObjects:convo1, convo2, nil]];
    
    STAssertTrue([aggregatedParticipants count] == 1, @"Expected only one handle");
    STAssertNotNil([aggregatedParticipants objectForKey:handle], @"Unexpected nil object");
}

- (YAConversationInfo *)conversationWithParticipants:(NSArray *)participants
{
    return [[YAConversationInfo alloc] initWithConversationID:nil 
                                                       status:0 
                                                    timestamp:nil 
                                                        topic:nil 
                                                totalMessages:nil 
                                               unreadMessages:nil 
                                      conversationContextInfo:nil 
                                                 messageInfos:nil 
                                             participantInfos:participants 
                                participantInfosByTransientID:nil 
                                                       sender:nil 
                                        mostRecentMessageInfo:nil 
                                            userIsParticipant:NO];
}

- (YAParticipantInfo *)participantWithAddressHandle:(NSString *)addressHandle
{
    return [[YAParticipantInfo alloc] initWithParticipantID:nil 
                                                  firstName:nil 
                                                   lastName:nil 
                                                   imageURL:nil 
                                                addressInfo:[[YASMSAddressInfo alloc] initWithYE164PhoneNumber:addressHandle] 
                                                  isContact:NO 
                                                  timestamp:nil 
                                      isConversationCreator:NO 
                                                     isUser:NO 
                                                transientID:nil];
}

@end
