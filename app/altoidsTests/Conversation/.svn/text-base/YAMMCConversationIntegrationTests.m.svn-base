//
//  YAMMCConversationIntegrationTests.m
//  altoids
//
//  Created by Jon Herron on 9/18/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//
//  http://twiki.corp.yahoo.com/view/Devel/AltoidsiOSClientServerResponseFacades
//

#import <SBJson/SBJson.h>
#import "YAMMCConversationIntegrationTests.h"
#import "YAJSONParser.h"
#import "YAMMCConversation.h"
#import "YAMMCParticipant.h"
#import "YAMMCRecentMessage.h"

@interface YAMMCConversationIntegrationTests()

@property (strong, nonatomic) SBJsonParser *sbJSONParser;
@property (strong, nonatomic) YAJSONParser *jsonParser;

- (YAMMCConversation *)facadeForJSONString:(NSString *)aJSONString;

- (NSString *)fullConversationSampleResponse;
- (NSString *)conversationWithErrorSampleResponse;
- (NSString *)conversationWhereUserIsNotParticipantSampleResponse;
- (NSString *)conversationIDOnlySampleResponse;

- (NSString *)firstServerResponseConversation1;
- (NSString *)firstServerResponseConversation2;
- (NSString *)firstServerResponseConversation3;
- (NSString *)firstServerResponseConversation4;
- (NSString *)firstServerResponseConversation5;
- (NSString *)firstServerResponseConversation6;
- (NSString *)firstServerResponseConversation7;
- (NSString *)firstServerResponseConversation8;
- (NSString *)firstServerResponseConversation9;
- (NSString *)firstServerResponseConversation10;

- (void)validateFacadeForResponse:(NSString *)theResponse hasConversationID:(NSString *)expectedConversationID totalMessages:(NSUInteger)expectedTotalMessages unreadMessages:(NSUInteger)expectedUnreadMessages userIsParticipant:(BOOL)expectedUserIsParticipant recentMessageMessageID:(NSString *)expectedRecentMessageMessageID;

@end

@implementation YAMMCConversationIntegrationTests

@synthesize sbJSONParser = sbJSONParser_;
@synthesize jsonParser = jsonParser_;

- (void)setUp
{
    [self setSbJSONParser:[[SBJsonParser alloc] init]];
    [self setJsonParser:[[YAJSONParser alloc] init]];
    [[self jsonParser] setSBJSONParser:[self sbJSONParser]];
}

- (void)testFacadeForFullSampleResponse
{
    YAMMCConversation *facade = [self facadeForJSONString:[self fullConversationSampleResponse]];
    
    STAssertTrue([facade userIsParticipant], @"Expected user to be participant");
    STAssertTrue([[facade conversationID] isEqualToString:@"123"], @"Unexpected conversation id");
    STAssertTrue([[facade topic] isEqualToString:@"server generated topic"], @"Unexpected topic");
    STAssertTrue([[facade totalMessages] intValue] == 25, @"Unexpected total messages");
    STAssertTrue([[facade unreadMessages] intValue] == 12, @"Unexpected unread messages");
    
    NSArray *participants = [facade participants];
    
    STAssertNotNil(participants, @"Unexpected nil participants");
    STAssertTrue([participants count] == 3, @"Unexpected number of participants");
    
    [participants enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        STAssertTrue([obj isKindOfClass:[YAMMCParticipant class]], @"Unexpected type in participants array");
    }];
    
    STAssertTrue([[[participants objectAtIndex:0] participantID] isEqualToString:@"1"], @"Unexpected participantID");
    STAssertTrue([[[participants objectAtIndex:1] participantID] isEqualToString:@"2"], @"Unexpected participantID");
    STAssertTrue([[[participants objectAtIndex:2] participantID] isEqualToString:@"3"], @"Unexpected participantID");
    
    STAssertNotNil([facade recentMessage], @"Unexpected nil recent message");
    STAssertTrue([[[facade recentMessage] messageID] isEqualToString:@"1"], @"Unexpected messageID");
}

- (void)testFacadeForConversationWithErrorSampleResponse
{
    YAMMCConversation *facade = [self facadeForJSONString:[self conversationWithErrorSampleResponse]];
    
    STAssertTrue([[facade conversationID] isEqualToString:@"125"], @"Unexpected conversationID");
    STAssertNotNil([facade errors], @"Unexpected nil errors");
    STAssertTrue([[facade errors] count] == 1, @"Expected 1 error");
    
    NSError *error = [[facade errors] objectAtIndex:0];
    
    STAssertNotNil(error, @"Unexpected nil error");
    STAssertTrue([error code] == 1234, @"Unexpected error code");
    STAssertTrue([[error domain] isEqualToString:@"mgr"], @"Unexpected error code");
    STAssertTrue([[error localizedDescription] isEqualToString:@"failed to query sherpa"], @"Unexpected error message");
}

