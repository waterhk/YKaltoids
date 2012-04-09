//
//  YAConversationCommandFactory.m
//  altoids
//
//  Created by Anand Subba Rao on 8/23/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationCommandFactory.h"
#import "AppFactory.h"
#import "ConversationHandler.h"
#import "ConversationCreateParsedJSONResponseHandlerCreator.h"
#import "ConversationCreateRequestDataBuilder.h"
#import "ConversationEditRequestDataBuilder.h"
#import "ConversationEditParsedJSONResponseHandlerCreator.h"
#import "ConversationFlagMessagesRequestDataBuilder.h"
#import "ConversationListParsedJSONResponseHandlerCreator.h"
#import "ConversationMessageListJSONParser.h"
#import "ConversationMessageListParsedJSONResponseHandlerCreator.h"
#import "ConversationReplyRequestDataBuilder.h"
#import "ConversationReplyParsedJSONResponseHandlerCreator.h"
#import "ConversationURLRequestBuilderCreator.h"
#import "MMCURLParametersCreator.h"
#import "ParsedJSONResponseHandler.h"
#import "MessageHandler.h"
#import "CommandErrorHandlerCreator.h"
#import "ConversationErrorHandlerFactory.h"
#import "ConversationReplyParsedJSONResponseHandler.h"
#import "Command.h"
#import "TransactionCommand.h"
#import "TransactionCommandDelegate.h"

@interface YAConversationCommandFactory ()

- (id<Command>)conversationListCommandWithRequestParameters:(NSDictionary *)theRequestParameters delegate:(id<ConversationListCommandDelegate>)theDelegate;
- (id<Command>)conversationMessageListCommandForMessagesInConversation:(YAConversation *)theConversation withRequestParameters:(NSDictionary *)theRequestParameters delegate:(id<ConversationMessageListCommandDelegate>)theDelegate;
- (id<TransactionCommand>)conversationListCommandWithRequestParameters:(NSDictionary *)theRequestParameters delegate:(id<ConversationListCommandDelegate>)theDelegate transactionDelegate:(id<TransactionCommandDelegate>)transactionDelegate;
- (id<TransactionCommand>)conversationMessageListCommandForMessagesInConversation:(YAConversation *)theConversation withRequestParameters:(NSDictionary *)theRequestParameters delegate:(id<ConversationMessageListCommandDelegate>)theDelegate transactionDelegate:(id<TransactionCommandDelegate>)transactionDelegate;

@end

@implementation YAConversationCommandFactory

@synthesize mmcCommandInstanceFactory = mmcCommandInstanceFactory_,
            transactionCommandInstanceFactory = transactionCommandInstanceFactory_,
            activityOverlayCommandInstanceFactory = activityOverlayCommandInstanceFactory_;
@synthesize conversationHandler = conversationHandler_;
@synthesize jsonParser = jsonParser_;
@synthesize conversationMessageListJSONParser = conversationMessageListJSONParser_;
@synthesize conversationListParsedJSONResponseHandlerCreator = conversationListParsedJSONResponseHandlerCreator_;
@synthesize mmcURLParametersCreator = mmcURLParametersCreator_;
@synthesize conversationCreateRequestDataBuilder = conversationCreateRequestDataBuilder_;
@synthesize conversationCreateParsedJSONResponseHandlerCreator = conversationCreateParsedJSONResponseHandlerCreator_;
@synthesize conversationURLRequestBuilderCreator = conversationURLRequestBuilderCreator_;
@synthesize conversationMessageListParsedJSONResponseHandlerCreator = conversationMessageListParsedJSONResponseHandlerCreator_;
@synthesize conversationReplyRequestDataBuilder = conversationReplyRequestDataBuilder_;
@synthesize conversationReplyParsedJSONResponseHandlerCreator = conversationReplyParsedJSONResponseHandlerCreator_;
@synthesize conversationEditRequestDataBuilder = conversationEditRequestDataBuilder_;
@synthesize conversationEditParsedJSONResponseHandlerCreator = conversationEditParsedJSONResponseHandlerCreator_;
@synthesize conversationFlagMessagesRequestDataBuilder = conversationFlagMessagesRequestDataBuilder_;
@synthesize messageHandler = messageHandler_;
@synthesize commandErrorHandlerCreator = commandErrorHandlerCreator_;
@synthesize conversationErrorHandlerFactory = conversationErrorHandlerFactory_;


