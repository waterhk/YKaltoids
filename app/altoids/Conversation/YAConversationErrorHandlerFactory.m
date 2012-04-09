//
//  YAConversationErrorHandlerFactory.m
//  altoids
//
//  Created by Jon Herron on 11/28/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationErrorHandlerFactory.h"
#import "YAConversationCreateErrorHandler.h"
#import "YAConversationEditErrorHandler.h"
#import "YAConversationFlagMessagesAsReadErrorHandler.h"
#import "YAConversationMessageListCommandErrorHandler.h"
#import "YAConversationReplyErrorHandler.h"

@implementation YAConversationErrorHandlerFactory

@synthesize managedObjectContextFactory = managedObjectContextFactory_;
@synthesize conversationHandler = conversationHandler_;
@synthesize messageHandler = messageHandler_;
@synthesize messageLocator = messageLocator_;

- (id<ErrorHandler>)conversationCreateErrorHandlerWithConversation:(YAConversation *)theConversation
{
    return [self conversationCreateErrorHandlerWithConversationObjectID:[theConversation objectID]];
}

- (id<ErrorHandler>)conversationCreateErrorHandlerWithConversationObjectID:(NSManagedObjectID *)theConversationObjectID
{
    return [[YAConversationCreateErrorHandler alloc] initWithConversationHandler:[self conversationHandler] managedObjectContextFactory:[self managedObjectContextFactory] conversationObjectID:theConversationObjectID messageHandler:[self messageHandler]];
}

- (id<ErrorHandler>)conversationEditErrorHandlerWithConversation:(YAConversation *)theConversation
{
    return [self conversationEditErrorHandlerWithConversationObjectID:[theConversation objectID]];
}

- (id<ErrorHandler>)conversationEditErrorHandlerWithConversationObjectID:(NSManagedObjectID *)theConversationObjectID
{
    return [[YAConversationEditErrorHandler alloc] initWithConversationHandler:[self conversationHandler] managedObjectContextFactory:[self managedObjectContextFactory] conversationObjectID:theConversationObjectID];
}

- (id<ErrorHandler>)conversationReplyErrorHandlerWithMessage:(YAMessage *)theMessage
{
    return [[YAConversationReplyErrorHandler alloc] initWithMessage:theMessage messageHandler:[self messageHandler] managedObjectContextFactory:[self managedObjectContextFactory]];
}

- (id<ErrorHandler>)conversationMessageListErrorHandlerWithConversation:(YAConversation *)conversation
{
    return [[YAConversationMessageListCommandErrorHandler alloc] initWithConversationObjectID:[conversation objectID] managedObjectContextFactory:[self managedObjectContextFactory]];
}

- (id<ErrorHandler>)conversationFlagMessagesAsReadErrorHandlerWithMessageIDs:(NSArray *)messageIDs
{
    return [[YAConversationFlagMessagesAsReadErrorHandler alloc] initWithManagedObjectContextFactory:[self managedObjectContextFactory]
                                                                                      messageLocator:[self messageLocator]
                                                                                      messageHandler:[self messageHandler]
                                                                                    messageIDs:messageIDs];
}

@end
