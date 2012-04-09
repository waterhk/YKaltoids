//
//  YAConversationCommandFactory.h
//  altoids
//
//  Created by Anand Subba Rao on 8/23/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConversationCommandFactory.h"
@protocol MMCCommandInstanceFactory, TransactionCommandInstanceFactory, ActivityOverlayCommandInstanceFactory, ConversationHandler, JSONParser, ConversationMessageListJSONParser, ConversationListParsedJSONResponseHandlerCreator, MMCURLParametersCreator, ConversationCreateRequestDataBuilder, ConversationCreateParsedJSONResponseHandlerCreator, ConversationURLRequestBuilderCreator, ConversationMessageListParsedJSONResponseHandlerCreator, ConversationReplyRequestDataBuilder, ConversationReplyParsedJSONResponseHandlerCreator, ConversationEditRequestDataBuilder, ConversationEditParsedJSONResponseHandlerCreator, ConversationFlagMessagesRequestDataBuilder, MessageHandler, CommandErrorHandlerCreator, ConversationErrorHandlerFactory;


@interface YAConversationCommandFactory : NSObject <ConversationCommandFactory>

@property (nonatomic, strong) id<MMCCommandInstanceFactory> mmcCommandInstanceFactory;
@property (nonatomic, strong) id<TransactionCommandInstanceFactory> transactionCommandInstanceFactory;
@property (nonatomic, strong) id<ActivityOverlayCommandInstanceFactory> activityOverlayCommandInstanceFactory;
@property (nonatomic, strong) id<ConversationHandler> conversationHandler;
@property (nonatomic, strong) id<JSONParser> jsonParser;
@property (nonatomic, strong) id<ConversationMessageListJSONParser> conversationMessageListJSONParser;
@property (nonatomic, strong) id<ConversationListParsedJSONResponseHandlerCreator> conversationListParsedJSONResponseHandlerCreator;
@property (nonatomic, strong) id<MMCURLParametersCreator> mmcURLParametersCreator;
@property (nonatomic, strong) id<ConversationCreateRequestDataBuilder> conversationCreateRequestDataBuilder;
@property (nonatomic, strong) id<ConversationCreateParsedJSONResponseHandlerCreator> conversationCreateParsedJSONResponseHandlerCreator;
@property (nonatomic, strong) id<ConversationURLRequestBuilderCreator> conversationURLRequestBuilderCreator;
@property (nonatomic, strong) id<ConversationMessageListParsedJSONResponseHandlerCreator> conversationMessageListParsedJSONResponseHandlerCreator;
@property (nonatomic, strong) id<ConversationReplyRequestDataBuilder> conversationReplyRequestDataBuilder;
@property (nonatomic, strong) id<ConversationReplyParsedJSONResponseHandlerCreator> conversationReplyParsedJSONResponseHandlerCreator;
@property (nonatomic, strong) id<ConversationEditRequestDataBuilder> conversationEditRequestDataBuilder;
@property (nonatomic, strong) id<ConversationEditParsedJSONResponseHandlerCreator> conversationEditParsedJSONResponseHandlerCreator;
@property (nonatomic, strong) id<ConversationFlagMessagesRequestDataBuilder> conversationFlagMessagesRequestDataBuilder;
@property (nonatomic, strong) id<MessageHandler> messageHandler;
@property (nonatomic, strong) id<CommandErrorHandlerCreator> commandErrorHandlerCreator;
@property (nonatomic, strong) id<ConversationErrorHandlerFactory> conversationErrorHandlerFactory;

@end
