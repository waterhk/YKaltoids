//
//  YAMMCRecentMessageFacadeIntegrationTests.m
//  altoids
//
//  Created by Jon Herron on 9/18/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//
//  http://twiki.corp.yahoo.com/view/Devel/AltoidsiOSClientServerResponseFacades
//

#import <SBJson/SBJson.h>
#import "YAJSONParser.h"
#import "YAMMCRecentMessage.h"
#import "YAMMCRecentMessageIntegrationTests.h"

@interface YAMMCRecentMessageIntegrationTests()

@property (strong, nonatomic) SBJsonParser *sbJSONParser;
@property (strong, nonatomic) YAJSONParser *jsonParser;

- (YAMMCRecentMessage *)facadeForJSONString:(NSString *)aJSONString;

- (void)validateFacadeForResponse:(NSString *)theResponse hasMessageID:(NSString *)expectedMessageID subject:(NSString *)expectedSubject sent:(NSTimeInterval)expectedSent recipients:(NSString *)expectedRecipients sender:(NSString *)expectedSender snippet:(NSString *)expectedSnippet;

- (NSString *)recentMessageSampleResponse;
- (NSString *)firstServerResponseRecentMessage1;
- (NSString *)firstServerResponseRecentMessage2;
- (NSString *)firstServerResponseRecentMessage3;
- (NSString *)firstServerResponseRecentMessage4;
- (NSString *)firstServerResponseRecentMessage5;
- (NSString *)firstServerResponseRecentMessage6;
- (NSString *)firstServerResponseRecentMessage7;
- (NSString *)firstServerResponseRecentMessage8;
- (NSString *)firstServerResponseRecentMessage9;
- (NSString *)firstServerResponseRecentMessage10;

@end

@implementation YAMMCRecentMessageIntegrationTests

@synthesize sbJSONParser = sbJSONParser_;
@synthesize jsonParser = jsonParser_;

- (void)setUp
{
    [self setSbJSONParser:[[SBJsonParser alloc] init]];
    [self setJsonParser:[[YAJSONParser alloc] init]];
    [[self jsonParser] setSBJSONParser:[self sbJSONParser]];
}

- (void)testFacadeForRecentMessageSampleResponse
{
    [self validateFacadeForResponse:[self recentMessageSampleResponse] hasMessageID:@"1" subject:@"email subject" sent:1224314 recipients:@"Vivek Aggarwa, Naveen Sanjeeva and You" sender:@"Vivek Aggarwal" snippet:@"Vivek deserves a break.."];
}

- (void)testFirstServerResponseRecentMessage1
{
    [self validateFacadeForResponse:[self firstServerResponseRecentMessage1] hasMessageID:@"1_0_AJfPjkQAARJOTneoLwpHIFmBOL8" subject:@"From iOS" sent:1316466135 recipients:@"Dummy Dummy" sender:@"4083498896" snippet:@"Hey whatsup"];
}

- (void)testFirstServerResponseRecentMessage2
{
    [self validateFacadeForResponse:[self firstServerResponseRecentMessage2] hasMessageID:@"1_0_AKLPjkQAABAaTnen5QzDECSVbRY" subject:@"from iOS, again!" sent:1316466043 recipients:@"Droid User 2" sender:@"Dummy Dummy" snippet:@"from iOS, again!"];
}

- (void)testFirstServerResponseRecentMessage3
{
    [self validateFacadeForResponse:[self firstServerResponseRecentMessage3] hasMessageID:@"1_0_AJfPjkQAAQGWTnelSg8Uwn3iFlc" subject:@"From iOS 5" sent:1316465213 recipients:@"4083496894" sender:@"Dummy Dummy" snippet:@"From iOS 5"];
}

- (void)testFirstServerResponseRecentMessage4
{
    [self validateFacadeForResponse:[self firstServerResponseRecentMessage4] hasMessageID:@"1_0_AKLPjkQAAOO2TnejegluuQG6kkE" subject:@"foo" sent:1316464635 recipients:@"4083497005" sender:@"Dummy Dummy" snippet:@"foo"];
}