- (void)testFacadeForConversationWhereUserIsNotParticipantSampleResponse
{
    [self validateFacadeForResponse:[self conversationWhereUserIsNotParticipantSampleResponse] hasConversationID:@"124" totalMessages:25 unreadMessages:12 userIsParticipant:NO recentMessageMessageID:@"1"];
}

- (void)testFacadeForConversationIDOnlySampleResponse
{
    YAMMCConversation *facade = [self facadeForJSONString:[self conversationIDOnlySampleResponse]];
    
    STAssertTrue([[facade conversationID] isEqualToString:@"126"], @"Unexpected conversationID");
}

- (void)testFacadeForFirstServerResponseConversation1
{
    [self validateFacadeForResponse:[self firstServerResponseConversation1] hasConversationID:@"86275850602635/altoidsiosusr_us1@yahoo.com" totalMessages:2 unreadMessages:1 userIsParticipant:NO recentMessageMessageID:@"1_0_AJfPjkQAARJOTneoLwpHIFmBOL8"];
}

- (void)testFacadeForFirstServerResponseConversation2
{
    [self validateFacadeForResponse:[self firstServerResponseConversation2] hasConversationID:@"86275918523874/altoidsiosusr_us1@yahoo.com" totalMessages:1 unreadMessages:0 userIsParticipant:NO recentMessageMessageID:@"1_0_AKLPjkQAABAaTnen5QzDECSbRY"];
}

- (void)testFacadeForFirstServerResponseConversation3
{
    [self validateFacadeForResponse:[self firstServerResponseConversation3] hasConversationID:@"86275864096921/altoidsiosusr_us1@yahoo.com" totalMessages:1 unreadMessages:0 userIsParticipant:NO recentMessageMessageID:@"1_0_AJfPjkQAAQGWTnelSg8Uwn3iFlc"];
}

- (void)testFacadeForFirstServerResponseConversation4
{
    [self validateFacadeForResponse:[self firstServerResponseConversation4] hasConversationID:@"86275826246165/altoidsiosusr_us1@yahoo.com" totalMessages:1 unreadMessages:0 userIsParticipant:NO recentMessageMessageID:@"1_0_AKLPjkQAAOO2TnejegluuQG6kkE"];
}

- (void)testFacadeForFirstServerResponseConversation5
{
    [self validateFacadeForResponse:[self firstServerResponseConversation5] hasConversationID:@"86275457797692/altoidsiosusr_us1@yahoo.com" totalMessages:2 unreadMessages:1 userIsParticipant:NO recentMessageMessageID:@"1_0_AKLPjkQAAWU9TneR2QXus3Ds3wc"];
}

- (void)testFacadeForFirstServerResponseConversation6
{
    [self validateFacadeForResponse:[self firstServerResponseConversation6] hasConversationID:@"86275199846939/altoidsiosusr_us1@yahoo.com" totalMessages:1 unreadMessages:0 userIsParticipant:NO recentMessageMessageID:@"1_0_AJfPjkQAAPP9TneCMQ5Lswnz/+I"];
}

- (void)testFacadeForFirstServerResponseConversation7
{
    [self validateFacadeForResponse:[self firstServerResponseConversation7] hasConversationID:@"86252678007101/altoidsiosusr_us1@yahoo.com" totalMessages:1 unreadMessages:0 userIsParticipant:NO recentMessageMessageID:@"1_0_AKLPjkQAADEMTnJC1wCJejvuHgk"];
}

- (void)testFacadeForFirstServerResponseConversation8
{
    [self validateFacadeForResponse:[self firstServerResponseConversation8] hasConversationID:@"86252651458029/altoidsiosusr_us1@yahoo.com" totalMessages:1 unreadMessages:0 userIsParticipant:NO recentMessageMessageID:@"1_0_AJfPjkQAALHRTnJBkQOvT1JB3Eo"];
}

- (void)testFacadeForFirstServerResponseConversation9
{
    [self validateFacadeForResponse:[self firstServerResponseConversation9] hasConversationID:@"86252619661747/altoidsiosusr_us1@yahoo.com" totalMessages:1 unreadMessages:0 userIsParticipant:NO recentMessageMessageID:@"1_0_AJfPjkQAAIj2TnJADAoKVnIKXP4"];
}

- (void)testFacadeForFirstServerResponseConversation10
{
    [self validateFacadeForResponse:[self firstServerResponseConversation10] hasConversationID:@"86252534270862/altoidsiosusr_us1@yahoo.com" totalMessages:1 unreadMessages:0 userIsParticipant:NO recentMessageMessageID:@"1_0_AKLPjkQAAX5+TnI7awIejQ1ZALE"];
}

