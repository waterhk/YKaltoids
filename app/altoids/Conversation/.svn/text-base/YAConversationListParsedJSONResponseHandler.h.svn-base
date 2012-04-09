//
//  YAConversationListParsedJSONResponseHandler.h
//  altoids
//
//  Created by Jon Herron on 9/16/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConversationListParsedJSONResponseHandler.h"

@protocol MMCConversationToConversationInfoTranslator;
@protocol ConversationListCommandErrorHandler;
@protocol ConversationListCommandDelegate;
@protocol ParsedJSONResponseFilterer;

@interface YAConversationListParsedJSONResponseHandler : NSObject <ConversationListParsedJSONResponseHandler>

- (id)initWithMMCConversationToConversationInfoTranslator:(id<MMCConversationToConversationInfoTranslator>)anMMCConversationToConversationInfoTranslator 
                      conversationListCommandErrorHandler:(id<ConversationListCommandErrorHandler>)theConversationListCommandErrorHandler 
                          conversationListCommandDelegate:(id<ConversationListCommandDelegate>)aConversationListCommandDelegate 
                               parsedJSONResponseFilterer:(id<ParsedJSONResponseFilterer>)aParsedJSONResponseFilterer;

@end