- (void)testFirstServerResponseRecentMessage5
{
    [self validateFacadeForResponse:[self firstServerResponseRecentMessage5] hasMessageID:@"1_0_AKLPjkQAAWU9TneR2QXus3Ds3wc" subject:@"Hello world" sent:1316459015 recipients:@"Dummy Dummy" sender:@"86275457797692/altoidsiosusr_us1@yahoo.com" snippet:@""];
}

- (void)testFirstServerResponseRecentMessage6
{
    [self validateFacadeForResponse:[self firstServerResponseRecentMessage6] hasMessageID:@"1_0_AJfPjkQAAPP9TneCMQ5Lswnz/+I" subject:@"Hello world!" sent:1316455076 recipients:@"4083497005" sender:@"Dummy Dummy" snippet:@"Hello world!"];
}

- (void)testFirstServerResponseRecentMessage7
{
    [self validateFacadeForResponse:[self firstServerResponseRecentMessage7] hasMessageID:@"1_0_AKLPjkQAADEMTnJC1wCJejvuHgk" subject:@"One more message" sent:1316111421 recipients:@"4083497005" sender:@"Dummy Dummy" snippet:@"One more message"];
}

- (void)testFirstServerResponseRecentMessage8
{
    [self validateFacadeForResponse:[self firstServerResponseRecentMessage8] hasMessageID:@"1_0_AJfPjkQAALHRTnJBkQOvT1JB3Eo" subject:@"Test message" sent:1316111015 recipients:@"4083497005" sender:@"Dummy Dummy" snippet:@"Test message"];
}

- (void)testFirstServerResponseRecentMessage9
{
    [self validateFacadeForResponse:[self firstServerResponseRecentMessage9] hasMessageID:@"1_0_AJfPjkQAAIj2TnJADAoKVnIKXP4" subject:@"Another test message" sent:1316110531 recipients:@"4083497005" sender:@"Dummy Dummy" snippet:@"Another test message"];
}

- (void)testFirstServerResponseRecentMessage10
{
    [self validateFacadeForResponse:[self firstServerResponseRecentMessage10] hasMessageID:@"1_0_AKLPjkQAAX5+TnI7awIejQ1ZALE" subject:@"Hi there" sent:1316109227 recipients:@"4083497005" sender:@"Dummy Dummy" snippet:@"Hi there"];
}

- (void)validateFacadeForResponse:(NSString *)theResponse hasMessageID:(NSString *)expectedMessageID subject:(NSString *)expectedSubject sent:(NSTimeInterval)expectedSent recipients:(NSString *)expectedRecipients sender:(NSString *)expectedSender snippet:(NSString *)expectedSnippet
{
    YAMMCRecentMessage *facade = [self facadeForJSONString:theResponse];
    NSString *facadeMessageID = [facade messageID];
    NSString *facadeSubject = [facade subject];
    NSTimeInterval facadeSent = [[facade sent] timeIntervalSince1970];
    NSString *facadeRecipients = [facade recipients];
    NSString *facadeSender = [facade sender];
    NSString *facadeSnippet = [facade snippet];
    
    STAssertTrue([facadeMessageID isEqualToString:expectedMessageID], @"Unexpected messageID: Got %@ but expected %@", facadeMessageID, expectedMessageID);
    
    STAssertTrue([facadeSubject isEqualToString:expectedSubject], @"Unexpected subject: Got %@ but expected %@", facadeSubject, expectedSubject);
    
    STAssertTrue(facadeSent == expectedSent, @"Unexpected sent time: Got %d but expected %d", facadeSent, expectedSent);
    
    STAssertTrue([facadeRecipients isEqualToString:expectedRecipients], @"Unexpected recipients: Got %@ but expected %@", facadeRecipients, expectedRecipients);
    
    STAssertTrue([facadeSender isEqualToString:expectedSender], @"Unexpected sender: Got %@ but expected %@", facadeSender, expectedSender);
    
    STAssertTrue([facadeSnippet isEqualToString:expectedSnippet], @"Unexpected snippet: Got %@ but expected %@", facadeSnippet, expectedSnippet);
}

