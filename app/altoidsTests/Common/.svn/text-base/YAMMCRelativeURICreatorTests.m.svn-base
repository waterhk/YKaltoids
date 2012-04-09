//
//  YAMMCRelativeURICreatorTests.m
//  altoids
//
//  Created by Jon Herron on 10/11/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAMMCRelativeURICreatorTests.h"
#import "ConversationHandler.h"
#import "MMCURLParameterEncoder.h"
#import "YAConversation.h"
#import "YAMMCRelativeURICreator.h"

@interface YAMMCRelativeURICreatorTests()

@property (strong, nonatomic) id conversationHandlerMock;
@property (strong, nonatomic) id conversationMock;
@property (strong, nonatomic) id mmcURLParameterEncoderMock;
@property (strong, nonatomic) YAMMCRelativeURICreator *mmcRelativeURICreator;

@end

@implementation YAMMCRelativeURICreatorTests

@synthesize conversationHandlerMock = conversationHandlerMock_;
@synthesize conversationMock = conversationMock_;
@synthesize mmcURLParameterEncoderMock = mmcURLParameterEncoderMock_;
@synthesize mmcRelativeURICreator = mmcRelativeURICreator_;

- (void)setUp
{
    [self setConversationMock:[OCMockObject mockForClass:[YAConversation class]]];
    [self setConversationHandlerMock:[OCMockObject mockForProtocol:@protocol(ConversationHandler)]];
    [self setMmcURLParameterEncoderMock:[OCMockObject mockForProtocol:@protocol(MMCURLParameterEncoder)]];

    [self setMmcRelativeURICreator:[[YAMMCRelativeURICreator alloc] init]];
    [[self mmcRelativeURICreator] setConversationHandler:[self conversationHandlerMock]];
    [[self mmcRelativeURICreator] setMmcURLParameterEncoder:[self mmcURLParameterEncoderMock]];
}

- (void)testCanCreateMMCRelativeURIToCreateConversation
{
    NSString *expectedRelativeURI = @"mmc/services/v1/conversation";
    
    STAssertTrue([[[self mmcRelativeURICreator] createRelativeURIToCreateConversation] isEqualToString:expectedRelativeURI], @"Unexpected relative uri");
}

- (void)testCanCreateMMCRelativeURIToRetrieveConversations
{
    NSString *expectedRelativeURI = @"mmc/services/v1/conversations";
    
    STAssertTrue([[[self mmcRelativeURICreator] createRelativeURIToRetrieveConversations] isEqualToString:expectedRelativeURI], @"Unexpected relative uri");
}

- (void)testCanCreateMMCRelativeURIToRetrieveMessagesInConversation
{
    NSString *conversationID = @"convo_id";
    NSString *expectedRelativeURI = [NSString stringWithFormat:@"mmc/services/v1/conversation/%@/messages", conversationID];
    
    [[[[self conversationHandlerMock] expect] andReturn:conversationID] conversationIDForConversation:[self conversationMock]];
    
    [[[[self mmcURLParameterEncoderMock] expect] andReturn:conversationID] doubleEncodeURLParameterForMMC:conversationID];
    
    STAssertTrue([[[self mmcRelativeURICreator] createRelativeURIToRetrieveMessagesInConversation:[self conversationMock]] isEqualToString:expectedRelativeURI], @"Unexpected relative uri");
}

- (void)testCanCreateMMCRelativeURIToReplyToConversation
{
    NSString *conversationID = @"cid";
    NSString *expectedRelativeURI = [NSString stringWithFormat:@"mmc/services/v1/conversation/%@", conversationID];
    
    [[[[self conversationHandlerMock] expect] andReturn:conversationID] conversationIDForConversation:[self conversationMock]];
    [[[[self mmcURLParameterEncoderMock] expect] andReturn:conversationID] doubleEncodeURLParameterForMMC:conversationID];
    
    STAssertTrue([[[self mmcRelativeURICreator] createRelativeURIToReplyToConversation:[self conversationMock]] isEqualToString:expectedRelativeURI], @"Unexpected relative uri");
}

@end
