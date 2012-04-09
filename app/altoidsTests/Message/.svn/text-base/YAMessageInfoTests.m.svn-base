//
//  YAMessageInfoTests.m
//  altoids
//
//  Created by Jon Herron on 9/20/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAMessageInfoTests.h"
#import "YAMessageInfo.h"

@implementation YAMessageInfoTests

- (void)testReturnsSameValuesProvidedDuringInitializion
{
    NSString *messageID = @"messageID";
    NSString *body = @"body";
    BOOL read = YES;
    NSString *snippet = @"snippet";
    NSDate *timestamp = [NSDate date];
    NSString *sender = @"sender";
    NSString *recipients = @"recipients";
    
    YAMessageInfo *messageInfo = [[YAMessageInfo alloc] initWithMessageID:messageID body:body read:read snippet:snippet timestamp:timestamp
                                                          rawSenderString:sender sender:nil recipients:recipients isSystemMessage:NO systemMessage:nil];
    
    STAssertTrue([[messageInfo messageID] isEqualToString:messageID], @"Unexpected messageID");
    STAssertTrue([[messageInfo body] isEqualToString:body], @"Unexpected body");
    STAssertTrue([messageInfo read], @"Unexpected read");
    STAssertTrue([[messageInfo snippet] isEqualToString:snippet], @"Unexpected snippet");
    STAssertTrue([[messageInfo timestamp] isEqualToDate:timestamp], @"Unexpected timestamp");
    STAssertTrue([[messageInfo rawSenderString] isEqualToString:sender], @"Unexpected sender");
    STAssertNil([messageInfo sender], @"Expected nil sender");
    STAssertTrue([[messageInfo recipients] isEqualToString:recipients], @"Unexpected recipients");
    STAssertFalse([messageInfo isMessageIdOnly], @"Unexpected value for isMessageIdOnly, expected it to be NO");
}

- (void)testMessageInfoWithIdOnly
{
    NSString *messageId = @"messageID";
    
    YAMessageInfo *messageInfo = [[YAMessageInfo alloc] initWithMessageID:messageId];
    
    STAssertTrue([messageInfo isMessageIdOnly], @"Unexpected value for isMessageIdOnly");
    
    NSArray *otherKeys = [NSArray arrayWithObjects:@"body", @"snippet", @"timestamp" , @"rawSenderString", @"sender", @"recipients",nil];
    
    [otherKeys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            STAssertNil([messageInfo valueForKey:obj], @"Unexpected value for %@", obj);
        }
    ];
}

@end
