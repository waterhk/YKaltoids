//
//  YAConversationListParsedJSONResponseHandlerIntegrationTests.m
//  altoids
//
//  Created by Jon Herron on 9/17/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <SBJson/SBJson.h>
#import "YAConversationListParsedJSONResponseHandlerIntegrationTests.h"
#import "YAConversationListParsedJSONResponseHandler.h"
#import "YAJSONParser.h"

@interface YAConversationListParsedJSONResponseHandlerIntegrationTests()

@property (copy,   nonatomic) NSString *goodResponse;
@property (strong, nonatomic) YAConversationListParsedJSONResponseHandler *conversationListParsedJSONResponseHandler;
@property (strong, nonatomic) YAJSONParser *jsonParser;

- (void)loadSampleResponses;

@end

@implementation YAConversationListParsedJSONResponseHandlerIntegrationTests

@synthesize goodResponse = goodResponse_;
@synthesize conversationListParsedJSONResponseHandler = conversationListParsedJSONResponseHandler_;
@synthesize jsonParser = jsonParser_;

- (void)setUp
{
    [self setJsonParser:[[YAJSONParser alloc] init]];
    [[self jsonParser] setSBJSONParser:[[SBJsonParser alloc] init]];
    [self setConversationListParsedJSONResponseHandler:[[YAConversationListParsedJSONResponseHandler alloc] init]];
    
    [self loadSampleResponses];
}

- (void)loadSampleResponses
{
    //todo: need to share sample responses between tests
}

@end
