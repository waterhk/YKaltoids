//
//  YAMMCConversationsFacadeIntegrationTests.m
//  altoids
//
//  Created by Jon Herron on 9/17/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//
//  http://twiki.corp.yahoo.com/view/Devel/AltoidsiOSClientServerResponseFacades
//

#import <SBJson/SBJson.h>
#import "YAMMCConversationsIntegrationTests.h"
#import "YAJSONParser.h"
#import "YAMMCConversation.h"
#import "YAMMCConversations.h"

@interface YAMMCConversationsIntegrationTests()

@property (strong, nonatomic) SBJsonParser *sbJSONParser;
@property (strong, nonatomic) YAJSONParser *jsonParser;

- (YAMMCConversations *)facadeForJSONString:(NSString *)aJSONString;

- (NSString *)mostRecentConversationsSampleResponse;
- (NSString *)firstServerResponse;

@end

@implementation YAMMCConversationsIntegrationTests

@synthesize sbJSONParser = sbJSONParser_;
@synthesize jsonParser = jsonParser_;

- (void)setUp
{
    [self setSbJSONParser:[[SBJsonParser alloc] init]];
    [self setJsonParser:[[YAJSONParser alloc] init]];
    [[self jsonParser] setSBJSONParser:[self sbJSONParser]];
}

- (void)testFacadeWillReturnTrueForMoreConversationsAvailableOnServerIfMoreConvsPresentIsTrue
{
    NSString *json = @"{\"moreConvPresent\":true}";
    YAMMCConversations *facade = [self facadeForJSONString:json];
    
    STAssertTrue([facade moreConversationsAvailableOnServer], @"Expected more conversations available on server");
}

- (void)testFacadeWillReturnFalseForMoreConversationsAvailableOnServerIfMoreConvsPresentIsFalse
{
    NSString *json = @"{\"moreConvPresent\":false}";
    YAMMCConversations *facade = [self facadeForJSONString:json];

    STAssertFalse([facade moreConversationsAvailableOnServer], @"Expected more conversations available on server");
}

- (void)testFacadeWillReturnFalseForMoreConversationsAvailableOnServerIfMoreConvsPresentIsMissing
{
    NSString *json = @"{}";
    YAMMCConversations *facade = [self facadeForJSONString:json];
    
    STAssertFalse([facade moreConversationsAvailableOnServer], @"Expected more conversations available on server");
}

- (void)testFacadeWillReturnNilConversationsArrayIfConversationsAreMissing
{
    NSString *json = @"{}";
    YAMMCConversations *facade = [self facadeForJSONString:json];
    
    STAssertNil([facade conversations], @"Expected nil conversations");
}

- (void)testFacadeWillReturnEmptyConversationsArrayIfEmptyConversationsNodeIsReturned
{
    NSString *json = @"{\"conversations\":[]}";
    YAMMCConversations *facade = [self facadeForJSONString:json];
    
    NSArray *conversations = [facade conversations];
    
    STAssertNotNil(conversations, @"Expected non nil conversations");
    STAssertTrue([conversations count] == 0, @"Expected empty conversations array");
}

- (void)testFacadesConversationArrayHasCountEqualToNumberOfConversationNodesReturned
{
    YAMMCConversations *facade = [self facadeForJSONString:[self mostRecentConversationsSampleResponse]];
    
    NSArray *conversations = [facade conversations];
    NSUInteger conversationsCount = [conversations count];
    
    STAssertTrue(conversationsCount == 5, @"Expected 5 conversations in array, got %d", conversationsCount);
}