- (void)validateFacadeForResponse:(NSString *)theResponse hasConversationID:(NSString *)expectedConversationID totalMessages:(NSUInteger)expectedTotalMessages unreadMessages:(NSUInteger)expectedUnreadMessages userIsParticipant:(BOOL)expectedUserIsParticipant recentMessageMessageID:(NSString *)expectedRecentMessageMessageID
{
    YAMMCConversation *facade = [self facadeForJSONString:theResponse];
    NSString *facadeConversationID = [facade conversationID];
    NSUInteger facadeTotalMessages = [[facade totalMessages] intValue];
    NSUInteger facadeUnreadMessages = [[facade unreadMessages] intValue];
    BOOL facadeUserIsParticipant = [facade userIsParticipant];
    NSString *facadeRecentMessageMessageID = [[facade recentMessage] messageID];
    
    STAssertTrue([facadeConversationID isEqualToString:expectedConversationID], @"Unexpected conversationID: Got %@ but expected: %@", facadeConversationID, expectedConversationID);
    
    STAssertTrue(facadeTotalMessages == expectedTotalMessages, @"Unexpected total messages: Got %d but expected %d", facadeTotalMessages, expectedTotalMessages);
    
    STAssertTrue(facadeUnreadMessages == expectedUnreadMessages, @"Unexpected unread messages: Got %d but expected %d", facadeUnreadMessages, expectedUnreadMessages);
    
    STAssertTrue(facadeUserIsParticipant == expectedUserIsParticipant, @"Unexpected participant status: Got %d but expected %d", facadeUserIsParticipant, expectedUserIsParticipant);
    
    STAssertTrue([facadeRecentMessageMessageID isEqualToString:expectedRecentMessageMessageID], @"Unexpected messageID: Got %@ but expected %@", facadeRecentMessageMessageID, expectedRecentMessageMessageID);
}

