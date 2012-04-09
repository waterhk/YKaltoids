//
//  YAMMCMessageTests.m
//  altoids
//
//  Created by Jon Herron on 10/14/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <SBJson/SBJson.h>
#import "YAMMCMessageIntegrationTests.h"
#import "YAConversationMessageListJSONParser.h"
#import "YAJSONParserForMutableResult.h"
#import "YAMMCMessage.h"
#import "YAMMCParticipant.h"

@interface YAMMCMessageIntegrationTests()

@property (strong, nonatomic) YAConversationMessageListJSONParser *conversationMessageListJSONParser;
@property (strong, nonatomic) YAMMCMessage *mmcMessage;

- (NSString *)responseWithSingleMessageForAConversation;
- (NSString *)responseWithOneMessageAndOneMessageIdOnly;

@end

@implementation YAMMCMessageIntegrationTests

@synthesize conversationMessageListJSONParser = conversationMessageListJSONParser_;
@synthesize mmcMessage = mmcMessage_;

- (void)setUp
{
    YAJSONParserForMutableResult* jsonParserForMutableResult = [[YAJSONParserForMutableResult alloc] init];
    [jsonParserForMutableResult setSBJSONParser:[[SBJsonParser alloc] init]];
    
    [self setConversationMessageListJSONParser:[[YAConversationMessageListJSONParser alloc] init]];
    [[self conversationMessageListJSONParser] setJsonParserForMutableResult:jsonParserForMutableResult];
}

- (void)testCanParseResponseWhichHasSingleMesageForAConversation
{
    NSArray *messages = nil;
    NSString *response = [self responseWithSingleMessageForAConversation];
    NSDictionary *parsedMessage = nil;
    NSDictionary *parsedResponse = [[self conversationMessageListJSONParser] parseJSONString:response];
    YAMMCMessage *mmcMessage = nil;
    YAMMCParticipant *sender = nil;
    
    STAssertNotNil(parsedResponse, @"Unable to parse response");
    
    messages = [parsedResponse valueForKeyPath:@"conversation.messages"];
    
    STAssertTrue([messages count] == 1, @"Expected 1 message");
    
    parsedMessage = [messages objectAtIndex:0];
    mmcMessage = [[YAMMCMessage alloc] initWithParsedJSONMessageResponse:parsedMessage];
    
    STAssertTrue([[mmcMessage messageID] isEqualToString:@"1_0_AKLPjkQAAMvQTpR+7gvuCQzka1E"], @"Unexpted message ID");
    STAssertTrue([mmcMessage read], @"Unexpected read flag");
    STAssertTrue([[mmcMessage subject] isEqualToString:@"testing again"], @"Unexpected subject");
    STAssertTrue([[mmcMessage timestamp] timeIntervalSince1970] == 1318354670, @"Unexpected timestamp");
    STAssertTrue([[mmcMessage body] isEqualToString:@"testing again"], @"Unexpected body: %@", [mmcMessage body]);
    
    sender = [mmcMessage sender];
    STAssertTrue([[[mmcMessage sender] firstName] isEqualToString:@"Dummy"], @"Unexpected sender first name");
    STAssertTrue([[[mmcMessage sender] lastName] isEqualToString:@"Dummy"], @"Unexpected sender first name");
    
    STAssertNotNil(sender, @"Unexpected nil sender");
}

