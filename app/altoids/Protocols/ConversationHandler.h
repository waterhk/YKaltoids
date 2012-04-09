//
//  ConversationHandler.h
//  altoids
//
//  Created by Jon Herron on 8/18/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>
#import "ConversationStatus.h"
#import "ManagedObjectContextFactory.h"
#import "YAConversation.h"
#import "YAParticipant.h"

@protocol ConversationHandler <NSObject>

- (YAConversation *)createConversationEntityInManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext;

- (BOOL)save:(YAConversation *)aConversation inManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext error:(NSError **)anError;

- (BOOL)saveConversations:(NSArray *)anArrayOfConversations inManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext error:(NSError **)anError;

- (void)deleteConversation:(YAConversation *)aConversation inManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext;

- (void)setParticipants:(NSSet *)aParticipants forConversation:(YAConversation *)aConversation;

- (void)setMessages:(NSSet *)theMessages forConversation:(YAConversation *)theConversation;

- (void)addMessage:(YAMessage *)aMessage toConversation:(YAConversation *)aConversation;

- (void)addMessages:(NSSet *)messages toConversation:(YAConversation *)aConversation;

- (void)setMostRecentMessage:(YAMessage *)aMessage forConversation:(YAConversation *)aConversation;

- (void)setConversationID:(NSString *)aConversationID forConversation:(YAConversation *)aConversation;

- (void)setTimestamp:(NSDate *)aTimestamp forConversation:(YAConversation *)aConversation;

- (void)setTopic:(NSString *)aTopic forConversation:(YAConversation *)aConversation;

- (void)setTotalMessages:(NSNumber *)aTotalMessages forConversation:(YAConversation *)aConversation;

- (void)setUnreadMessages:(NSNumber *)anUnreadMessages forConversation:(YAConversation *)aConversation;

- (void)setParticipantAsSender:(YAParticipant *)aParticipant forConversation:(YAConversation *)aConversation;

- (void)setStatusAsNewForConversation:(YAConversation *)aConversation;

- (void)setStatusAsDraftForConversation:(YAConversation *)aConversation;

- (void)setStatusAsPendingForConversation:(YAConversation *)aConversation;

- (BOOL)conversationStatusIsPending:(YAConversation*)aConversation;

- (void)setStatusAsPendingWithErrorsForConversation:(YAConversation *)aConversation;

- (void)setStatusAsSavedForConversation:(YAConversation *)aConversation;

- (void)setStatusAsReceivedWithErrorsForConversation:(YAConversation *)theConversation;

- (void)setStatusAsGapPlaceholderForConversation:(YAConversation *)aConversation;

- (void)setStatus:(YAConversationStatus)aStatus forConversation:(YAConversation *)aConversation;

- (void)setIsMuted:(BOOL)isMuted forConversation:(YAConversation *)theConversation;

- (NSString *)conversationIDForConversation:(YAConversation *)theConversation;

- (NSDate *)timestampForConversation:(YAConversation *)theConversation;

- (BOOL)conversationIsGapPlaceholder:(YAConversation *)theConversation;

- (NSManagedObjectID *)conversationObjectIDForConversation:(YAConversation *)theConversation;

- (NSSet *)messagesForConversation:(YAConversation *)theConversation;

- (YAParticipant *)senderForConversation:(YAConversation *)theConversation;

- (NSSet *)participantsForConversation:(YAConversation *)theConversation;

- (YAMessage *)mostRecentMessageForConversation:(YAConversation *)theConversation;

- (BOOL)conversationIsMuted:(YAConversation *)theConversation;

- (BOOL)conversationCreatedOnServer:(YAConversation *)theConversaiton;

- (BOOL)hasUnreadMessagesForConversation:(YAConversation *)aConversation;

@end