- (YAMMCRecentMessage *)facadeForJSONString:(NSString *)aJSONString
{
    NSData *data = [aJSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *parsedData = [[self jsonParser] parseJSONData:data];
    
    STAssertNotNil(data, @"Unexpected nil data");
    STAssertNotNil(parsedData, @"Unexpected nil parsed data");
    
    return [[YAMMCRecentMessage alloc] initWithParsedJSONRecentMessageResponse:parsedData];
}

- (NSString *)recentMessageSampleResponse
{
    return @"{"
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
    "        }";
}

- (NSString *)firstServerResponseRecentMessage1
{
    return @"{\"mid\":\"1_0_AJfPjkQAARJOTneoLwpHIFmBOL8\",\"info\":{\"subj\":\"From iOS\",\"date\":1316466135,\"rcpts\":\"Dummy Dummy\",\"snippet\":\"Hey whatsup\",\"from\":{\"name\":\"4083498896\"}}}";
}

- (NSString *)firstServerResponseRecentMessage2
{
    return @"{\"mid\":\"1_0_AKLPjkQAABAaTnen5QzDECSVbRY\",\"info\":{\"subj\":\"from iOS, again!\",\"date\":1316466043,\"rcpts\":\"Droid User 2\",\"snippet\":\"from iOS, again!\",\"from\":{\"name\":\"Dummy Dummy\"}}}";
}

- (NSString *)firstServerResponseRecentMessage3
{
    return @"{\"mid\":\"1_0_AJfPjkQAAQGWTnelSg8Uwn3iFlc\",\"info\":{\"subj\":\"From iOS 5\",\"date\":1316465213,\"rcpts\":\"4083496894\",\"snippet\":\"From iOS 5\",\"from\":{\"name\":\"Dummy Dummy\"}}}";
}

- (NSString *)firstServerResponseRecentMessage4
{
    return @"{\"mid\":\"1_0_AKLPjkQAAOO2TnejegluuQG6kkE\",\"info\":{\"subj\":\"foo\",\"date\":1316464635,\"rcpts\":\"4083497005\",\"snippet\":\"foo\",\"from\":{\"name\":\"Dummy Dummy\"}}}";
}

- (NSString *)firstServerResponseRecentMessage5
{
    return @"{\"mid\":\"1_0_AKLPjkQAAWU9TneR2QXus3Ds3wc\",\"info\":{\"subj\":\"Hello world\",\"date\":1316459015,\"rcpts\":\"Dummy Dummy\",\"snippet\":\"\",\"from\":{\"name\":\"86275457797692\\/altoidsiosusr_us1@yahoo.com\"}}}";
}

- (NSString *)firstServerResponseRecentMessage6
{
    return @"{\"mid\":\"1_0_AJfPjkQAAPP9TneCMQ5Lswnz\\/+I\",\"info\":{\"subj\":\"Hello world!\",\"date\":1316455076,\"rcpts\":\"4083497005\",\"snippet\":\"Hello world!\",\"from\":{\"name\":\"Dummy Dummy\"}}}";
}

- (NSString *)firstServerResponseRecentMessage7
{
    return @"{\"mid\":\"1_0_AKLPjkQAADEMTnJC1wCJejvuHgk\",\"info\":{\"subj\":\"One more message\",\"date\":1316111421,\"rcpts\":\"4083497005\",\"snippet\":\"One more message\",\"from\":{\"name\":\"Dummy Dummy\"}}}";
}

- (NSString *)firstServerResponseRecentMessage8
{
    return @"{\"mid\":\"1_0_AJfPjkQAALHRTnJBkQOvT1JB3Eo\",\"info\":{\"subj\":\"Test message\",\"date\":1316111015,\"rcpts\":\"4083497005\",\"snippet\":\"Test message\",\"from\":{\"name\":\"Dummy Dummy\"}}}";
}

- (NSString *)firstServerResponseRecentMessage9
{
    return @"{\"mid\":\"1_0_AJfPjkQAAIj2TnJADAoKVnIKXP4\",\"info\":{\"subj\":\"Another test message\",\"date\":1316110531,\"rcpts\":\"4083497005\",\"snippet\":\"Another test message\",\"from\":{\"name\":\"Dummy Dummy\"}}}";
}

- (NSString *)firstServerResponseRecentMessage10
{
    return @"{\"mid\":\"1_0_AKLPjkQAAX5+TnI7awIejQ1ZALE\",\"info\":{\"subj\":\"Hi there\",\"date\":1316109227,\"rcpts\":\"4083497005\",\"snippet\":\"Hi there\",\"from\":{\"name\":\"Dummy Dummy\"}}}";
}

@end
