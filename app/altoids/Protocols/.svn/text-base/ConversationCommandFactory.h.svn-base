//
//  ConversationCommandFactory.h
//  altoids
//
//  Created by Anand Subba Rao on 8/23/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Command.h"
#import "ConversationCreateCommandDelegate.h"
#import "ConversationEditCommandDelegate.h"
#import "ConversationListCommandDelegate.h"
#import "ConversationMessageListCommandDelegate.h"
#import "ConversationReplyCommandDelegate.h"
#import "ManagedObjectContextFactory.h"
@class YAConversation;
@protocol Command, TransactionCommand, TransactionCommandDelegate;

@protocol ConversationCommandFactory <NSObject>

- (id<Command>)conversationCreateCommandForConversation:(YAConversation *)theConversation withDelegate:(id<ConversationCreateCommandDelegate>)theDelegate;

- (id<TransactionCommand>)conversationListCommandForMostRecentConversationsWithDelegate:(id<ConversationListCommandDelegate>)theDelegate transactionDelegate:(id<TransactionCommandDelegate>)transactionDelegate;
- (id<Command>)conversationListCommandForConversationsAfterConversation:(YAConversation *)theConversation withDelegate:(id<ConversationListCommandDelegate>)theDelegate;

- (id<TransactionCommand>) conversationMessageListCommandForMostRecentMessagesInConversation:(YAConversation *)theConversation withDelegate:(id<ConversationMessageListCommandDelegate>)theDelegate transactionDelegate:(id<TransactionCommandDelegate>)transactionDelegate;
- (id<Command>)conversationMessageListCommandForMessagesAfterMessage:(YAMessage *)theMessage inConversation:(YAConversation *)theConversation withDelegate:(id<ConversationMessageListCommandDelegate>)theDelegate;

- (id<Command>)conversationReplyCommandForConversation:(YAConversation *)theConversation withMessage:(YAMessage *)message withDelegate:(id<ConversationReplyCommandDelegate>)theDelegate;

- (id<Command>)conversationEditCommandForConversation:(YAConversation *)theConversation withAdditionalParticipants:(NSArray *)theAdditionalParticipants removedParticipants:(NSArray *)theRemovedParticipants withViewForOverlay:(UIView*)theView withDelegate:(id<ConversationEditCommandDelegate>)theDelegate;
- (id<Command>)conversationMessagesFlagAsReadCommandWithConversation:(YAConversation *)conversation messageIDs:(NSArray *)messageIDs;

@end