- (void)testFacadeForMostRecentConversationsSameplResponse
{
    YAMMCConversations *facade = [self facadeForJSONString:[self mostRecentConversationsSampleResponse]];
    
    NSArray *conversations = [facade conversations];
    NSUInteger conversationsCount = [conversations count];
    
    STAssertTrue([facade moreConversationsAvailableOnServer], @"Expected more conversations to be available on the server");
    STAssertTrue(conversationsCount == 5, @"Expected 5 conversations in array, got %d", conversationsCount);
    
    [conversations enumerateObjectsUsingBlock:^(id obj, NSUInteger index, BOOL *stop) {
        STAssertTrue([obj isKindOfClass:[YAMMCConversation class]], @"Unexpected type in conversations array"); 
    }];
    
    STAssertTrue([[[conversations objectAtIndex:0] conversationID] isEqualToString:@"123"], @"Unexpected conversation id @ index 0");
    STAssertTrue([[[conversations objectAtIndex:1] conversationID] isEqualToString:@"124"], @"Unexpected conversation id @ index 1");
    STAssertTrue([[[conversations objectAtIndex:2] conversationID] isEqualToString:@"125"], @"Unexpected conversation id @ index 2");
    STAssertTrue([[[conversations objectAtIndex:3] conversationID] isEqualToString:@"126"], @"Unexpected conversation id @ index 3");
    STAssertTrue([[[conversations objectAtIndex:4] conversationID] isEqualToString:@"127"], @"Unexpected conversation id @ index 4");
    
    STAssertTrue([[[facade conversationIDs] objectAtIndex:0] isEqualToString:@"123"], @"Unexpected conversationID 0");
    STAssertTrue([[[facade conversationIDs] objectAtIndex:1] isEqualToString:@"124"], @"Unexpected conversationID 1");
    STAssertTrue([[[facade conversationIDs] objectAtIndex:2] isEqualToString:@"125"], @"Unexpected conversationID 2");
    STAssertTrue([[[facade conversationIDs] objectAtIndex:3] isEqualToString:@"126"], @"Unexpected conversationID 3");
    STAssertTrue([[[facade conversationIDs] objectAtIndex:4] isEqualToString:@"127"], @"Unexpected conversationID 4");
}

- (void)testFacadeForFirstServerResponse
{
    YAMMCConversations *facade = [self facadeForJSONString:[self firstServerResponse]];
    
    NSArray *conversations = [facade conversations];
    NSUInteger conversationsCount = [conversations count];
    
    STAssertTrue([facade moreConversationsAvailableOnServer], @"Expected more conversations available on the server");
    STAssertTrue(conversationsCount == 10, @"Expected 10 conversations");
}

