//
//  ConversationErrorHandlerFactory.h
//  altoids
//
//  Created by Jon Herron on 11/28/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ErrorHandler.h"
#import "YAConversation.h"
#import "YAMessage.h"

@protocol ConversationErrorHandlerFactory <NSObject>

#pragma mark -
#pragma mark @required
@required

- (id<ErrorHandler>)conversationCreateErrorHandlerWithConversation:(YAConversation *)theConversation;
- (id<ErrorHandler>)conversationCreateErrorHandlerWithConversationObjectID:(NSManagedObjectID *)theConversationObjectID;

- (id<ErrorHandler>)conversationEditErrorHandlerWithConversation:(YAConversation *)theConversation;
- (id<ErrorHandler>)conversationEditErrorHandlerWithConversationObjectID:(NSManagedObjectID *)theConversationObjectID;

- (id<ErrorHandler>)conversationReplyErrorHandlerWithMessage:(YAMessage *)theMessage;
- (id<ErrorHandler>)conversationMessageListErrorHandlerWithConversation:(YAConversation *)conversation;
- (id<ErrorHandler>)conversationFlagMessagesAsReadErrorHandlerWithMessageIDs:(NSArray *)messageIDs;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