- (id<Command>)conversationCreateCommandForConversation:(YAConversation *)theConversation withDelegate:(id<ConversationCreateCommandDelegate>)theDelegate
{
    id<ErrorHandler> specificErrorHandler = [[self conversationErrorHandlerFactory] conversationCreateErrorHandlerWithConversation:theConversation];
    id<CommandErrorHandler> commandErrorHandler = [[self commandErrorHandlerCreator] createWithErrorHandler:specificErrorHandler];
    
    id<ConversationCreateParsedJSONResponseHandler> conversationCreateParsedJSONResponseHandler = [[self conversationCreateParsedJSONResponseHandlerCreator] createWithConversation:theConversation delegate:theDelegate];
    id<URLRequestBuilder> requestBuilder = [[self conversationURLRequestBuilderCreator] createConversationCreateURLRequestBuilder];
    NSDictionary *requestData = [[self conversationCreateRequestDataBuilder] requestDataForConversation:theConversation];
    NSDictionary *requestParameters = [[self mmcURLParametersCreator] urlParametersForCreateConversation];

    return [mmcCommandInstanceFactory_ createMMCCommandWithURLRequestBuilder:requestBuilder
                                                        urlRequestParameters:requestParameters
                                                              urlRequestData:requestData
                                                                  jsonParser:jsonParser_
                                                   parsedJSONResponseHandler:conversationCreateParsedJSONResponseHandler
                                                         commandErrorHandler:commandErrorHandler];
}

- (id<TransactionCommand>)conversationListCommandForMostRecentConversationsWithDelegate:(id<ConversationListCommandDelegate>)theDelegate transactionDelegate:(id<TransactionCommandDelegate>)transactionDelegate
{
    NSDictionary *requestParameters = nil;
    
    requestParameters = [[self mmcURLParametersCreator] urlParametersForConversationListFromMostRecentConversation];
    
    return [self conversationListCommandWithRequestParameters:requestParameters delegate:theDelegate transactionDelegate:transactionDelegate];
}

- (id<Command>)conversationListCommandForConversationsAfterConversation:(YAConversation *)theConversation withDelegate:(id<ConversationListCommandDelegate>)theDelegate
{
    NSDictionary *requestParameters = nil;
    
    requestParameters = [[self mmcURLParametersCreator] urlParametersForConversationListFromConversation:theConversation];
    
    return [self conversationListCommandWithRequestParameters:requestParameters delegate:theDelegate];
}

- (id<TransactionCommand>) conversationMessageListCommandForMostRecentMessagesInConversation:(YAConversation *)theConversation withDelegate:(id<ConversationMessageListCommandDelegate>)theDelegate transactionDelegate:(id<TransactionCommandDelegate>)transactionDelegate
{
    NSDictionary *requestParameters = [[self mmcURLParametersCreator] urlParametersForConversationMessageListFromMostRecentMessage];
    
    return [self conversationMessageListCommandForMessagesInConversation:theConversation withRequestParameters:requestParameters delegate:theDelegate transactionDelegate:transactionDelegate];
}

- (id<Command>)conversationMessageListCommandForMessagesAfterMessage:(YAMessage *)theMessage inConversation:(YAConversation *)theConversation withDelegate:(id<ConversationMessageListCommandDelegate>)theDelegate
{
    NSDictionary *requestParameters = [[self mmcURLParametersCreator] urlParametersForConversationMessageListFromMessage:theMessage];
    
    return [self conversationMessageListCommandForMessagesInConversation:theConversation withRequestParameters:requestParameters delegate:theDelegate];
}

