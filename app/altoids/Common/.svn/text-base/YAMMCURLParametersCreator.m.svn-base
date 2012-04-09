//
//  YAMMCURLParametersCreator.m
//  altoids
//
//  Created by Jon Herron on 9/30/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAMMCURLParametersCreator.h"
#import "YAMessage.h"

#define kActionKey @"action"
#define kConversationIDKey @"cid"
#define kConversationEditAction @"editConv"
#define kConversationReplyAction @"replyConv"
#define kCreateConversationAction @"createConv"
#define kFlagMessagesInConversationAction @"flagMsgsInConv"
#define kMessageFieldsKey @"rMsgFlds"
#define kMessageFieldsFlagsValue @"flags"
#define kMessageFieldsSnippetValue @"snippet"
#define kMessageDateKey @"midDate"
#define kMessageIDKey @"mid"
#define kMessageInfoFieldsKey @"mInfoFlds"
#define kNumberOfConversationIDsKey @"numCids"
#define kNumberOfConversationIDsValue @"11"
#define kNumberOfConversationsKey @"numCInfos"
#define kNumberOfConversationsValue @"10"
#define KNumberOfMessageIDsKey @"numMids"
#define kNumberOfMessageIDsValue @"11"
#define kNumberOfMessageInfosKey @"numMInfos"
#define kNumberOfMessageInfosValue @"10"
#define kDeactivationAction @"deactivate"
#define kServiceKey @"service"
#define kServiceValue @"mmc"

@implementation YAMMCURLParametersCreator

@synthesize conversationHandler = conversationHandler_;
@synthesize messageHandler = messageHandler_;
@synthesize urlParameterEncoder = urlParameterEncoder_;

- (NSDictionary *)urlParametersForCreateConversation
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            kCreateConversationAction, 
            kActionKey,
            kMessageFieldsSnippetValue,
            kMessageFieldsKey,
            nil];
}

- (NSDictionary *)urlParametersForDeactivation
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            kServiceValue,
            kServiceKey,
            kDeactivationAction, 
            kActionKey,
            nil];
}

- (NSDictionary *)urlParametersForConversationListFromMostRecentConversation
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            kNumberOfConversationIDsValue, 
            kNumberOfConversationIDsKey, 
            kNumberOfConversationsValue, 
            kNumberOfConversationsKey, 
            kMessageFieldsSnippetValue, 
            kMessageFieldsKey, 
            nil];
}

- (NSDictionary *)urlParametersForConversationListFromConversation:(YAConversation *)theConversation
{
    YAMessage *message = [[self conversationHandler] mostRecentMessageForConversation:theConversation];
    NSString *messageID = [[self messageHandler] messageIDForMessage:message];
    NSNumber *messageDate = [NSNumber numberWithDouble:[[[self messageHandler] timestampForMessage:message] timeIntervalSince1970]];
    
    NSString *conversationID = [[self conversationHandler] conversationIDForConversation:theConversation];    
        
    return [NSDictionary dictionaryWithObjectsAndKeys:
            kNumberOfConversationIDsValue, 
            kNumberOfConversationIDsKey, 
            kNumberOfConversationsValue, 
            kNumberOfConversationsKey, 
            kMessageFieldsSnippetValue, 
            kMessageFieldsKey, 
            conversationID,
            kConversationIDKey,
            messageID, 
            kMessageIDKey, 
            messageDate, 
            kMessageDateKey,
            nil];
}

- (NSDictionary *)urlParametersForConversationMessageListFromMostRecentMessage
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            kNumberOfMessageInfosValue, 
            kNumberOfMessageInfosKey, 
            kNumberOfMessageIDsValue, 
            KNumberOfMessageIDsKey, 
            kMessageFieldsFlagsValue, 
            kMessageFieldsKey, 
            kMessageFieldsFlagsValue, 
            kMessageInfoFieldsKey, 
            nil];
}

- (NSDictionary *)urlParametersForConversationMessageListFromMessage:(YAMessage *)theMessage
{
    NSString *messageID = [[self urlParameterEncoder] encodeURLParameter:[[self messageHandler] messageIDForMessage:theMessage]];
    NSNumber *messageDate = [NSNumber numberWithDouble:[[[self messageHandler] timestampForMessage:theMessage] timeIntervalSince1970]];
    
    return [NSDictionary dictionaryWithObjectsAndKeys:
            kNumberOfMessageInfosValue, 
            kNumberOfMessageInfosKey, 
            kNumberOfMessageIDsValue, 
            KNumberOfMessageIDsKey, 
            kMessageFieldsFlagsValue, 
            kMessageFieldsKey, 
            kMessageFieldsFlagsValue, 
            kMessageInfoFieldsKey, 
            messageID,
            kMessageIDKey, 
            messageDate, 
            kMessageDateKey,
            nil];
}

- (NSDictionary *)urlParametersForConversationReply
{
    return [NSDictionary dictionaryWithObject:kConversationReplyAction forKey:kActionKey];
}

- (NSDictionary *)urlParametersForFlaggingMessagesAsReadOrUnread
{
    return [NSDictionary dictionaryWithObject:kFlagMessagesInConversationAction forKey:kActionKey];
}

- (NSDictionary *)urlParametersForConversationEdit
{
    return [NSDictionary dictionaryWithObject:kConversationEditAction forKey:kActionKey];
}

@end
