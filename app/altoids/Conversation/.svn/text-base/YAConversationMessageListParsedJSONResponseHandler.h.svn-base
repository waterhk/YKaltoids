//
//  YAConversationMessageListParsedJSONResponseHandler.h
//  altoids
//
//  Created by Jon Herron on 10/18/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConversationMessageListParsedJSONResponseHandler.h"
#import "MMCConversationToConversationInfoTranslator.h"
#import "ConversationMessageListCommandDelegate.h"

@protocol ParsedJSONResponseFilterer;

@interface YAConversationMessageListParsedJSONResponseHandler : NSObject <ConversationMessageListParsedJSONResponseHandler>

- (id)initWithMMCConversationToConversationInfoTranslator:(id<MMCConversationToConversationInfoTranslator>)theMMCConversationToConversationInfoTranslator 
                   conversationMessageListCommandDelegate:(id<ConversationMessageListCommandDelegate>)theConversationMessageListCommandDelegate 
                               parsedJSONResponseFilterer:(id<ParsedJSONResponseFilterer>)aParsedJSONResponseFilterer;

@end
