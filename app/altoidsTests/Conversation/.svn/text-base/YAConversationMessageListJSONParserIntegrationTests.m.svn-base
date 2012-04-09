//
//  YAConversationMessageListJSONParserIntegrationTests.m
//  altoids
//
//  Created by Jon Herron on 10/17/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <SBJson/SBJson.h>
#import "YAConversationMessageListJSONParserIntegrationTests.h"
#import "YAJSONParserForMutableResult.h"
#import "YAConversationMessageListJSONParser.h"

@interface YAConversationMessageListJSONParserIntegrationTests()

@property (strong, nonatomic) YAJSONParserForMutableResult *jsonParser;
@property (strong, nonatomic) YAConversationMessageListJSONParser *conversationMessageListJSONParser;

@end

@implementation YAConversationMessageListJSONParserIntegrationTests

@synthesize jsonParser = jsonParser_;
@synthesize conversationMessageListJSONParser = conversationMessageListJSONParser_;

- (void)setUp
{
    [self setJsonParser:[[YAJSONParserForMutableResult alloc] init]];
    [[self jsonParser] setSBJSONParser:[[SBJsonParser alloc] init]];
    
    [self setConversationMessageListJSONParser:[[YAConversationMessageListJSONParser alloc] init]];
    [[self conversationMessageListJSONParser] setJsonParserForMutableResult:[self jsonParser]];
}

- (void)testWillReparseEachMessageDataFieldWhenItContainsAnEmbeddedJSONStringLiteral
{
    NSString *jsonStringLiteral = @"{\"conversation\":{\"cid\":\"86399691609964/altoidsiosusr_us1@yahoo.com\",\"mgrData\":{\"created\":1318371078,\"participants\":[{\"address\":\"altoidsiosusr_us1\",\"addressType\":\"mmc\",\"created\":1318354669,\"creator\":1,\"firstname\":\"Dummy\",\"imageURL\":\"http://l.yimg.com/a/i/identity2/profile_192c.png\",\"lastname\":\"Dummy\",\"pid\":\"900ab9801d2f9ecee03dcca2377e59bd\"},{\"address\":\"14083498896\",\"addressType\":\"mmc\",\"created\":1318354669,\"creator\":0,\"firstname\":\"Ro\",\"imageURL\":\"http://a323.yahoofs.com/coreid/4e8e4791i108fzws101sp2/urM4bHI1aanv9TJsmIT3VtmqkDg-/58/t192.png?ciAa60QBDi2CZZQ_\",\"lastname\":\"Dude\",\"pid\":\"9f0e47c0cd7e274ec513943c4c8fa7e6\"}],\"sTopic\":\"testing again\"}},\"message\":{\"content\":\"testing again\"},\"operation\":\"conv-create\",\"sender\":{\"pid\":\"900ab9801d2f9ecee03dcca2377e59bd\"}}\n";
    NSString *conversationMessageResponse = [NSString stringWithFormat:@"{\"conversation\":{"
                                             "\"messages\":[{"
                                             "\"data\":{"
                                             "\"parts\":[{"
                                             "\"data\":%@"
                                             "}]}}]}}", jsonStringLiteral];
    
    NSDictionary *parsedResponse = [[self conversationMessageListJSONParser] parseJSONString:conversationMessageResponse];

    NSArray *messages = [parsedResponse valueForKeyPath:@"conversation.messages"];
    NSDictionary *message = [messages objectAtIndex:0];
    NSDictionary *messageDataPart = [[message valueForKeyPath:@"data.parts"] objectAtIndex:0];
    
    STAssertNotNil(parsedResponse, @"Unable to parse response");
    STAssertNotNil(messages, @"No messages for conversation");
    STAssertNotNil(message, @"No message at index 0");
    STAssertNotNil(messageDataPart, @"Nil message data parts");
    
    STAssertTrue([messageDataPart isKindOfClass:[NSDictionary class]], @"Did not reparse data field");
    
    NSDictionary *messageData = [messageDataPart objectForKey:@"data"];
    
    STAssertNotNil(messageData, @"Nil message data");
    
    STAssertNotNil([messageData objectForKey:@"conversation"], @"Unable to find conversation in message data");
    STAssertNotNil([messageData objectForKey:@"message"], @"Unable to find conversation in message data");
}

@end
