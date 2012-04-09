//
//  YAConversationGapDetectorTests.m
//  altoids
//
//  Created by Jon Herron on 9/28/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//
//  http://twiki.corp.yahoo.com/view/Devel/AltoidsiOSClientConversationListGapHandling
//

#import <OCMock/OCMock.h>
#import "YAConversationGapDetectorTests.h"
#import "YAConversationGapDetector.h"
#import "YAConversation.h"
#import "ConversationHandler.h"

@interface YAConversationGapDetectorTests()

@property (strong, nonatomic) id conversationHandlerMock;
@property (strong, nonatomic) YAConversationGapDetector *conversationGapDetector;

@end

@implementation YAConversationGapDetectorTests

@synthesize conversationHandlerMock = conversationHandlerMock_;
@synthesize conversationGapDetector = conversationGapDetector_;

- (void)setUp
{
    [super setUp];
    
    [self setConversationHandlerMock:[OCMockObject mockForProtocol:@protocol(ConversationHandler)]];
    [self setConversationGapDetector:[[YAConversationGapDetector alloc] init]];
    [[self conversationGapDetector] setConversationHandler:[self conversationHandlerMock]];
}

- (void)testIfNoMoreConversationsExistOnTheServerDetectorReturnsNilIndicatingNoGap
{
    STAssertNil([[self conversationGapDetector] detectConversationImmediatelyBeforePossibleGapInConversationList:nil consideringExistingConversations:nil realizingMoreConversationsExistOnTheServer:NO], @"Expected nil conversation");
}

- (void)testIfConversationListIsEmptyDetectorReturnsNilIndicatingNoGap
{
    STAssertNil([[self conversationGapDetector] detectConversationImmediatelyBeforePossibleGapInConversationList:[NSArray array] consideringExistingConversations:nil realizingMoreConversationsExistOnTheServer:YES], @"Expected nil conversation");
}

- (void)testIfExistingConversationMatchesIDAndTimestampOfLastConversationFromServerDetectorReturnsNilIndicatingNoGap
{
    id conversationFromServerMock = [OCMockObject mockForClass:[YAConversation class]];
    id existingConversationMock = [OCMockObject mockForClass:[YAConversation class]];
    NSDate *conversationTimestamp = [NSDate date];
    NSString *conversationID = @"id";
    YAConversation *conversationBeforeGap = nil;
    
    NSArray *conversationsFromServer = [NSArray arrayWithObject:conversationFromServerMock];
    NSDictionary *existingConversations = [NSDictionary dictionaryWithObject:existingConversationMock forKey:conversationID];
    
    [[[[self conversationHandlerMock] expect] andReturn:conversationID] conversationIDForConversation:conversationFromServerMock];
    [[[[self conversationHandlerMock] expect] andReturn:conversationTimestamp] timestampForConversation:conversationFromServerMock];
    [[[[self conversationHandlerMock] expect] andReturn:conversationTimestamp] timestampForConversation:existingConversationMock];
    
    conversationBeforeGap = [[self conversationGapDetector] detectConversationImmediatelyBeforePossibleGapInConversationList:conversationsFromServer consideringExistingConversations:existingConversations realizingMoreConversationsExistOnTheServer:YES];
    
    STAssertNil(conversationBeforeGap, @"Expected nil conversation");
    
    [[self conversationHandlerMock] verify];
}

- (void)testIfLastConversationFromServerDoesNotExistLocallyDetectorReturnsLastConversationIndicatingGapPossibility
{
    id ignoreThisConversationNotLast = [OCMockObject mockForClass:[YAConversation class]];
    id ignoreThisConversationAlsoNotLast = [OCMockObject mockForClass:[YAConversation class]];
    id conversationFromServerMock = [OCMockObject mockForClass:[YAConversation class]];
    NSString *conversationID = @"id";
    
    NSArray *conversationsFromServer = [NSArray arrayWithObjects:ignoreThisConversationNotLast, ignoreThisConversationAlsoNotLast, conversationFromServerMock, nil];
    NSDictionary *existingConversations = [NSDictionary dictionary];
    
    [[[[self conversationHandlerMock] expect] andReturn:conversationID] conversationIDForConversation:conversationFromServerMock];
    
    STAssertEqualObjects(conversationFromServerMock, [[self conversationGapDetector] detectConversationImmediatelyBeforePossibleGapInConversationList:conversationsFromServer consideringExistingConversations:existingConversations realizingMoreConversationsExistOnTheServer:YES], @"Unexpected conversation returned");
    
    [[self conversationHandlerMock] verify];
}

- (void)testIfLastConversationFromServerExistsLocallyButTimestampsDifferDetectorReturnsLastConversationIndicatingGapPossibility
{
    id ignoreThisConversationNotLast = [OCMockObject mockForClass:[YAConversation class]];
    id ignoreThisConversationAlsoNotLast = [OCMockObject mockForClass:[YAConversation class]];
    id conversationFromServerMock = [OCMockObject mockForClass:[YAConversation class]];
    id existingConversationMock = [OCMockObject mockForClass:[YAConversation class]];
    NSDate *conversationFromServerTimestamp = [NSDate date];
    NSDate *existingConversationTimestamp = [NSDate dateWithTimeIntervalSince1970:1];
    NSString *conversationID = @"id";
    
    NSArray *conversationsFromServer = [NSArray arrayWithObjects:ignoreThisConversationNotLast, ignoreThisConversationAlsoNotLast, conversationFromServerMock, nil];
    NSDictionary *existingConversations = [NSDictionary dictionaryWithObject:existingConversationMock forKey:conversationID];
    
    [[[[self conversationHandlerMock] expect] andReturn:conversationID] conversationIDForConversation:conversationFromServerMock];
    [[[[self conversationHandlerMock] expect] andReturn:conversationFromServerTimestamp] timestampForConversation:conversationFromServerMock];
    [[[[self conversationHandlerMock] expect] andReturn:existingConversationTimestamp] timestampForConversation:existingConversationMock];
    
    STAssertEqualObjects(conversationFromServerMock, [[self conversationGapDetector] detectConversationImmediatelyBeforePossibleGapInConversationList:conversationsFromServer consideringExistingConversations:existingConversations realizingMoreConversationsExistOnTheServer:YES], @"Unexpected conversation returned");
    
    [[self conversationHandlerMock] verify];
}

@end
