//
//  YAMMCMessageToMessageInfoTranslatorTests.m
//  altoids
//
//  Created by Jon Herron on 9/20/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAMMCMessageToMessageInfoTranslatorTests.h"
#import "YAMessageInfo.h"
#import "YAMMCMessageToMessageInfoTranslator.h"
#import "YAMMCRecentMessage.h"

@interface YAMMCMessageToMessageInfoTranslatorTests()

@property (strong, nonatomic) id mmcRecentMessageMock;
@property (strong, nonatomic) YAMMCMessageToMessageInfoTranslator *mmcMessageToMessageInfoTranslator;

@end

@implementation YAMMCMessageToMessageInfoTranslatorTests

@synthesize mmcRecentMessageMock = mmcRecentMessageMock_;
@synthesize mmcMessageToMessageInfoTranslator = mmcMessageToMessageInfoTranslator_;

- (void)setUp
{
    [self setMmcRecentMessageMock:[OCMockObject mockForClass:[YAMMCRecentMessage class]]];
    [self setMmcMessageToMessageInfoTranslator:[[YAMMCMessageToMessageInfoTranslator alloc] init]];
}

- (void)testCanTranslateMMCRecentMessageToMessageInfo
{
    NSString *messageID = @"messageID";
    NSDate *sent = [NSDate date];
    NSString *recipients = @"recipients";
    NSString *sender = @"sender";
    NSString *snippet = @"snippet";
    
    [[[[self mmcRecentMessageMock] expect] andReturn:messageID] messageID];
    [[[[self mmcRecentMessageMock] expect] andReturn:sent] sent];
    [[[[self mmcRecentMessageMock] expect] andReturn:recipients] recipients];
    [[[[self mmcRecentMessageMock] expect] andReturn:sender] sender];
    [[[[self mmcRecentMessageMock] expect] andReturn:snippet] snippet];
    
    YAMessageInfo *messageInfo = [[self mmcMessageToMessageInfoTranslator] messageInfoFromMMCRecentMessage:[self mmcRecentMessageMock]];
    
    [[self mmcRecentMessageMock] verify];
    
    STAssertTrue([[messageInfo messageID] isEqualToString:messageID], @"Unexpected messageID");
    STAssertNil([messageInfo body], @"Expected nil message body");
    STAssertFalse([messageInfo read], @"Expected unread message");
    STAssertTrue([[messageInfo snippet] isEqualToString:snippet], @"Unexpected snippet");
    STAssertTrue([[messageInfo timestamp] isEqualToDate:sent], @"Unexpected timestamp");
    STAssertTrue([[messageInfo rawSenderString] isEqualToString:sender], @"Unexpected sender");
    STAssertTrue([[messageInfo snippet] isEqualToString:snippet], @"Unexpected snippet");
}

@end