- (void)testCanParseResponseWhichHasOneMessageAndOneMessageIdOnly
{
    NSDictionary *parsedResponse = [[self conversationMessageListJSONParser] parseJSONString:[self responseWithOneMessageAndOneMessageIdOnly]];
    
    STAssertNotNil(parsedResponse, @"Unable to parse response");
    
    NSArray *messages = [parsedResponse valueForKeyPath:@"conversation.messages"];
    
    STAssertTrue([messages count] == 2, @"Expected 2 messages");
    
    NSDictionary *parsedMessage = [messages objectAtIndex:0];
    YAMMCMessage *mmcMessage = [[YAMMCMessage alloc] initWithParsedJSONMessageResponse:parsedMessage];
    
    STAssertTrue([[mmcMessage messageID] isEqualToString:@"1_0_AKLPjkQAAMvQTpR+7gvuCQzka1E"], @"Unexpted message ID");
    STAssertTrue([mmcMessage read], @"Unexpected read flag");
    STAssertTrue([[mmcMessage subject] isEqualToString:@"testing again"], @"Unexpected subject");
    STAssertTrue([[mmcMessage timestamp] timeIntervalSince1970] == 1318354670, @"Unexpected timestamp");
    STAssertTrue([[mmcMessage body] isEqualToString:@"testing again"], @"Unexpected body: %@", [mmcMessage body]);

    YAMMCParticipant *sender = [mmcMessage sender];
    STAssertTrue([[[mmcMessage sender] firstName] isEqualToString:@"Dummy"], @"Unexpected sender first name");
    STAssertTrue([[[mmcMessage sender] lastName] isEqualToString:@"Dummy"], @"Unexpected sender first name");
    
    STAssertNotNil(sender, @"Unexpected nil sender");
    STAssertEquals([mmcMessage isMessageIdOnly], NO, @"Expecting isMessageIdOnly to be NO");
    
    parsedMessage = [messages objectAtIndex:1];
    mmcMessage = [[YAMMCMessage alloc] initWithParsedJSONMessageResponse:parsedMessage];

    STAssertEqualObjects([mmcMessage messageID], @"1_0_AKLPjkQAAMvQTpR+7gvuCQzka1F", @"Unexpected messageID");
    STAssertEquals([mmcMessage isMessageIdOnly], YES, @"Expecting isMessageIdOnly to be YES");
    
    STAssertNil([mmcMessage subject], @"Unexpacted subject");
    STAssertEqualObjects([mmcMessage timestamp], [NSDate dateWithTimeIntervalSince1970:0], @"Unexpected timestamp");
    STAssertNil([mmcMessage body], @"Unexpected body");
    STAssertNil([mmcMessage sender], @"Unexpected sender");
}

- (NSString *)responseWithSingleMessageForAConversation
{
    return @"{"
    "  \"conversation\":{"
    "    \"cid\":\"86399691609964/altoidsiosusr_us1@yahoo.com\","
    "    \"summary\":{"
    "      \"totalMsgs\":1,"
    "      \"unreadMsgs\":0"
    "    },"
    "    \"messages\":["
    "      {"
    "        \"message\":{"
    "          \"mid\":\"1_0_AKLPjkQAAMvQTpR+7gvuCQzka1E\","
    "          \"flags\":{"
    "            \"isRead\":true"
    "          },"
    "          \"info\":{"
    "            \"subj\":\"testing again\","
    "            \"date\":1318354670,"
    "            \"from\":{"
    "              \"email\":\"86399691609964/altoidsiosusr_us1@yahoo.com\","
    "              \"name\":\"Dummy Dummy\""
    "            },"
    "            \"rcpts\":\"Dummy Dummy, Ro Dude\""
    "          },"
    "          \"data\":{"
    "            \"parts\":["
    "              {"
    "                \"partId\":\"text\","
    "                \"subtype\":\"json\","
    "                \"data\":\"{\\\"conversation\\\":{\\\"cid\\\":\\\"86399691609964/altoidsiosusr_us1@yahoo.com\\\",\\\"mgrData\\\":{\\\"created\\\":1318371078,\\\"participants\\\":[{\\\"address\\\":\\\"altoidsiosusr_us1\\\",\\\"addressType\\\":\\\"mmc\\\",\\\"created\\\":1318354669,\\\"creator\\\":1,\\\"firstname\\\":\\\"Dummy\\\",\\\"imageURL\\\":\\\"http://l.yimg.com/a/i/identity2/profile_192c.png\\\",\\\"lastname\\\":\\\"Dummy\\\",\\\"pid\\\":\\\"900ab9801d2f9ecee03dcca2377e59bd\\\"},{\\\"address\\\":\\\"14083498896\\\",\\\"addressType\\\":\\\"mmc\\\",\\\"created\\\":1318354669,\\\"creator\\\":0,\\\"firstname\\\":\\\"Ro\\\",\\\"imageURL\\\":\\\"http://a323.yahoofs.com/coreid/4e8e4791i108fzws101sp2/urM4bHI1aanv9TJsmIT3VtmqkDg-/58/t192.png?ciAa60QBDi2CZZQ_\\\",\\\"lastname\\\":\\\"Dude\\\",\\\"pid\\\":\\\"9f0e47c0cd7e274ec513943c4c8fa7e6\\\"}],\\\"sTopic\\\":\\\"testing again\\\"}},\\\"message\\\":{\\\"content\\\":\\\"testing again\\\"},\\\"operation\\\":\\\"conv-create\\\",\\\"sender\\\":{\\\"pid\\\":\\\"900ab9801d2f9ecee03dcca2377e59bd\\\"}}\\n\""
    "              }"
    "            ]"
    "          }"
    "        }"
    "      }"
    "    ]"
    "  }"
    "}";
}

