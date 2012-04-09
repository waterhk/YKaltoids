//
//  YAConversationReplyRequestDataBuilderTests.m
//  altoids
//
//  Created by Jon Herron on 10/24/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationReplyRequestDataBuilderTests.h"
#import "YAConversationReplyRequestDataBuilder.h"

@interface YAConversationReplyRequestDataBuilderTests()

@property (strong, nonatomic) YAConversationReplyRequestDataBuilder *conversationReplyRequestDataBuilder;

@end

@implementation YAConversationReplyRequestDataBuilderTests

@synthesize conversationReplyRequestDataBuilder = conversationReplyRequestDataBuilder_;

- (void)setUp
{
    [self setConversationReplyRequestDataBuilder:[[YAConversationReplyRequestDataBuilder alloc] init]];
}

- (void)testCanBuildRequestDataForGivenMessageBody
{
    NSString *messageBody = @"msg to reply with";
    NSDictionary *requestData = [[self conversationReplyRequestDataBuilder] requestDataForReplyingToConversationWithMessageBody:messageBody];
    
    STAssertTrue([[requestData objectForKey:@"message"] isEqualToString:messageBody], @"Unexpected message body");
}

@end