- (YAMMCConversations *)facadeForJSONString:(NSString *)aJSONString
{
    NSData *data = [aJSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *parsedData = [[self jsonParser] parseJSONData:data];
    
    STAssertNotNil(data, @"Unexpected nil data");
    STAssertNotNil(parsedData, @"Unexpected nil parsed data");
    
    return [[YAMMCConversations alloc] initWithParsedJSONConversationsResponse:parsedData];
}

- (NSString *)mostRecentConversationsSampleResponse
{
    return @"{"
    "  \"moreConvPresent\" : true,"
    "  \"conversations\" :"
    "  ["
    "    {"
    "      \"conversation\" : "
    "      {"
    "        \"cid\" : \"123\","
    "        \"summary\" :"
    "        {"
    "          \"totalMsgs\" : 25,"
    "          \"unreadMsgs\" : 12"
    "        },"
    "        \"mgrData\" :"
    "        {"
    "          \"participants\" : "
    "          ["
    "            {"
    "              \"pid\" : \"1\","
    "              \"firstname\" : \"Vivek\","
    "              \"lastname\" : \"Aggarwal\","
    "              \"created\" : 2131353245,"
    "              \"address\" : \"14081112222\","
    "              \"addressType\" : \"sms\","
    "              \"creator\": 0"
    "            },"
    "            {"
    "              \"pid\" : \"2\","
    "              \"firstname\" : \"Naveen\","
    "              \"lastname\" : \"Sanjeeva\","
    "              \"created\" : 213254325,"
    "              \"address\" : \"14081112223\","
    "              \"addressType\" : \"mmc\","
    "              \"creator\": 1,"
    "              \"isYou\": true"
    "            },"
    "            {"
    "              \"pid\" : \"3\","
    "              \"firstname\" : \"Amit\","
    "              \"lastname\" : \"Rao\","
    "              \"created\": 413545643,"
    "              \"address\" : \"14081112224\","
    "              \"addressType\" : \"sms\","
    "              \"creator\": 0"
    "            }"
    "          ],"
    "          \"topic\" : \"\","
    "          \"sTopic\" : \"server generated topic\""
    "        } , "
    "        \"recentMsg\" : "
    "        {"
    "          \"mid\" : \"1\","
    "          \"info\" : "
    "          {"
    "            \"subj\" : \"email subject\","
    "            \"date\" : 1224314,"
    "            \"rcpts\" : \"Vivek Aggarwa, Naveen Sanjeeva and You\","
    "            \"from\" : "
    "            {"
    "              \"name\" : \"Vivek Aggarwal\""
    "            },"
    "            \"snippet\" : \"Vivek deserves a break..\""
    "          }"
    "        }"
    "      }"
    "    },"
    "    {"
    "      \"conversation\" : "
    "      {"
    "        \"cid\" : \"124\","
    "        \"summary\" :"
    "        {"
    "          \"totalMsgs\" : 25,"
    "          \"unreadMsgs\" : 12"
    "        },"
    "        \"mgrData\" :"
    "        {"
    "          \"isParticipant\" : false "
    "        } ,"
    "        \"recentMsg\" : "
    "        {"
    "          \"mid\" : \"1\","
    "          \"info\" : "
    "          {"
    "            \"subj\" : \"email's subject\","
    "            \"date\" : 1224312344,"
    "            \"rcpts\" : \"Gitanjali Sheth, Ram Iyer and You\","
    "            \"from\" : "
    "            {"
    "              \"name\" : \"Ram Iyer\""
    "            },"
    "            \"snippet\" : \"Too much work!!\""
    "          }"
    "        }"
    "      }"
    "    },"
    "    {"
    "      \"conversation\" :"
    "      {"
    "        \"cid\" : \"125\","
    "        \"errors\" : "
    "        ["
    "          {"
    "            \"error\" :"
    "            {"
    "              \"code\" : 1234,"
    "              \"ns\" : \"mgr\","
    "              \"message\" : \"failed to query sherpa\""
    "            }"
    "          }"
    "        ]"
    "      }"
    "    },"
    "    {"
    "      \"conversation\" :"
    "      {"
    "        \"cid\" : \"126\""
    "      }"
    "    },"
    "    {"
    "      \"conversation\" :"
    "      {"
    "        \"cid\" : \"127\""
    "      }"
    "    }"
    "  ]  "
    "}";
}

- (NSString *)firstServerResponse
{
    return @"{\"moreConvPresent\":true,\"conversations\":[{\"conversation\":{\"cid\":\"86275850602635\\/altoidsiosusr_us1@yahoo.com\",\"summary\":{\"totalMsgs\":2,\"unreadMsgs\":1},\"mgrData\":{\"isParticipant\":false},\"recentMsg\":{\"mid\":\"1_0_AJfPjkQAARJOTneoLwpHIFmBOL8\",\"info\":{\"subj\":\"From iOS\",\"date\":1316466135,\"rcpts\":\"Dummy Dummy\",\"snippet\":\"Hey whatsup\",\"from\":{\"name\":\"4083498896\"}}}}},{\"conversation\":{\"cid\":\"86275918523874\\/altoidsiosusr_us1@yahoo.com\",\"summary\":{\"totalMsgs\":1,\"unreadMsgs\":0},\"mgrData\":{\"isParticipant\":false},\"recentMsg\":{\"mid\":\"1_0_AKLPjkQAABAaTnen5QzDECSVbRY\",\"info\":{\"subj\":\"from iOS, again!\",\"date\":1316466043,\"rcpts\":\"Droid User 2\",\"snippet\":\"from iOS, again!\",\"from\":{\"name\":\"Dummy Dummy\"}}}}},{\"conversation\":{\"cid\":\"86275864096921\\/altoidsiosusr_us1@yahoo.com\",\"summary\":{\"totalMsgs\":1,\"unreadMsgs\":0},\"mgrData\":{\"isParticipant\":false},\"recentMsg\":{\"mid\":\"1_0_AJfPjkQAAQGWTnelSg8Uwn3iFlc\",\"info\":{\"subj\":\"From iOS 5\",\"date\":1316465213,\"rcpts\":\"4083496894\",\"snippet\":\"From iOS 5\",\"from\":{\"name\":\"Dummy Dummy\"}}}}},{\"conversation\":{\"cid\":\"86275826246165\\/altoidsiosusr_us1@yahoo.com\",\"summary\":{\"totalMsgs\":1,\"unreadMsgs\":0},\"mgrData\":{\"isParticipant\":false},\"recentMsg\":{\"mid\":\"1_0_AKLPjkQAAOO2TnejegluuQG6kkE\",\"info\":{\"subj\":\"foo\",\"date\":1316464635,\"rcpts\":\"4083497005\",\"snippet\":\"foo\",\"from\":{\"name\":\"Dummy Dummy\"}}}}},{\"conversation\":{\"cid\":\"86275457797692\\/altoidsiosusr_us1@yahoo.com\",\"summary\":{\"totalMsgs\":2,\"unreadMsgs\":1},\"mgrData\":{\"isParticipant\":false},\"recentMsg\":{\"mid\":\"1_0_AKLPjkQAAWU9TneR2QXus3Ds3wc\",\"info\":{\"subj\":\"Hello world\",\"date\":1316459015,\"rcpts\":\"Dummy Dummy\",\"snippet\":\"\",\"from\":{\"name\":\"86275457797692\\/altoidsiosusr_us1@yahoo.com\"}}}}},{\"conversation\":{\"cid\":\"86275199846939\\/altoidsiosusr_us1@yahoo.com\",\"summary\":{\"totalMsgs\":1,\"unreadMsgs\":0},\"mgrData\":{\"isParticipant\":false},\"recentMsg\":{\"mid\":\"1_0_AJfPjkQAAPP9TneCMQ5Lswnz\\/+I\",\"info\":{\"subj\":\"Hello world!\",\"date\":1316455076,\"rcpts\":\"4083497005\",\"snippet\":\"Hello world!\",\"from\":{\"name\":\"Dummy Dummy\"}}}}},{\"conversation\":{\"cid\":\"86252678007101\\/altoidsiosusr_us1@yahoo.com\",\"summary\":{\"totalMsgs\":1,\"unreadMsgs\":0},\"mgrData\":{\"isParticipant\":false},\"recentMsg\":{\"mid\":\"1_0_AKLPjkQAADEMTnJC1wCJejvuHgk\",\"info\":{\"subj\":\"One more message\",\"date\":1316111421,\"rcpts\":\"4083497005\",\"snippet\":\"One more message\",\"from\":{\"name\":\"Dummy Dummy\"}}}}},{\"conversation\":{\"cid\":\"86252651458029\\/altoidsiosusr_us1@yahoo.com\",\"summary\":{\"totalMsgs\":1,\"unreadMsgs\":0},\"mgrData\":{\"isParticipant\":false},\"recentMsg\":{\"mid\":\"1_0_AJfPjkQAALHRTnJBkQOvT1JB3Eo\",\"info\":{\"subj\":\"Test message\",\"date\":1316111015,\"rcpts\":\"4083497005\",\"snippet\":\"Test message\",\"from\":{\"name\":\"Dummy Dummy\"}}}}},{\"conversation\":{\"cid\":\"86252619661747\\/altoidsiosusr_us1@yahoo.com\",\"summary\":{\"totalMsgs\":1,\"unreadMsgs\":0},\"mgrData\":{\"isParticipant\":false},\"recentMsg\":{\"mid\":\"1_0_AJfPjkQAAIj2TnJADAoKVnIKXP4\",\"info\":{\"subj\":\"Another test message\",\"date\":1316110531,\"rcpts\":\"4083497005\",\"snippet\":\"Another test message\",\"from\":{\"name\":\"Dummy Dummy\"}}}}},{\"conversation\":{\"cid\":\"86252534270862\\/altoidsiosusr_us1@yahoo.com\",\"summary\":{\"totalMsgs\":1,\"unreadMsgs\":0},\"mgrData\":{\"isParticipant\":false},\"recentMsg\":{\"mid\":\"1_0_AKLPjkQAAX5+TnI7awIejQ1ZALE\",\"info\":{\"subj\":\"Hi there\",\"date\":1316109227,\"rcpts\":\"4083497005\",\"snippet\":\"Hi there\",\"from\":{\"name\":\"Dummy Dummy\"}}}}}]}";
}

@end
