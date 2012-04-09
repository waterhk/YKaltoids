//
//  MessageHandler.h
//  altoids
//
//  Created by Jon Herron on 8/23/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>
#import "MessageStatus.h"
#import "YAConversation.h"
#import "YAMessage.h"
#import "YAParticipant.h"

@protocol MessageHandler <NSObject>

#pragma mark -
#pragma mark @required
@required

- (YAMessage *)createMessageEntityInManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext;

- (void)setBody:(NSString *)aBody forMessage:(YAMessage *)aMessage;
- (void)setMessageID:(NSString *)aMessageID forMessage:(YAMessage *)aMessage;
- (void)setRead:(BOOL)aRead forMessage:(YAMessage *)aMessage;
- (void)setSnippet:(NSString *)aSnippet forMessage:(YAMessage *)aMessage;
- (void)setTimestamp:(NSDate *)aTimestamp forMessage:(YAMessage *)aMessage;
- (void)setParticipantAsSender:(YAParticipant *)aParticipant ofMessage:(YAMessage *)aMessage;

- (void)setStatusAsNewForMessage:(YAMessage *)theMessage;
- (void)setStatusAsDraftForMessage:(YAMessage *)theMessage;
- (void)setStatusAsPendingForMessage:(YAMessage *)theMessage;
- (void)setStatusAsPendingWithErrorsForMessage:(YAMessage *)theMessage;
- (void)setStatusAsSavedForMessage:(YAMessage *)theMessage;
- (void)setStatusAsGapPlaceholderForMessage:(YAMessage *)theMessage;
- (void)setStatusAsSystemMessageForMessage:(YAMessage *)theMessage;
- (void)setStatus:(YAMessageStatus)theStatus forMessage:(YAMessage *)theMessage;

- (NSString *)bodyForMessage:(YAMessage *)theMessage;
- (NSString *)messageIDForMessage:(YAMessage *)theMessage;
- (NSManagedObjectID *)messageObjectIDForMessage:(YAMessage *)message;
- (YAParticipant *)senderForMessage:(YAMessage *)theMessage;
- (NSString *)snippetForMessage:(YAMessage *)theMessage;
- (NSDate *)timestampForMessage:(YAMessage *)theMessage;

- (BOOL)messageHasNewStatus:(YAMessage *)theMessage;
- (BOOL)messageHasDrafStatus:(YAMessage *)theMessage;
- (BOOL)messageHasPendingStatus:(YAMessage *)theMessage;
- (BOOL)messageHasSavedStatus:(YAMessage *)theMessage;
- (BOOL)messageHasGapPlaceholderStatus:(YAMessage *)theMessage;
- (BOOL)messageHasSystemMessageStatus:(YAMessage *)theMessage;
- (YAMessageStatus)statusForMessage:(YAMessage *)theMessage;

- (void)deleteMessage:(YAMessage *)theMessage inManagedObjectContext:(NSManagedObjectContext *)theManagedObjectContext;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
