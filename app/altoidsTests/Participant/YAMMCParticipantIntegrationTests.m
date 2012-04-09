//
//  YAMMCParticipantFacadeIntegrationTests.m
//  altoids
//
//  Created by Jon Herron on 9/18/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//
//  http://twiki.corp.yahoo.com/view/Devel/AltoidsiOSClientServerResponseFacades
//

#import <SBJson/SBJson.h>
#import "YAJSONParser.h"
#import "YAMMCParticipantIntegrationTests.h"
#import "YAMMCParticipant.h"

@interface YAMMCParticipantIntegrationTests()

@property (strong, nonatomic) SBJsonParser *sbJSONParser;
@property (strong, nonatomic) YAJSONParser *jsonParser;

- (YAMMCParticipant *)facadeForJSONString:(NSString *)aJSONString;

- (NSString *)participantWhichIsUserSampleResponse;
- (NSString *)participantWhichIsNotUserSampleResponse;

@end

@implementation YAMMCParticipantIntegrationTests

@synthesize sbJSONParser = sbJSONParser_;
@synthesize jsonParser = jsonParser_;

- (void)setUp
{
    [self setSbJSONParser:[[SBJsonParser alloc] init]];
    [self setJsonParser:[[YAJSONParser alloc] init]];
    [[self jsonParser] setSBJSONParser:[self sbJSONParser]];
}

- (void)testFacadeForParticipantWhichIsUserSampleResponse
{
    YAMMCParticipant *facade = [self facadeForJSONString:[self participantWhichIsUserSampleResponse]];
    
    STAssertTrue([[facade participantID] isEqualToString:@"2"], @"Unexpected participant id");
    STAssertTrue([[facade firstName] isEqualToString:@"Naveen"], @"Unexpected first name: %@", [facade firstName]);
    STAssertTrue([[facade lastName] isEqualToString:@"Sanjeeva"], @"Unexpected last name: %@", [facade lastName]);
    STAssertTrue([[facade created] timeIntervalSince1970] == 213254325, @"Unexpected created time");
    STAssertTrue([[facade address] isEqualToString:@"14081112223"], @"Unexpected address");
    STAssertTrue([[facade addressType] isEqualToString:@"mmc"], @"Unexpected address type");
    STAssertTrue([facade isConversationCreator], @"Unexpected false for isConversationCreator");
    STAssertTrue([facade isUser], @"Unexpected false for isUser");
}

- (void)testFacadeForParticipantWhichIsNotUserSampleResponse
{
    YAMMCParticipant *facade = [self facadeForJSONString:[self participantWhichIsNotUserSampleResponse]];
    
    STAssertTrue([[facade participantID] isEqualToString:@"1"], @"Unexpected participant id");
    STAssertTrue([[facade firstName] isEqualToString:@"Vivek"], @"Unexpected first name: %@", [facade firstName]);
    STAssertTrue([[facade lastName] isEqualToString:@"Aggarwal"], @"Unexpected last name: %@", [facade lastName]);
    STAssertTrue([[facade created] timeIntervalSince1970] == 2131353245, @"Unexpected created time");
    STAssertTrue([[facade address] isEqualToString:@"14081112222"], @"Unexpected address");
    STAssertTrue([[facade addressType] isEqualToString:@"sms"], @"Unexpected address type");
    STAssertFalse([facade isConversationCreator], @"Unexpected true for isConversationCreator");
    STAssertFalse([facade isUser], @"Unexpected true for isUser");
}

- (YAMMCParticipant *)facadeForJSONString:(NSString *)aJSONString
{
    NSData *data = [aJSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *parsedData = [[self jsonParser] parseJSONData:data];
    
    STAssertNotNil(data, @"Unexpected nil data");
    STAssertNotNil(parsedData, @"Unexpected nil parsed data");
    
    return [[YAMMCParticipant alloc] initWithParsedJSONParticipantResponse:parsedData];
}

- (NSString *)participantWhichIsUserSampleResponse
{
    return @"{"
    "              \"pid\" : \"2\","
    "              \"firstname\" : \"Naveen\","
    "              \"lastname\" : \"Sanjeeva\","
    "              \"created\" : 213254325,"
    "              \"address\" : \"14081112223\","
    "              \"addressType\" : \"mmc\","
    "              \"creator\": 1,"
    "              \"isYou\": true"
    "            }";
}

- (NSString *)participantWhichIsNotUserSampleResponse
{
    return @"{"
    "              \"pid\" : \"1\","
    "              \"firstname\" : \"Vivek\","
    "              \"lastname\" : \"Aggarwal\","
    "              \"created\" : 2131353245,"
    "              \"address\" : \"14081112222\","
    "              \"addressType\" : \"sms\","
    "              \"creator\": 0"
    "            }";
}

@end
