//
//  YAMessageSetToArrayOfMessageIDsConverterTests.m
//  altoids
//
//  Created by Jon Herron on 12/2/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAMessageSetToArrayOfMessageIDsConverterTests.h"
#import "YAMessageListToArrayOfMessageIDsConverter.h"
#import "MessageHandler.h"
#import "MutableArrayCreator.h"
#import "YAMessage.h"

@interface YAMessageSetToArrayOfMessageIDsConverterTests()

@property (strong, nonatomic) id messageHandlerMock;
@property (strong, nonatomic) id mutableArrayCreatorMock;
@property (strong, nonatomic) YAMessageListToArrayOfMessageIDsConverter *messageSetToArrayOfMessageIDsConverter;

@end

@implementation YAMessageSetToArrayOfMessageIDsConverterTests

@synthesize messageHandlerMock = messageHandlerMock_;
@synthesize mutableArrayCreatorMock = mutableArrayCreator_;
@synthesize messageSetToArrayOfMessageIDsConverter = messageSetToArrayOfMessageIDsConverter_;

- (void)setUp
{
    [self setMessageHandlerMock:[OCMockObject mockForProtocol:@protocol(MessageHandler)]];
    [self setMutableArrayCreatorMock:[OCMockObject mockForProtocol:@protocol(MutableArrayCreator)]];
    
    [self setMessageSetToArrayOfMessageIDsConverter:[[YAMessageListToArrayOfMessageIDsConverter alloc] init]];
    [[self messageSetToArrayOfMessageIDsConverter] setMutableArrayCreator:[self mutableArrayCreatorMock]];
    [[self messageSetToArrayOfMessageIDsConverter] setMessageHandler:[self messageHandlerMock]];
}

- (void)testIfGivenAnEmptySetOfMessagesAnEmptyArrayIsReturned
{
    NSSet *messages = [NSSet set];
    
    [[[self mutableArrayCreatorMock] expect] mutableArrayWithCapacity:0];
    
    [[self messageSetToArrayOfMessageIDsConverter] arrayOfMessageIDsFromSetOfMessages:messages];
    
    [[self mutableArrayCreatorMock] verify];
    [[self messageHandlerMock] verify];
}

- (void)testReturnsArrayOfMessageIDForEachMessageInGivenSet
{
    id messageMock1 = [OCMockObject mockForClass:[YAMessage class]];
    id messageMock2 = [OCMockObject mockForClass:[YAMessage class]];
    id messageMock3 = [OCMockObject mockForClass:[YAMessage class]];
    id messageIDs = [OCMockObject mockForClass:[NSMutableArray class]];
    NSString *mid1 = @"mid1";
    NSString *mid2 = @"mid2";
    NSString *mid3 = @"mid3";
    NSSet *messages = [NSSet setWithObjects:messageMock1, messageMock2, messageMock3, nil];
    
    [[[[self mutableArrayCreatorMock] expect] andReturn:messageIDs] mutableArrayWithCapacity:[messages count]];
    
    [[[[self messageHandlerMock] expect] andReturn:mid1] messageIDForMessage:messageMock1];
    [[[[self messageHandlerMock] expect] andReturn:mid2] messageIDForMessage:messageMock2];
    [[[[self messageHandlerMock] expect] andReturn:mid3] messageIDForMessage:messageMock3];
    
    [[messageIDs expect] addObject:mid1];
    [[messageIDs expect] addObject:mid2];
    [[messageIDs expect] addObject:mid3];
    
    
    [[self messageSetToArrayOfMessageIDsConverter] arrayOfMessageIDsFromSetOfMessages:messages];
    
    [[self mutableArrayCreatorMock] verify];
    [[self messageHandlerMock] verify];
    [messageIDs verify];
}

- (void)testIfSkipsMessagesWithoutMessageId
{
    id messageOneMock = [OCMockObject mockForClass:[YAMessage class]];
    id messageTwoMock = [OCMockObject mockForClass:[YAMessage class]];
    NSArray *messages = [NSArray arrayWithObjects:messageOneMock, messageTwoMock, nil];
    
    [[[[self messageHandlerMock] expect] andReturn:nil] messageIDForMessage:messageOneMock];
    [[[[self messageHandlerMock] expect] andReturn:@"mid2"] messageIDForMessage:messageTwoMock];
    
    id arrayMock = [OCMockObject mockForClass:[NSMutableArray class]];
    [[[[self mutableArrayCreatorMock] expect] andReturn:arrayMock] mutableArrayWithCapacity:[messages count]];
    
    [[arrayMock expect] addObject:@"mid2"];
    
    [[self messageSetToArrayOfMessageIDsConverter] arrayOfMessageIDsFromArrayOfMessages:messages];
    
    [[self messageHandlerMock] verify];
    [[self mutableArrayCreatorMock] verify];
    [arrayMock verify];
}

@end
