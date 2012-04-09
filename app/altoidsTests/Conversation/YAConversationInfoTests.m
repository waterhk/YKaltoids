//
//  YAConversationInfoTests.m
//  altoids
//
//  Created by Jon Herron on 9/19/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationInfoTests.h"
#import "YAConversationInfo.h"

@implementation YAConversationInfoTests

- (void)testProvidesAccessToSameValuesProvidedDuringInitialization
{
    NSString *conversationID = @"ConvID";
    YAConversationStatus status = YAConversationStatusSaved;
    NSDate *timestamp = [NSDate date];
    NSString *topic = @"Topic";
    NSNumber *totalMessages = [NSNumber numberWithInt:12];
    NSNumber *unreadMessages = [NSNumber numberWithInt:55];
    YAConversationContextInfo *conversationContextInfo = [[YAConversationContextInfo alloc] init];
    NSArray *messageInfos = [NSArray arrayWithObject:[NSNumber numberWithInt:10]];
    NSArray *participantInfos = [NSArray arrayWithObject:[NSNumber numberWithInt:11]];
    NSDictionary *participantInfosByTransientID = [NSDictionary dictionary];
    YAParticipantInfo *sender = [[YAParticipantInfo alloc] init];
    YAMessageInfo *mostRecentMessageInfo = [[YAMessageInfo alloc] init];
    BOOL userIsParticipant = YES;
    
    YAConversationInfo *convInfo = [[YAConversationInfo alloc] initWithConversationID:conversationID 
                                                                               status:status 
                                                                            timestamp:timestamp 
                                                                                topic:topic 
                                                                        totalMessages:totalMessages 
                                                                       unreadMessages:unreadMessages 
                                                              conversationContextInfo:conversationContextInfo 
                                                                         messageInfos:messageInfos 
                                                                     participantInfos:participantInfos 
                                                        participantInfosByTransientID:participantInfosByTransientID
                                                                               sender:sender 
                                                                mostRecentMessageInfo:mostRecentMessageInfo
                                                                    userIsParticipant:userIsParticipant];
    
    STAssertTrue([[convInfo conversationID] isEqualToString:conversationID], @"Unexpected conversationID");
    STAssertTrue([convInfo status] == status, @"Unexpected status");
    STAssertTrue([[convInfo timestamp] isEqualToDate:timestamp], @"Unexpected timestamp");
    STAssertTrue([[convInfo topic] isEqualToString:topic], @"Unexpected topic");
    STAssertTrue([[convInfo totalMessages] isEqualToNumber:totalMessages], @"Unexpected total messages");
    STAssertTrue([[convInfo unreadMessages] isEqualToNumber:unreadMessages], @"Unexpected unread messages");
    STAssertEqualObjects([convInfo conversationContextInfo], conversationContextInfo, @"Unexpected conversationContextInfo");
    STAssertTrue([[[convInfo messageInfos] objectAtIndex:0] intValue] == 10, @"Unexpected messageInfos");
    STAssertTrue([[[convInfo participantInfos] objectAtIndex:0] intValue] == 11, @"Unexpected participantInfos");
    STAssertEqualObjects(participantInfosByTransientID, [convInfo participantInfosByTransientID], @"Unexpected participant infos by transient id");
    STAssertEqualObjects([convInfo sender], sender, @"Unexpected sender");
    STAssertEqualObjects([convInfo mostRecentMessageInfo], mostRecentMessageInfo, @"Unexpected mostRecentMessageInfo");
    STAssertTrue([convInfo userIsParticipant], @"Unexpected userIsParticipant");
}

@end
