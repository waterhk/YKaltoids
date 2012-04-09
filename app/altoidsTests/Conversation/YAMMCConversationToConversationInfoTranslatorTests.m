//
//  YAMMCConversationToConversationInfoTranslatorTests.m
//  altoids
//
//  Created by Jon Herron on 9/20/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <OCMock/OCMock.h>
#import "MMCMessageToMessageInfoTranslator.h"
#import "MMCParticipantToParticipantInfoTranslator.h"
#import "YAConversationInfo.h"
#import "YAMMCConversation.h"
#import "YAMMCConversationToConversationInfoTranslator.h"
#import "YAMMCRecentMessage.h"
#import "YAMMCParticipant.h"
#import "YAMessageInfo.h"
#import "YAParticipantInfo.h"
#import "MutableArrayCreator.h"
#import "MutableDictionaryCreator.h"
#import "ArrayFilterer.h"

@interface YAMMCConversationToConversationInfoTranslatorTests : SenTestCase

@property (strong, nonatomic) id mmcConversationMock;
@property (strong, nonatomic) id mmcMessageToMessageInfoTranslatorMock;
@property (strong, nonatomic) id mmcMostRecentMessageMock;
@property (strong, nonatomic) id mmcParticipantToParticipantInfoTranslatorMock;
@property (strong, nonatomic) id mutableArrayCreatorMock;
@property (strong, nonatomic) id mutableDictionaryCreatorMock;
@property (strong, nonatomic) id arrayFiltererMock;
@property (strong, nonatomic) YAMMCConversationToConversationInfoTranslator *mmcConversationToConversationInfoTranslator;

@end

@implementation YAMMCConversationToConversationInfoTranslatorTests

@synthesize mmcConversationMock = mmcConversationMock_;
@synthesize mmcMessageToMessageInfoTranslatorMock = mmcMessageToMessageInfoTranslatorMock_;
@synthesize mmcConversationToConversationInfoTranslator = mmcConversationToConversationInfoTranslator_;
@synthesize mmcMostRecentMessageMock = mmcMostRecentMessageMock_;
@synthesize mmcParticipantToParticipantInfoTranslatorMock = mmcParticipantToParticipantInfoTranslatorMock_;
@synthesize mutableArrayCreatorMock = mutableArrayCreatorMock_;
@synthesize mutableDictionaryCreatorMock = mutableDictionaryCreatorMock_;
@synthesize arrayFiltererMock = arrayFiltererMock_;

- (void)setUp
{
    [self setMmcConversationMock:[OCMockObject mockForClass:[YAMMCConversation class]]];
    [self setMmcMessageToMessageInfoTranslatorMock:[OCMockObject mockForProtocol:@protocol(MMCMessageToMessageInfoTranslator)]];
    [self setMmcMostRecentMessageMock:[OCMockObject mockForClass:[YAMMCRecentMessage class]]];
    [self setMmcParticipantToParticipantInfoTranslatorMock:[OCMockObject mockForProtocol:@protocol(MMCParticipantToParticipantInfoTranslator)]];
    
    [self setMutableArrayCreatorMock:[OCMockObject mockForProtocol:@protocol(MutableArrayCreator)]];
    [self setMutableDictionaryCreatorMock:[OCMockObject mockForProtocol:@protocol(MutableDictionaryCreator)]];
    
    [self setArrayFiltererMock:[OCMockObject mockForProtocol:@protocol(ArrayFilterer)]];
    
    [self setMmcConversationToConversationInfoTranslator:[[YAMMCConversationToConversationInfoTranslator alloc] init]];
    [[self mmcConversationToConversationInfoTranslator] setMmcParticipantToParticipantInfoTranslator:[self mmcParticipantToParticipantInfoTranslatorMock]];
    [[self mmcConversationToConversationInfoTranslator] setMmcMessageToMessageInfoTranslator:[self mmcMessageToMessageInfoTranslatorMock]];
    [[self mmcConversationToConversationInfoTranslator] setMutableArrayCreator:[self mutableArrayCreatorMock]];
    [[self mmcConversationToConversationInfoTranslator] setMutableDictionaryCreator:[self mutableDictionaryCreatorMock]];
    [[self mmcConversationToConversationInfoTranslator] setArrayFilterer:[self arrayFiltererMock]];
}