- (YAMMCConversation *)facadeForJSONString:(NSString *)aJSONString
{
    NSData *data = [aJSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *parsedData = [[self jsonParser] parseJSONData:data];
    
    STAssertNotNil(data, @"Unexpected nil data");
    STAssertNotNil(parsedData, @"Unexpected nil parsed data");
    
    return [[YAMMCConversation alloc] initWithParsedJSONConversationResponse:parsedData];
}

- (NSString *)fullConversationSampleResponse
{
    return @"{"
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
    "    }";
}

- (NSString *)conversationWithErrorSampleResponse
{
    return @"    {"
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
    "    }";
}

- (NSString *)conversationWhereUserIsNotParticipantSampleResponse
{
    return @"    {"
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
    "    }";
}

- (NSString *)conversationIDOnlySampleResponse
{
    return @"    {"
    "      \"conversation\" :"
    "      {"
    "        \"cid\" : \"126\""
    "      }"
    "    }";
}

- (NSString *)firstServerResponseConversation1
{
    return @"{\"conversation\":{\"cid\":\"86275850602635\\/altoidsiosusr_us1@yahoo.com\",\"summary\":{\"totalMsgs\":2,\"unreadMsgs\":1},\"mgrData\":{\"isParticipant\":false},\"recentMsg\":{\"mid\":\"1_0_AJfPjkQAARJOTneoLwpHIFmBOL8\",\"info\":{\"subj\":\"From iOS\",\"date\":1316466135,\"rcpts\":\"Dummy Dummy\",\"snippet\":\"Hey whatsup\",\"from\":{\"name\":\"4083498896\"}}}}}";
}

- (NSString *)firstServerResponseConversation2
{
    return @"{\"conversation\":{\"cid\":\"86275918523874\\/altoidsiosusr_us1@yahoo.com\",\"summary\":{\"totalMsgs\":1,\"unreadMsgs\":0},\"mgrData\":{\"isParticipant\":false},\"recentMsg\":{\"mid\":\"1_0_AKLPjkQAABAaTnen5QzDECSbRY\",\"info\":{\"subj\":\"from iOS, again!\",\"date\":1316466043,\"rcpts\":\"Droid User 2\",\"snippet\":\"from iOS, again!\",\"from\":{\"name\":\"Dummy Dummy\"}}}}}";
}

- (NSString *)firstServerResponseConversation3
{
    return @"{\"conversation\":{\"cid\":\"86275864096921\\/altoidsiosusr_us1@yahoo.com\",\"summary\":{\"totalMsgs\":1,\"unreadMsgs\":0},\"mgrData\":{\"isParticipant\":false},\"recentMsg\":{\"mid\":\"1_0_AJfPjkQAAQGWTnelSg8Uwn3iFlc\",\"info\":{\"subj\":\"From iOS 5\",\"date\":1316465213,\"rcpts\":\"4083496894\",\"snippet\":\"From iOS 5\",\"from\":{\"name\":\"Dummy Dummy\"}}}}}";
}

- (NSString *)firstServerResponseConversation4
{
    return @"{\"conversation\":{\"cid\":\"86275826246165\\/altoidsiosusr_us1@yahoo.com\",\"summary\":{\"totalMsgs\":1,\"unreadMsgs\":0},\"mgrData\":{\"isParticipant\":false},\"recentMsg\":{\"mid\":\"1_0_AKLPjkQAAOO2TnejegluuQG6kkE\",\"info\":{\"subj\":\"foo\",\"date\":1316464635,\"rcpts\":\"4083497005\",\"snippet\":\"foo\",\"from\":{\"name\":\"Dummy Dummy\"}}}}}";
}

- (NSString *)firstServerResponseConversation5
{
    return @"{\"conversation\":{\"cid\":\"86275457797692\\/altoidsiosusr_us1@yahoo.com\",\"summary\":{\"totalMsgs\":2,\"unreadMsgs\":1},\"mgrData\":{\"isParticipant\":false},\"recentMsg\":{\"mid\":\"1_0_AKLPjkQAAWU9TneR2QXus3Ds3wc\",\"info\":{\"subj\":\"Hello world\",\"date\":1316459015,\"rcpts\":\"Dummy Dummy\",\"snippet\":\"\",\"from\":{\"name\":\"86275457797692\\/altoidsiosusr_us1@yahoo.com\"}}}}}";
}

- (NSString *)firstServerResponseConversation6
{
    return @"{\"conversation\":{\"cid\":\"86275199846939\\/altoidsiosusr_us1@yahoo.com\",\"summary\":{\"totalMsgs\":1,\"unreadMsgs\":0},\"mgrData\":{\"isParticipant\":false},\"recentMsg\":{\"mid\":\"1_0_AJfPjkQAAPP9TneCMQ5Lswnz\\/+I\",\"info\":{\"subj\":\"Hello world!\",\"date\":1316455076,\"rcpts\":\"4083497005\",\"snippet\":\"Hello world!\",\"from\":{\"name\":\"Dummy Dummy\"}}}}}";
}

- (NSString *)firstServerResponseConversation7
{
    return @"{\"conversation\":{\"cid\":\"86252678007101\\/altoidsiosusr_us1@yahoo.com\",\"summary\":{\"totalMsgs\":1,\"unreadMsgs\":0},\"mgrData\":{\"isParticipant\":false},\"recentMsg\":{\"mid\":\"1_0_AKLPjkQAADEMTnJC1wCJejvuHgk\",\"info\":{\"subj\":\"One more message\",\"date\":1316111421,\"rcpts\":\"4083497005\",\"snippet\":\"One more message\",\"from\":{\"name\":\"Dummy Dummy\"}}}}}";
}

- (NSString *)firstServerResponseConversation8
{
    return @"{\"conversation\":{\"cid\":\"86252651458029\\/altoidsiosusr_us1@yahoo.com\",\"summary\":{\"totalMsgs\":1,\"unreadMsgs\":0},\"mgrData\":{\"isParticipant\":false},\"recentMsg\":{\"mid\":\"1_0_AJfPjkQAALHRTnJBkQOvT1JB3Eo\",\"info\":{\"subj\":\"Test message\",\"date\":1316111015,\"rcpts\":\"4083497005\",\"snippet\":\"Test message\",\"from\":{\"name\":\"Dummy Dummy\"}}}}}";
}

- (NSString *)firstServerResponseConversation9
{
    return @"{\"conversation\":{\"cid\":\"86252619661747\\/altoidsiosusr_us1@yahoo.com\",\"summary\":{\"totalMsgs\":1,\"unreadMsgs\":0},\"mgrData\":{\"isParticipant\":false},\"recentMsg\":{\"mid\":\"1_0_AJfPjkQAAIj2TnJADAoKVnIKXP4\",\"info\":{\"subj\":\"Another test message\",\"date\":1316110531,\"rcpts\":\"4083497005\",\"snippet\":\"Another test message\",\"from\":{\"name\":\"Dummy Dummy\"}}}}}";
}

- (NSString *)firstServerResponseConversation10
{
    return @"{\"conversation\":{\"cid\":\"86252534270862\\/altoidsiosusr_us1@yahoo.com\",\"summary\":{\"totalMsgs\":1,\"unreadMsgs\":0},\"mgrData\":{\"isParticipant\":false},\"recentMsg\":{\"mid\":\"1_0_AKLPjkQAAX5+TnI7awIejQ1ZALE\",\"info\":{\"subj\":\"Hi there\",\"date\":1316109227,\"rcpts\":\"4083497005\",\"snippet\":\"Hi there\",\"from\":{\"name\":\"Dummy Dummy\"}}}}}";
}

@end