- (id<Command>)conversationReplyCommandForConversation:(YAConversation *)theConversation withMessage:(YAMessage *)message withDelegate:(id<ConversationReplyCommandDelegate>)theDelegate
{
    NSString *messageBody = [[self messageHandler] bodyForMessage:message];
    
    id<ConversationReplyParsedJSONResponseHandler> conversationReplyParsedJSONResponseHandler = 
    [[self conversationReplyParsedJSONResponseHandlerCreator] createWithMessage:message delegate:theDelegate];
    id<URLRequestBuilder> requestBuilder = [[self conversationURLRequestBuilderCreator] createConversationReplyURLRequestBuilderForReplyingToConversation:theConversation];
    NSDictionary *requestData = [[self conversationReplyRequestDataBuilder] requestDataForReplyingToConversationWithMessageBody:messageBody];
    NSDictionary *requestParameters = [[self mmcURLParametersCreator] urlParametersForConversationReply];
    
    id<ErrorHandler> specificErrorHandler = [[self conversationErrorHandlerFactory] conversationReplyErrorHandlerWithMessage:message];
    id<CommandErrorHandler> commandErrorHandler = [[self commandErrorHandlerCreator] createWithErrorHandler:specificErrorHandler];

    return [mmcCommandInstanceFactory_ createMMCCommandWithURLRequestBuilder:requestBuilder
                                                        urlRequestParameters:requestParameters
                                                              urlRequestData:requestData
                                                                  jsonParser:jsonParser_
                                                   parsedJSONResponseHandler:conversationReplyParsedJSONResponseHandler
                                                         commandErrorHandler:commandErrorHandler];
}

- (id<Command>)conversationEditCommandForConversation:(YAConversation *)theConversation withAdditionalParticipants:(NSArray *)theAdditionalParticipants removedParticipants:(NSArray *)theRemovedParticipants withViewForOverlay:(UIView *)theView withDelegate:(id<ConversationEditCommandDelegate>)theDelegate
{
    id<ConversationEditParsedJSONResponseHandler> conversationEditParsedJSONResponseHandler = [[self conversationEditParsedJSONResponseHandlerCreator] createForConversation:theConversation withDelegate:theDelegate];
    id<URLRequestBuilder> requestBuilder = [[self conversationURLRequestBuilderCreator] createConversationEditURLRequestBuilderForEditingConversation:theConversation];
    NSDictionary *requestData = [[self conversationEditRequestDataBuilder] requestDataForEditingConversationWithAdditionalParticipants:theAdditionalParticipants removedParticipants:theRemovedParticipants];
    NSDictionary *requestParameters = [[self mmcURLParametersCreator] urlParametersForConversationEdit];
    
    id<ErrorHandler> specificErrorHandler = [[self conversationErrorHandlerFactory] conversationEditErrorHandlerWithConversation:theConversation];
    id<CommandErrorHandler> commandErrorHandler = [[self commandErrorHandlerCreator] createWithErrorHandler:specificErrorHandler];

    id<Command> command = [mmcCommandInstanceFactory_ createMMCCommandWithURLRequestBuilder:requestBuilder
                                                        urlRequestParameters:requestParameters
                                                              urlRequestData:requestData
                                                                  jsonParser:jsonParser_
                                                   parsedJSONResponseHandler:conversationEditParsedJSONResponseHandler
                                                         commandErrorHandler:commandErrorHandler];

    return [activityOverlayCommandInstanceFactory_ createActivityOverlayCommandWithCommand:command view:theView];
}

- (id<Command>)conversationListCommandWithRequestParameters:(NSDictionary *)theRequestParameters delegate:(id<ConversationListCommandDelegate>)theDelegate
{
    return [self conversationListCommandWithRequestParameters:theRequestParameters delegate:theDelegate transactionDelegate:nil];
}

- (id<Command>)conversationMessageListCommandForMessagesInConversation:(YAConversation *)theConversation 
                                                 withRequestParameters:(NSDictionary *)theRequestParameters 
                                                              delegate:(id<ConversationMessageListCommandDelegate>)theDelegate
{
    return [self conversationMessageListCommandForMessagesInConversation:theConversation withRequestParameters:theRequestParameters delegate:theDelegate transactionDelegate:nil];
}

