//
//  YAConversationMessageListParsedJSONResponseHandlerCreator.m
//  altoids
//
//  Created by Jon Herron on 10/18/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationMessageListParsedJSONResponseHandlerCreator.h"
#import "YAConversationMessageListParsedJSONResponseHandler.h"

@implementation YAConversationMessageListParsedJSONResponseHandlerCreator

@synthesize mmcConversationToConversationInfoTranslator = mmcConversationToConversationInfoTranslator_;
@synthesize parsedJSONResponseFilterer = parsedJSONResponseFilterer_;

- (id<ConversationMessageListParsedJSONResponseHandler>)createWithDelegate:(id<ConversationMessageListCommandDelegate>)theDelegate
{
    return [[YAConversationMessageListParsedJSONResponseHandler alloc] initWithMMCConversationToConversationInfoTranslator:[self mmcConversationToConversationInfoTranslator] conversationMessageListCommandDelegate:theDelegate parsedJSONResponseFilterer:[self parsedJSONResponseFilterer]];
}

@end
