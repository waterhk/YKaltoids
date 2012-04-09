//
//  YAConversationFlagMessagesRequestDataBuilderTests.m
//  altoids
//
//  Created by Anand Biligiri on 12/1/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAConversationFlagMessagesRequestDataBuilderTests.h"
#import "MutableDictionaryCreator.h"
#import "YAConversationFlagMessagesRequestDataBuilder.h"

@interface YAConversationFlagMessagesRequestDataBuilderTests()
@property (strong, nonatomic) id mutableDictionaryCreatorMock;
@property (strong, nonatomic) YAConversationFlagMessagesRequestDataBuilder *conversationFlagMessagesRequestDataBuilder;
@end

@implementation YAConversationFlagMessagesRequestDataBuilderTests
@synthesize mutableDictionaryCreatorMock = mutableDictionaryCreatorMock_;
@synthesize conversationFlagMessagesRequestDataBuilder = conversationFlagMessagesRequestDataBuilder_;

// All code under test must be linked into the Unit Test bundle
- (void)setUp
{
    mutableDictionaryCreatorMock_ = [OCMockObject mockForProtocol:@protocol(MutableDictionaryCreator)];

    conversationFlagMessagesRequestDataBuilder_ = [[YAConversationFlagMessagesRequestDataBuilder alloc] init];
    [conversationFlagMessagesRequestDataBuilder_ setMutableDictionaryCreator:[self mutableDictionaryCreatorMock]];
}

- (void)testBuildsFlagMessagesRequestData
{
    NSArray *messageIDs = [NSArray arrayWithObjects:@"1", @"2", @"3", nil];
    
    NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionaryWithCapacity:2];
    
    [[[[self mutableDictionaryCreatorMock] expect] andReturn:mutableDictionary] mutableDictionaryWithCapacity:2];
    
    STAssertNotNil([[self conversationFlagMessagesRequestDataBuilder] requestDataToFlagMessagesAsRead:messageIDs], @"Unexpected request data");
    
    STAssertEquals([[mutableDictionary allKeys] count] , 2u, @"Expected 2 keys");
    STAssertEqualObjects([mutableDictionary objectForKey:@"read"], [NSNumber numberWithBool:YES], @"Expecting \"read\" to be YES");
    STAssertEqualObjects(messageIDs, [mutableDictionary objectForKey:@"mids"], @"Expecting {1,2,3} for \"mids\"");
    
    [[self mutableDictionaryCreatorMock] verify];
}

@end
