//
//  ConversationRepository.h
//  altoids
//
//  Created by Jon Herron on 8/17/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YAConversation, YAMessage, YAParticipant, YAParticipantInfo;
@protocol TransactionCommandDelegate, CommandTransaction;


@protocol ConversationRepository <NSObject>

- (YAConversation *)createConversationWithSender:(YAParticipantInfo *)aSender 
                                    participants:(NSArray *)aParticipants 
                                     messageBody:(NSString *)aMessageBody 
                                           error:(NSError **)aError;

- (void)markUnreadMessagesAsRead:(NSArray *)unreadMessages forConversation:(YAConversation *)aConversation;

- (void)deleteAllConversations;
- (void)deleteAllMessagesInConversation:(YAConversation *)theConversation;
- (id<CommandTransaction>)loadMostRecentConversationsWithTransactionDelegate:(id<TransactionCommandDelegate>)transactionDelegate;
- (void)loadConversationsAfterConversation:(YAConversation *)theConversation;

- (id<CommandTransaction>)loadMostRecentMessagesForConversation:(YAConversation *)theConversation transactionDelegate:(id<TransactionCommandDelegate>)transactionDelegate;
- (void)loadMessagesForConversation:(YAConversation *)theConversation afterMessage:(YAMessage *)theMessage;

- (BOOL)replyToConversation:(YAConversation *)aConversation messageBody:(NSString *)aMessageBody error:(NSError **)aError;
- (void)resendMessage:(YAMessage *)aMessage forConversation:(YAConversation *)aConversation;

- (void)removeParticipant:(YAParticipant *)theParticipant fromConversation:(YAConversation *)theConversation withViewForOverlay:(UIView*)theView;
- (BOOL)addParticipant:(YAParticipantInfo *)theParticipant toConversation:(YAConversation *)theConversation withViewForOverlay:(UIView*)theView error:(NSError **)anError;
- (BOOL)mergeParticipants:(NSArray *)anArrayOfParticipantInfo forConversation:(YAConversation *)aConversation withParticipantIDMap:(NSDictionary *)theParticipantIDMap error:(NSError **)anError;

@end