- (void)testCanTranslateMMCConversationToConversationInfo
{
    NSString *conversationID = @"convID";
    NSString *sender = @"Msg Sender";
    NSString *topic = @"topic";
    NSNumber *totalMessages = [NSNumber numberWithInt:15];
    NSNumber *unreadMessages = [NSNumber numberWithInt:43];
    BOOL userIsParticipant = YES;
    
    id mmcParticipant1 = [OCMockObject mockForClass:[YAMMCParticipant class]];
    id mmcParticipant2 = [OCMockObject mockForClass:[YAMMCParticipant class]];
    id mmcParticipant3 = [OCMockObject mockForClass:[YAMMCParticipant class]];
    
    id participantInfo1 = [OCMockObject mockForClass:[YAParticipantInfo class]];
    id participantInfo2 = [OCMockObject mockForClass:[YAParticipantInfo class]];
    id participantInfo3 = [OCMockObject mockForClass:[YAParticipantInfo class]];
    
    BOOL mmcParticipant1IsConversationCreator = NO;
    BOOL mmcParticipant2IsConversationCreator = YES;
    BOOL mmcParticipant3IsConversationCreator = NO;
    
    NSArray *participants = [NSArray arrayWithObjects:mmcParticipant1, mmcParticipant2, mmcParticipant3, nil];
    
    NSDate *recentMessageTimestamp = [NSDate date];
    id mmcRecentMessageMock = [OCMockObject mockForClass:[YAMMCRecentMessage class]];
    id recentMessageInfoMock = [OCMockObject mockForClass:[YAMessageInfo class]];
    
    [[[mmcRecentMessageMock expect] andReturn:sender] sender];
    
    YAConversationInfo *conversationInfo = nil;
    NSMutableArray *participantInfos = [NSMutableArray array];
    
    [[[[self mutableArrayCreatorMock] expect] andReturn:participantInfos] mutableArrayWithCapacity:3];
    
    [[[[self arrayFiltererMock] expect] andReturn:[NSArray arrayWithObject:participantInfo2]] filterArray:participantInfos usingPredicate:OCMOCK_ANY];
    
    [[[[self mmcParticipantToParticipantInfoTranslatorMock] expect] andReturn:participantInfo1] participantInfoFromMMCParticipant:mmcParticipant1 withTransientID:OCMOCK_ANY];
    [[[[self mmcParticipantToParticipantInfoTranslatorMock] expect] andReturn:participantInfo2] participantInfoFromMMCParticipant:mmcParticipant2 withTransientID:OCMOCK_ANY];
    [[[[self mmcParticipantToParticipantInfoTranslatorMock] expect] andReturn:participantInfo3] participantInfoFromMMCParticipant:mmcParticipant3 withTransientID:OCMOCK_ANY];
    
    [[[mmcParticipant1 expect] andReturnValue:OCMOCK_VALUE(mmcParticipant1IsConversationCreator)] isConversationCreator];
    [[[mmcParticipant2 expect] andReturnValue:OCMOCK_VALUE(mmcParticipant2IsConversationCreator)] isConversationCreator];
    [[[mmcParticipant3 expect] andReturnValue:OCMOCK_VALUE(mmcParticipant3IsConversationCreator)] isConversationCreator];
    
    [[mmcParticipant1 stub] participantID];
    [[mmcParticipant2 stub] participantID];
    [[mmcParticipant3 stub] participantID];
    
    [[[[self mmcMessageToMessageInfoTranslatorMock] expect] andReturn:recentMessageInfoMock] messageInfoFromMMCRecentMessage:mmcRecentMessageMock withSender:participantInfo2];
    
    [(YAMessageInfo *)[[recentMessageInfoMock expect] andReturn:recentMessageTimestamp] timestamp];
    
    [[[[self mmcConversationMock] expect] andReturn:conversationID] conversationID];
    [[[[self mmcConversationMock] expect] andReturn:topic] topic];
    [[[[self mmcConversationMock] expect] andReturn:totalMessages] totalMessages];
    [[[[self mmcConversationMock] expect] andReturn:unreadMessages] unreadMessages];
    [[[[self mmcConversationMock] expect] andReturnValue:OCMOCK_VALUE(userIsParticipant)] userIsParticipant];
    [[[[self mmcConversationMock] expect] andReturn:participants] participants];
    [[[[self mmcConversationMock] expect] andReturn:mmcRecentMessageMock] recentMessage];
    [[[[self mmcConversationMock] expect] andReturn:nil] messages];
    [[[self mmcConversationMock] expect] participantIDToTransientIDMap];
    
    conversationInfo = [[self mmcConversationToConversationInfoTranslator] conversationInfoFromMMCConversation:[self mmcConversationMock]];
    
    STAssertTrue([[conversationInfo conversationID] isEqualToString:conversationID], @"Unexpected conversationID");
    STAssertTrue([conversationInfo status] == YAConversationStatusSaved, @"Unexpected status");
    STAssertTrue([[conversationInfo topic] isEqualToString:topic], @"Unexpected topic");
    STAssertTrue([[conversationInfo totalMessages] isEqualToNumber:totalMessages], @"Unexpected totalMessages");
    STAssertTrue([[conversationInfo unreadMessages] isEqualToNumber:unreadMessages], @"Unexpected unreadMessages");
    STAssertEqualObjects([[conversationInfo participantInfos] objectAtIndex:0], participantInfo1, @"Unexpected participantInfo1");
    STAssertEqualObjects([[conversationInfo participantInfos] objectAtIndex:1], participantInfo2, @"Unexpected participantInfo2");
    STAssertEqualObjects([[conversationInfo participantInfos] objectAtIndex:2], participantInfo3, @"Unexpected participantInfo3");
    STAssertEqualObjects([conversationInfo sender], [[conversationInfo participantInfos] objectAtIndex:1], @"Unexpected sender");
    STAssertEqualObjects([conversationInfo mostRecentMessageInfo], recentMessageInfoMock, @"Unexpected recent message");
    STAssertTrue([[conversationInfo timestamp] isEqualToDate:recentMessageTimestamp], @"Unexpected timestamp");
    
    [[self mmcConversationMock] verify];
}