- (id<TransactionCommand>)conversationListCommandWithRequestParameters:(NSDictionary *)theRequestParameters delegate:(id<ConversationListCommandDelegate>)theDelegate transactionDelegate:(id<TransactionCommandDelegate>)transactionDelegate
{
    id<ConversationListParsedJSONResponseHandler> conversationListParsedJSONResponseHandler = nil;
    id<URLRequestBuilder> conversationListURLRequestBuilder = nil;
    
    // todo: create specificErrorHandler
    id<ErrorHandler> specificErrorHandler = nil;
    id<CommandErrorHandler> commandErrorHandler = [[self commandErrorHandlerCreator] createWithErrorHandler:specificErrorHandler];
    
    conversationListParsedJSONResponseHandler = [[self conversationListParsedJSONResponseHandlerCreator] createWithDelegate:theDelegate];
    conversationListURLRequestBuilder = [[self conversationURLRequestBuilderCreator] createConversationListURLRequestBuilder];

    id<Command> command = [mmcCommandInstanceFactory_ createMMCCommandWithURLRequestBuilder:conversationListURLRequestBuilder
                                                        urlRequestParameters:theRequestParameters
                                                              urlRequestData:nil
                                                                  jsonParser:jsonParser_
                                                   parsedJSONResponseHandler:conversationListParsedJSONResponseHandler
                                                         commandErrorHandler:commandErrorHandler];

    return [transactionCommandInstanceFactory_ createTransactionCommandWithCommand:command delegate:transactionDelegate];
}

- (id<TransactionCommand>)conversationMessageListCommandForMessagesInConversation:(YAConversation *)theConversation withRequestParameters:(NSDictionary *)theRequestParameters delegate:(id<ConversationMessageListCommandDelegate>)theDelegate transactionDelegate:(id<TransactionCommandDelegate>)transactionDelegate
{
    id<ConversationMessageListParsedJSONResponseHandler> conversationMessageListParsedJSONResponseHandler = nil;
    id<URLRequestBuilder> urlRequestBuilder = nil;
    
    // todo: create specificErrorHandler
    id<ErrorHandler> specificErrorHandler = [[self conversationErrorHandlerFactory] conversationMessageListErrorHandlerWithConversation:theConversation];
    id<CommandErrorHandler> commandErrorHandler = [[self commandErrorHandlerCreator] createWithErrorHandler:specificErrorHandler];
    
    conversationMessageListParsedJSONResponseHandler = [[self conversationMessageListParsedJSONResponseHandlerCreator] createWithDelegate:theDelegate];
    urlRequestBuilder = [[self conversationURLRequestBuilderCreator] createConversationMessageListURLRequestBuilderForMessagesInConversation:theConversation];

    id<Command> command =  [mmcCommandInstanceFactory_ createMMCCommandWithURLRequestBuilder:urlRequestBuilder
                                                        urlRequestParameters:theRequestParameters
                                                              urlRequestData:nil
                                                                  jsonParser:conversationMessageListJSONParser_
                                                   parsedJSONResponseHandler:conversationMessageListParsedJSONResponseHandler
                                                         commandErrorHandler:commandErrorHandler];
    return [transactionCommandInstanceFactory_ createTransactionCommandWithCommand:command delegate:transactionDelegate];
}

- (id<Command>)conversationMessagesFlagAsReadCommandWithConversation:(YAConversation *)conversation messageIDs:(NSArray *)messageIDs
{
    id<URLRequestBuilder> urlRequestBuilder = [[self conversationURLRequestBuilderCreator] urlRequestBuilderToFlagMessagesInConversation:conversation];
    NSDictionary *requestData = [[self conversationFlagMessagesRequestDataBuilder] requestDataToFlagMessagesAsRead:messageIDs];
    NSDictionary *requestParameters = [[self mmcURLParametersCreator] urlParametersForFlaggingMessagesAsReadOrUnread];
        
    id<ErrorHandler> specificErrorHandler = [[self conversationErrorHandlerFactory] conversationFlagMessagesAsReadErrorHandlerWithMessageIDs:messageIDs];
    id<CommandErrorHandler> commandErrorHandler = [[self commandErrorHandlerCreator] createWithErrorHandler:specificErrorHandler];

    return [mmcCommandInstanceFactory_ createMMCCommandWithURLRequestBuilder:urlRequestBuilder
                                                        urlRequestParameters:requestParameters
                                                              urlRequestData:requestData
                                                                  jsonParser:jsonParser_
                                                   parsedJSONResponseHandler:nil
                                                         commandErrorHandler:commandErrorHandler];
}

@end
