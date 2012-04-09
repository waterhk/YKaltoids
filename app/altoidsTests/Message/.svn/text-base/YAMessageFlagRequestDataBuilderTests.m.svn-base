//
//  YAMessageFlagRequestDataBuilderTests.m
//  altoids
//
//  Created by Jon Herron on 10/12/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAMessageFlagRequestDataBuilderTests.h"
#import "MessageHandler.h"
#import "MutableArrayCreator.h"
#import "MutableDictionaryCreator.h"
#import "YAMessage.h"
#import "YAMessageFlagRequestDataBuilder.h"

@interface YAMessageFlagRequestDataBuilderTests()

@property (strong, nonatomic) id mutableArrayMock;
@property (strong, nonatomic) id mutableDictionaryMock;
@property (strong, nonatomic) id messageHandlerMock;
@property (strong, nonatomic) id mutableArrayCreatorMock;
@property (strong, nonatomic) id mutableDictionaryCreatorMock;
@property (strong, nonatomic) YAMessageFlagRequestDataBuilder *messageFlagRequestDataBuilder;

- (void)validateRequestDataForFlaggingMessagesAsRead:(BOOL)theReadFlag;

@end

@implementation YAMessageFlagRequestDataBuilderTests

@synthesize mutableArrayMock = mutableArrayMock_;
@synthesize mutableDictionaryMock = mutableDictionaryMock_;
@synthesize messageHandlerMock = messageHandlerMock_;
@synthesize mutableArrayCreatorMock = mutableArrayCreatorMock_;
@synthesize mutableDictionaryCreatorMock = mutableDictionaryCreatorMock_;
@synthesize messageFlagRequestDataBuilder = messageFlagRequestDataBuilderMock_;

- (void)setUp
{
    [self setMutableArrayMock:[OCMockObject mockForClass:[NSMutableArray class]]];
    [self setMutableDictionaryMock:[OCMockObject mockForClass:[NSMutableDictionary class]]];
    
    [self setMessageHandlerMock:[OCMockObject mockForProtocol:@protocol(MessageHandler)]];
    [self setMutableArrayCreatorMock:[OCMockObject mockForProtocol:@protocol(MutableArrayCreator)]];
    [self setMutableDictionaryCreatorMock:[OCMockObject mockForProtocol:@protocol(MutableDictionaryCreator)]];
    
    [self setMessageFlagRequestDataBuilder:[[YAMessageFlagRequestDataBuilder alloc] initWithMessageHandler:[self messageHandlerMock] mutableArrayCreator:[self mutableArrayCreatorMock] mutableDictionaryCreator:[self mutableDictionaryCreatorMock]]];
}

- (void)testCanCreateRequestDataForFlaggingMessagesAsRead
{
    [self validateRequestDataForFlaggingMessagesAsRead:YES];
}

- (void)testCanCreateRequestDataForFlaggingMessagesAsUnread
{
    [self validateRequestDataForFlaggingMessagesAsRead:NO];
}

- (BOOL) isNSString__ { return NO; }    // see comment in validateRequestDataForFlaggingMessagesAsRead
- (void)validateRequestDataForFlaggingMessagesAsRead:(BOOL)theReadFlag
{
    id messageMock1 = [OCMockObject mockForClass:[YAMessage class]];
    id messageMock2 = [OCMockObject mockForClass:[YAMessage class]];
    id messageMock3 = [OCMockObject mockForClass:[YAMessage class]];
    NSString *messageID1 = @"mid1";
    NSString *messageID2 = @"mid2";
    NSString *messageID3 = @"mid3";
    NSArray *messages = [NSArray arrayWithObjects:messageMock1, messageMock2, messageMock3, nil];
    
    [[[[self messageHandlerMock] expect] andReturn:messageID1] messageIDForMessage:messageMock1];
    [[[[self messageHandlerMock] expect] andReturn:messageID2] messageIDForMessage:messageMock2];
    [[[[self messageHandlerMock] expect] andReturn:messageID3] messageIDForMessage:messageMock3];
    
    [[[self mutableArrayMock] expect] addObject:messageID1];
    [[[self mutableArrayMock] expect] addObject:messageID2];
    [[[self mutableArrayMock] expect] addObject:messageID3];
    [[[[self mutableArrayCreatorMock] expect] andReturn:[self mutableArrayMock]] mutableArrayWithCapacity:3];
    [[[self mutableArrayMock] stub] isNSString__];  // Cocoa is calling this from [NSMutableDictionary setObject:forKey:], so we must stub it to avoid an exception
    
    [[[self mutableDictionaryMock] expect] setObject:(theReadFlag ? @"True" : @"False") forKey:@"read"];
    
    [[[self mutableDictionaryMock] expect] setObject:[self mutableArrayMock] forKey:@"mids"];
    [[[[self mutableDictionaryCreatorMock] expect] andReturn:[self mutableDictionaryMock]] mutableDictionaryWithCapacity:2];
    
    STAssertEqualObjects([self mutableDictionaryMock], theReadFlag ? [[self messageFlagRequestDataBuilder] requestDataForFlaggingMessagesAsRead:messages] : [[self messageFlagRequestDataBuilder] requestDataForFlaggingMessagesAsUnread:messages], @"Unexpected requestData");
    
    [messageMock1 verify];
    [messageMock2 verify];
    [messageMock3 verify];
    [[self messageHandlerMock] verify];
    [[self mutableArrayMock] verify];
    [[self mutableDictionaryMock] verify];
    [[self mutableArrayCreatorMock] verify];
    [[self mutableDictionaryCreatorMock] verify];
}

@end
