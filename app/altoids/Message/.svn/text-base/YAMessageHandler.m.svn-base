//
//  YAMessageHandler.m
//  altoids
//
//  Created by Jon Herron on 8/23/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAMessageHandler.h"
#import "MessageStatus.h"

@implementation YAMessageHandler

- (id)init
{
  self = [super init];
  if (self) {
    // Initialization code here.
  }
  
  return self;
}

- (YAMessage *)createMessageEntityInManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext
{
    return [NSEntityDescription insertNewObjectForEntityForName:kMessageEntityName inManagedObjectContext:aManagedObjectContext];
}

- (void)setBody:(NSString *)aBody forMessage:(YAMessage *)aMessage
{
    [aMessage setBody:aBody];
}

- (void)setMessageID:(NSString *)aMessageID forMessage:(YAMessage *)aMessage
{
    [aMessage setMessageID:aMessageID];
}

- (void)setRead:(BOOL)aRead forMessage:(YAMessage *)aMessage
{
    [aMessage setRead:[NSNumber numberWithBool:aRead]];
}

- (void)setSnippet:(NSString *)aSnippet forMessage:(YAMessage *)aMessage
{
    [aMessage setSnippet:aSnippet];
}

- (void)setTimestamp:(NSDate *)aTimestamp forMessage:(YAMessage *)aMessage
{
    [aMessage setTimestamp:aTimestamp];
}

- (void)setParticipantAsSender:(YAParticipant *)aParticipant ofMessage:(YAMessage *)aMessage
{
    [aMessage setSender:aParticipant];
}

- (void)setStatusAsNewForMessage:(YAMessage *)theMessage
{
    [self setStatus:YAMessageStatusNew forMessage:theMessage];
}

- (void)setStatusAsDraftForMessage:(YAMessage *)theMessage
{
    [self setStatus:YAMessageStatusDraft forMessage:theMessage];
}

- (void)setStatusAsPendingForMessage:(YAMessage *)theMessage
{
    [self setStatus:YAMessageStatusPending forMessage:theMessage];
}

- (void)setStatusAsPendingWithErrorsForMessage:(YAMessage *)theMessage
{
    [self setStatus:YAMessageStatusPendingWithErrors forMessage:theMessage];
}

- (void)setStatusAsSavedForMessage:(YAMessage *)theMessage
{
    [self setStatus:YAMessageStatusSaved forMessage:theMessage];
}

- (void)setStatusAsGapPlaceholderForMessage:(YAMessage *)theMessage
{
    [self setStatus:YAMessageStatusGapPlaceholder forMessage:theMessage];
}

- (void)setStatusAsSystemMessageForMessage:(YAMessage *)theMessage
{
    [self setStatus:YAMessageStatusSystemMessage forMessage:theMessage];
}

- (void)setStatus:(YAMessageStatus)theStatus forMessage:(YAMessage *)theMessage
{
    [theMessage setStatus:[NSNumber numberWithInt:theStatus]];
}

- (NSString *)bodyForMessage:(YAMessage *)theMessage
{
    return [theMessage body];
}

- (NSString *)messageIDForMessage:(YAMessage *)theMessage
{
    return [theMessage messageID];
}

- (NSManagedObjectID *)messageObjectIDForMessage:(YAMessage *)message
{
    return [message objectID];
}

- (YAParticipant *)senderForMessage:(YAMessage *)theMessage
{
    return [theMessage sender];
}

- (NSString *)snippetForMessage:(YAMessage *)theMessage
{
    return [theMessage snippet];
}

- (NSDate *)timestampForMessage:(YAMessage *)theMessage
{
    return [theMessage timestamp];
}

- (BOOL)messageHasNewStatus:(YAMessage *)theMessage
{
    return [self statusForMessage:theMessage] == YAMessageStatusNew;
}

- (BOOL)messageHasDrafStatus:(YAMessage *)theMessage
{
    return [self statusForMessage:theMessage] == YAMessageStatusDraft;
}

- (BOOL)messageHasPendingStatus:(YAMessage *)theMessage
{
    return [self statusForMessage:theMessage] == YAMessageStatusPending;
}

- (BOOL)messageHasSavedStatus:(YAMessage *)theMessage
{
    return [self statusForMessage:theMessage] == YAMessageStatusSaved;
}

- (BOOL)messageHasGapPlaceholderStatus:(YAMessage *)theMessage
{
    return [self statusForMessage:theMessage] == YAMessageStatusGapPlaceholder;
}

- (BOOL)messageHasSystemMessageStatus:(YAMessage *)theMessage
{
    return [self statusForMessage:theMessage] == YAMessageStatusSystemMessage;
}

- (YAMessageStatus)statusForMessage:(YAMessage *)theMessage
{
    return [[theMessage status] intValue];
}

- (void)deleteMessage:(YAMessage *)theMessage inManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext
{
    [theManagedObjectContext deleteObject:theMessage];
}

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YAMessageHandler ()

@end