- (NSString *)responseWithOneMessageAndOneMessageIdOnly
{
    return @"{"
    "  \"conversation\":{"
    "    \"cid\":\"86399691609964/altoidsiosusr_us1@yahoo.com\","
    "    \"summary\":{"
    "      \"totalMsgs\":1,"
    "      \"unreadMsgs\":0"
    "    },"
    "    \"messages\":["
    "      {"
    "        \"message\":{"
    "          \"mid\":\"1_0_AKLPjkQAAMvQTpR+7gvuCQzka1E\","
    "          \"flags\":{"
    "            \"isRead\":true"
    "          },"
    "          \"info\":{"
    "            \"subj\":\"testing again\","
    "            \"date\":1318354670,"
    "            \"from\":{"
    "              \"email\":\"86399691609964/altoidsiosusr_us1@yahoo.com\","
    "              \"name\":\"Dummy Dummy\""
    "            },"
    "            \"rcpts\":\"Dummy Dummy, Ro Dude\""
    "          },"
    "          \"data\":{"
    "            \"parts\":["
    "              {"
    "                \"partId\":\"text\","
    "                \"subtype\":\"json\","
    "                \"data\":\"{\\\"conversation\\\":{\\\"cid\\\":\\\"86399691609964/altoidsiosusr_us1@yahoo.com\\\",\\\"mgrData\\\":{\\\"created\\\":1318371078,\\\"participants\\\":[{\\\"address\\\":\\\"altoidsiosusr_us1\\\",\\\"addressType\\\":\\\"mmc\\\",\\\"created\\\":1318354669,\\\"creator\\\":1,\\\"firstname\\\":\\\"Dummy\\\",\\\"imageURL\\\":\\\"http://l.yimg.com/a/i/identity2/profile_192c.png\\\",\\\"lastname\\\":\\\"Dummy\\\",\\\"pid\\\":\\\"900ab9801d2f9ecee03dcca2377e59bd\\\"},{\\\"address\\\":\\\"14083498896\\\",\\\"addressType\\\":\\\"mmc\\\",\\\"created\\\":1318354669,\\\"creator\\\":0,\\\"firstname\\\":\\\"Ro\\\",\\\"imageURL\\\":\\\"http://a323.yahoofs.com/coreid/4e8e4791i108fzws101sp2/urM4bHI1aanv9TJsmIT3VtmqkDg-/58/t192.png?ciAa60QBDi2CZZQ_\\\",\\\"lastname\\\":\\\"Dude\\\",\\\"pid\\\":\\\"9f0e47c0cd7e274ec513943c4c8fa7e6\\\"}],\\\"sTopic\\\":\\\"testing again\\\"}},\\\"message\\\":{\\\"content\\\":\\\"testing again\\\"},\\\"operation\\\":\\\"conv-create\\\",\\\"sender\\\":{\\\"pid\\\":\\\"900ab9801d2f9ecee03dcca2377e59bd\\\"}}\\n\""
    "              }"
    "            ]"
    "          }"
    "        }"
    "      },"
    "      {"
    "       \"message\":{"
    "          \"mid\":\"1_0_AKLPjkQAAMvQTpR+7gvuCQzka1F\""
    "       }"
    "      }"
    "    ]"
    "  }"
    "}";

}
@end