- (void)testNamePartsForSenderOfMostRecentMessageWillReturnNilIfMostRecentMessageOrSenderIsNil
{
    STAssertNil([[self mmcConversationToConversationInfoTranslator] namePartsForSenderOfMostRecentMessage:nil], 
                @"Expected nil return for nil message");
    
    [[[self mmcMostRecentMessageMock] stub] sender];
    
    STAssertNil([[self mmcConversationToConversationInfoTranslator] namePartsForSenderOfMostRecentMessage:[self mmcMostRecentMessageMock]], 
                @"Expected nil return for nil message");
}

- (void)testNamePartsForSenderOfMostRecentMessageWillReturnArrayWithSenderIfSenderDoesNotContainSpaceCharacter
{
    NSString *sender = @"bob";
    
    [[[[self mmcMostRecentMessageMock] stub] andReturn:sender] sender];
    
    NSArray *nameParts = [[self mmcConversationToConversationInfoTranslator] namePartsForSenderOfMostRecentMessage:[self mmcMostRecentMessageMock]];
    
    STAssertTrue([nameParts count] == 1, @"Expected only one item in array");
    STAssertTrue([[nameParts objectAtIndex:0] isEqualToString:sender], @"Unexpected sender returned");
}

- (void)testNamePartsForSenderOfMostRecentMessageWillReturnArrayWithSenderIfSenderLastCharacterIsSpace
{
    NSString *sender = @"sender ";
    
    [[[[self mmcMostRecentMessageMock] stub] andReturn:sender] sender];
    
    NSArray *nameParts = [[self mmcConversationToConversationInfoTranslator] namePartsForSenderOfMostRecentMessage:[self mmcMostRecentMessageMock]];
    
    STAssertTrue([nameParts count] == 1, @"Expected only one item in array");
    STAssertTrue([[nameParts objectAtIndex:0] isEqualToString:sender], @"Unexpected sender returned");
}

- (void)testNamePartsForSenderOfMostRecentMessageWillReturnArrayWithFirstLastNameIfSenderContainsSpace
{
    NSString *firstName = @"fname";
    NSString *lastName = @"lname";
    NSString *sender = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    
    [[[[self mmcMostRecentMessageMock] stub] andReturn:sender] sender];
    
    NSArray *nameParts = [[self mmcConversationToConversationInfoTranslator] namePartsForSenderOfMostRecentMessage:[self mmcMostRecentMessageMock]];
    
    STAssertTrue([nameParts count] == 2, @"Expected two items in array");
    STAssertTrue([[nameParts objectAtIndex:0] isEqualToString:firstName], @"Unexpected first name returned");
    STAssertTrue([[nameParts objectAtIndex:1] isEqualToString:lastName], @"Unexpected last name returned");
}

- (void)testNamePartsForSenderOfMostRecentMessageWillReturnArrayWithFirstLastNameIfSenderContainsMoreThanOneSpace
{
    NSString *firstName = @"fname";
    NSString *lastName = @"lname and one more word";
    NSString *sender = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    
    [[[[self mmcMostRecentMessageMock] stub] andReturn:sender] sender];
    
    NSArray *nameParts = [[self mmcConversationToConversationInfoTranslator] namePartsForSenderOfMostRecentMessage:[self mmcMostRecentMessageMock]];
    
    STAssertTrue([nameParts count] == 2, @"Expected two items in array");
    STAssertTrue([[nameParts objectAtIndex:0] isEqualToString:firstName], @"Unexpected first name returned");
    STAssertTrue([[nameParts objectAtIndex:1] isEqualToString:lastName], @"Unexpected last name returned");
}

@end
