//
//  YAConversationListToDictionaryTransformerTests.m
//  altoids
//
//  Created by Jon Herron on 9/28/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAConversationListToDictionaryTransformerTests.h"
#import "MutableDictionaryCreator.h"
#import "ConversationHandler.h"
#import "YAConversationListToDictionaryTransformer.h"

@interface YAConversationListToDictionaryTransformerTests()

@property (strong, nonatomic) id mutableDictionaryMock;
@property (strong, nonatomic) id mutableDictionaryCreatorMock;
@property (strong, nonatomic) id conversationHandlerMock;
@property (strong, nonatomic) YAConversationListToDictionaryTransformer *conversationListToDictionaryTransformer;

@end

@implementation YAConversationListToDictionaryTransformerTests

@synthesize mutableDictionaryMock = mutableDictionaryMock_;
@synthesize mutableDictionaryCreatorMock = mutableDictionaryCreatorMock_;
@synthesize conversationHandlerMock = conversationHandlerMock_;
@synthesize conversationListToDictionaryTransformer = conversationListToDictionaryTransformer_;

- (void)setUp
{
    [super setUp];
    
    [self setMutableDictionaryMock:[OCMockObject mockForClass:[NSMutableDictionary class]]];
    [self setMutableDictionaryCreatorMock:[OCMockObject mockForProtocol:@protocol(MutableDictionaryCreator)]];
    [self setConversationHandlerMock:[OCMockObject mockForProtocol:@protocol(ConversationHandler)]];

    [self setConversationListToDictionaryTransformer:[[YAConversationListToDictionaryTransformer alloc] init]];
    [[self conversationListToDictionaryTransformer] setMutableDictionaryCreator:[self mutableDictionaryCreatorMock]];
    [[self conversationListToDictionaryTransformer] setConversationHandler:[self conversationHandlerMock]];
}

- (void)testTransformingAnEmptyArrayResultsInAnEmptyDictionary
{
    NSArray *conversationList = [NSArray array];
    NSUInteger capacity = [conversationList count];
    
    [[[[self mutableDictionaryCreatorMock] expect] andReturn:[self mutableDictionaryMock]] mutableDictionaryWithCapacity:capacity];
    
    [[self conversationListToDictionaryTransformer] transformConversationListToDictionary:conversationList];
    
    [[self mutableDictionaryMock] verify];
    [[self mutableDictionaryCreatorMock] verify];
}

- (void)testTransformingAnArrayOfConversationsResultsInDictionaryOfConversationsByConversationID
{
    id conversationMock1 = [OCMockObject mockForClass:[YAConversation class]];
    id conversationMock2 = [OCMockObject mockForClass:[YAConversation class]];
    id conversationMock3 = [OCMockObject mockForClass:[YAConversation class]];
    NSString *conversationMock1ID = @"id1";
    NSString *conversationMock2ID = @"id2";
    NSString *conversationMock3ID = @"id3";
    NSArray *conversationList = [NSArray arrayWithObjects:conversationMock1, conversationMock2, conversationMock3, nil];
    NSUInteger capacity = [conversationList count];
    
    [[[[self conversationHandlerMock] expect] andReturn:conversationMock1ID] conversationIDForConversation:conversationMock1];
    [[[[self conversationHandlerMock] expect] andReturn:conversationMock2ID] conversationIDForConversation:conversationMock2];
    [[[[self conversationHandlerMock] expect] andReturn:conversationMock3ID] conversationIDForConversation:conversationMock3];
    
    [[[self mutableDictionaryMock] expect] setObject:conversationMock1 forKey:conversationMock1ID];
    [[[self mutableDictionaryMock] expect] setObject:conversationMock2 forKey:conversationMock2ID];
    [[[self mutableDictionaryMock] expect] setObject:conversationMock3 forKey:conversationMock3ID];
    
    [[[[self mutableDictionaryCreatorMock] stub] andReturn:[self mutableDictionaryMock]] mutableDictionaryWithCapacity:capacity];
    
    [[self conversationListToDictionaryTransformer] transformConversationListToDictionary:conversationList];
    
    [[self conversationHandlerMock] verify];
    [[self mutableDictionaryMock] verify];
}

@end
