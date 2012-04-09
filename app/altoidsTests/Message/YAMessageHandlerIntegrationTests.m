//
//  YAMessageHandlerIntegrationTests.m
//  altoids
//
//  Created by Jon Herron on 9/14/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAMessageHandlerIntegrationTests.h"
#import "YAMessage.h"
#import "YAMessageHandler.h"
#import "YAManagedObjectContextFactory.h"
#import "YAParticipant.h"
#import "YAParticipantHandler.h"
#import "MessageStatus.h"

@interface YAMessageHandlerIntegrationTests()

@property (strong, nonatomic) YAMessage *message;
@property (strong, nonatomic) YAMessageHandler *messageHandler;
@property (strong, nonatomic) YAParticipant *participant;

@end

@implementation YAMessageHandlerIntegrationTests

@synthesize message = message_;
@synthesize messageHandler = messageHandler_;
@synthesize participant = participant_;

- (void)setUp
{
    YAManagedObjectContextFactory *managedObjectContextFactory = [[YAManagedObjectContextFactory alloc] init];
    [managedObjectContextFactory setPersistentStoreType:NSInMemoryStoreType];
    [managedObjectContextFactory setBundleContainingManagedObjectModel:[NSBundle bundleForClass:[self class]]];
    [managedObjectContextFactory setPersistentStoreURLGenerator:nil];
    
    YAParticipantHandler *participantHandler = [[YAParticipantHandler alloc] init];
    
    NSManagedObjectContext *managedObjectContext = [managedObjectContextFactory create];
    
    [self setMessageHandler:[[YAMessageHandler alloc] init]];
    [self setMessage:[[self messageHandler] createMessageEntityInManagedObjectContext:managedObjectContext]];
    [self setParticipant:[participantHandler createParticipantEntityInManagedObjectContext:managedObjectContext]];
}

- (void)testProvidesAbilityToMessageEntityInGivenManagedObjectContext
{
    STAssertNotNil([self message], @"Unexpected nil message entity");
}

- (void)testProvidesAbilityToSetBodyForMessage
{
    NSString *body = @"some body";
    
    [[self messageHandler] setBody:body forMessage:[self message]];
    
    STAssertEquals(body, [[self message] body], @"Unexecpted body for message");
}

- (void)testProvidesAbilityToSetMessageIDForMessage
{
    NSString *messageID = @"message id";
    
    [[self messageHandler] setMessageID:messageID forMessage:[self message]];
    
    STAssertEquals(messageID, [[self message] messageID], @"Unexecpted messageID for message");
}

- (void)testProvidesAbilityToSetReadForMessage
{
    BOOL readFlag = YES;
    
    [[self messageHandler] setRead:readFlag forMessage:[self message]];
    
    STAssertEquals(readFlag, [[[self message] read] boolValue], @"Unexpected read for message");
}

- (void)testProvidesAbilityToSetSnippetForMessage
{
    NSString *snippet = @"message id";
    
    [[self messageHandler] setSnippet:snippet forMessage:[self message]];
    
    STAssertEquals(snippet, [[self message] snippet], @"Unexpected snippet for message");
}

- (void)testProvidesAbilityToSetTimestampForMessage
{
    NSDate *timestamp = [NSDate date];
    
    [[self messageHandler] setTimestamp:timestamp forMessage:[self message]];
    
    STAssertTrue([timestamp isEqualToDate:[[self message] timestamp]], @"Unexpected date for message");
}

- (void)testProvidesAbilityToSetAndRetrieveSenderForMessage
{
    [[self messageHandler] setParticipantAsSender:[self participant] ofMessage:[self message]];
    
    STAssertEquals([self participant], [[self message] sender], @"Unexpected message sender");
    STAssertEquals([self participant], [[self messageHandler] senderForMessage:[self message]], @"Unexpected message sender");
}

- (void)testProvidesAbilityToSetStatusAsSystemMessageForMessage
{
    [[self messageHandler] setStatusAsSystemMessageForMessage:[self message]];
    
    STAssertEquals(YAMessageStatusSystemMessage, [[[self message] status] intValue], @"Unexpected status");
    STAssertTrue([[self messageHandler] messageHasSystemMessageStatus:[self message]], @"Invalid status detected by handler");
}

- (void)testProvidesAbilityToSetStatusForMessage
{
    [[self messageHandler] setStatus:YAMessageStatusGapPlaceholder forMessage:[self message]];
    
    STAssertEquals(YAMessageStatusGapPlaceholder, [[[self message] status] intValue], @"Unexpected status");
    STAssertTrue([[self messageHandler] statusForMessage:[self message]] == YAMessageStatusGapPlaceholder, @"Invalid status set for message");
    STAssertFalse([[self messageHandler] messageHasSystemMessageStatus:[self message]], @"Invalid status detected by handler");
}

- (void)testProvidesAbilityToSetAndRetrieveSnippetForMessage
{
    NSString *snippet = @"snippet";
    
    [[self messageHandler] setSnippet:snippet forMessage:[self message]];
    
    STAssertTrue([[[self message] snippet] isEqualToString:snippet], @"Unexpected snippet");
    STAssertTrue([[[self messageHandler] snippetForMessage:[self message]] isEqualToString:snippet], @"Unexpected snippet");
}

@end
