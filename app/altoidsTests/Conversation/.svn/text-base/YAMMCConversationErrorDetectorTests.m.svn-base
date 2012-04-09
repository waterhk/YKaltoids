//
//  YAMMCConversationErrorDetectorTests.m
//  altoids
//
//  Created by Jon Herron on 11/14/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAMMCConversationErrorDetectorTests.h"
#import "YAMMCConversationErrorDetector.h"
#import "YAMMCConversation.h"

@interface YAMMCConversationErrorDetectorTests()

@property (strong, nonatomic) id mmcConversationMock;
@property (strong, nonatomic) YAMMCConversationErrorDetector *mmcConversationErrorDetector;

@end

@implementation YAMMCConversationErrorDetectorTests

@synthesize mmcConversationMock = mmcConversationMock_;
@synthesize mmcConversationErrorDetector = mmcConversationErrorDetector_;

- (void)setUp
{
    [self setMmcConversationMock:[OCMockObject mockForClass:[YAMMCConversation class]]];
    [self setMmcConversationErrorDetector:[[YAMMCConversationErrorDetector alloc] init]];
}

- (void)testIfMMCConversationHasErrorsErrorDetectorReturnsTrue
{
    NSArray *errors = [NSArray arrayWithObject:[NSError errorWithDomain:@"domain" code:1 userInfo:nil]];
    
    [[[[self mmcConversationMock] expect] andReturn:errors] errors];
    
    STAssertTrue([[self mmcConversationErrorDetector] mmcConversationHasErrors:[self mmcConversationMock]], @"Unexpected errors for mmc conversation");
    
    [[self mmcConversationMock] verify];
}

- (void)testIfMMCConversationDoesNotHaveErrorsErrorDetectorReturnsFalse
{
    [[[[self mmcConversationMock] expect] andReturn:nil] errors];
    
    STAssertFalse([[self mmcConversationErrorDetector] mmcConversationHasErrors:[self mmcConversationMock]], @"Unexpected errors for mmc conversation");
    
    [[[[self mmcConversationMock] expect] andReturn:[NSArray array]] errors];
    
    STAssertFalse([[self mmcConversationErrorDetector] mmcConversationHasErrors:[self mmcConversationMock]], @"Unexpected errors for mmc conversation");
    
    [[self mmcConversationMock] verify];
}

@end
