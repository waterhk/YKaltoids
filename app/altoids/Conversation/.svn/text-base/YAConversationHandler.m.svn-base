//
//  YAConversationsHandler.m
//  altoids
//
//  Created by Jon Herron on 8/19/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "YAConversation.h"
#import "YAConversationContext.h"
#import "YAConversationHandler.h"

@interface YAConversationHandler ()

- (BOOL)validConversation:(YAConversation *)aConversation error:(NSError **)anError;

@end

@implementation YAConversationHandler

@synthesize conversationValidatorFactory = conversationValidatorFactory_;

- (YAConversation *)createConversationEntityInManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext
{
    YAConversation *conversation = [NSEntityDescription insertNewObjectForEntityForName:CONVERSATION_ENTITY_NAME inManagedObjectContext:aManagedObjectContext];
    
    //for now (0.1) we just put in a dummy conversation context
    YAConversationContext *conversationContext = [NSEntityDescription insertNewObjectForEntityForName:CONVERSATION_CONTEXT_ENTITY_NAME inManagedObjectContext:aManagedObjectContext];
    
    [conversation setConversationContext:conversationContext];
    
    return conversation;
}

- (BOOL)save:(YAConversation *)aConversation inManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext error:(NSError **)anError
{
    if ([self validConversation:aConversation error:anError])
    {
        return [aManagedObjectContext save:anError];
    }
    
    return NO;
}

- (BOOL)saveConversations:(NSArray *)anArrayOfConversations inManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext error:(NSError **)anError
{
    for (YAConversation *conversation in anArrayOfConversations) 
    {
        if (![self validConversation:conversation error:anError]) 
        {
            YALogError(@"Unable to save conversation: id %@, status: %d, error: %@", [conversation conversationID], [[conversation status] intValue], [[*anError userInfo] objectForKey:NSLocalizedDescriptionKey]);
            
            return NO;
        }
    }
    
    return [aManagedObjectContext save:anError];
}

- (void)deleteConversation:(YAConversation *)aConversation inManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext
{
    [aManagedObjectContext deleteObject:aConversation];
}

- (void)setParticipants:(NSSet *)aParticipants forConversation:(YAConversation *)aConversation
{
    [aConversation setParticipants:aParticipants];
}

- (void)setMessages:(NSSet *)theMessages forConversation:(YAConversation *)theConversation
{
    [theConversation setMessages:theMessages];
}

- (void)addMessage:(YAMessage *)aMessage toConversation:(YAConversation *)aConversation
{
    [aConversation addMessagesObject:aMessage];
}

- (void)addMessages:(NSSet *)messages toConversation:(YAConversation *)aConversation
{
    [aConversation addMessages:messages];    
}

- (void)setMostRecentMessage:(YAMessage *)aMessage forConversation:(YAConversation *)aConversation
{
    [aConversation setMostRecentMessage:aMessage];
}

- (void)setConversationID:(NSString *)aConversationID forConversation:(YAConversation *)aConversation
{
    [aConversation setConversationID:aConversationID];
}

- (void)setTimestamp:(NSDate *)aTimestamp forConversation:(YAConversation *)aConversation
{
    [aConversation setTimestamp:aTimestamp];
}

- (void)setTopic:(NSString *)aTopic forConversation:(YAConversation *)aConversation
{
    [aConversation setTopic:aTopic];
}

- (void)setTotalMessages:(NSNumber *)aTotalMessages forConversation:(YAConversation *)aConversation
{
    [aConversation setTotalMessages:aTotalMessages];
}

- (void)setUnreadMessages:(NSNumber *)anUnreadMessages forConversation:(YAConversation *)aConversation
{
    [aConversation setUnreadMessages:anUnreadMessages];
}

- (void)setParticipantAsSender:(YAParticipant *)aParticipant forConversation:(YAConversation *)aConversation
{
    [aConversation setSender:aParticipant];
}

- (void)setStatusAsNewForConversation:(YAConversation *)aConversation
{
    [self setStatus:YAConversationStatusNew forConversation:aConversation];
}

- (void)setStatusAsDraftForConversation:(YAConversation *)aConversation
{
    [self setStatus:YAConversationStatusDraft forConversation:aConversation];
}

- (void)setStatusAsPendingForConversation:(YAConversation *)aConversation
{
    [self setStatus:YAConversationStatusPending forConversation:aConversation];
}

- (void)setStatusAsPendingWithErrorsForConversation:(YAConversation *)aConversation
{
    [self setStatus:YAConversationStatusPendingWithErrors forConversation:aConversation];
}

- (void)setStatusAsSavedForConversation:(YAConversation *)aConversation
{
    [self setStatus:YAConversationStatusSaved forConversation:aConversation];
}

- (void)setStatusAsReceivedWithErrorsForConversation:(YAConversation *)theConversation
{
    [self setStatus:YAConversationStatusReceivedWithErrors forConversation:theConversation];
}

- (void)setStatusAsGapPlaceholderForConversation:(YAConversation *)aConversation
{
    [self setStatus:YAConversationStatusGapPlaceholder forConversation:aConversation];
}

- (void)setStatus:(YAConversationStatus)aStatus forConversation:(YAConversation *)aConversation
{
    [aConversation setStatus:[NSNumber numberWithInt:aStatus]];
}

- (void)setIsMuted:(BOOL)isMuted forConversation:(YAConversation *)theConversation
{
    [theConversation setIsMuted:[NSNumber numberWithBool:isMuted]];
}

- (NSString *)conversationIDForConversation:(YAConversation *)theConversation
{
    return [theConversation conversationID];
}

- (NSDate *)timestampForConversation:(YAConversation *)theConversation
{
    return [theConversation timestamp];
}

- (BOOL)conversationIsGapPlaceholder:(YAConversation *)theConversation
{
    return [[theConversation status] intValue] == YAConversationStatusGapPlaceholder;
}

- (NSManagedObjectID *)conversationObjectIDForConversation:(YAConversation *)theConversation
{
    return [theConversation objectID];
}

- (NSSet *)messagesForConversation:(YAConversation *)theConversation
{
    return [theConversation messages];
}

- (YAParticipant *)senderForConversation:(YAConversation *)theConversation
{
    return [theConversation sender];
}

- (NSSet *)participantsForConversation:(YAConversation *)theConversation
{
    return [theConversation participants];
}

- (YAMessage *)mostRecentMessageForConversation:(YAConversation *)theConversation
{
    return [theConversation mostRecentMessage];
}

- (BOOL)conversationIsMuted:(YAConversation *)theConversation
{
    return [[theConversation isMuted] boolValue];
}

- (BOOL)conversationCreatedOnServer:(YAConversation *)theConversation
{
    YAConversationStatus status = [[theConversation status] intValue];
    return (status == YAConversationStatusSaved ||
            status == YAConversationStatusReceivedWithErrors);
}

- (BOOL)hasUnreadMessagesForConversation:(YAConversation *)aConversation {
    if ([[aConversation unreadMessages] intValue] > 0) {
        return true;
    } else {
        return false;
    }
}

- (BOOL)conversationStatusIsPending:(YAConversation*)aConversation
{
    if ([[aConversation status] intValue] == YAConversationStatusPending) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark -
#pragma mark Private Methods

- (BOOL)validConversation:(YAConversation *)aConversation error:(NSError **)anError
{
    id<ConversationValidator> validator = [[self conversationValidatorFactory] createValidatorForConversation:aConversation];
    
    return [validator conversationIsValid:aConversation error:anError];
}

@end
