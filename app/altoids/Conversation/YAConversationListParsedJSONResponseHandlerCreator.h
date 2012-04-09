//
//  YAConversationListParsedJSONResponseHandlerCreator.h
//  altoids
//
//  Created by Jon Herron on 9/20/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConversationListParsedJSONResponseHandlerCreator.h"

@protocol ParsedJSONResponseFilterer;
@protocol MMCConversationToConversationInfoTranslator;
@protocol ConversationListCommandErrorHandler;

@interface YAConversationListParsedJSONResponseHandlerCreator : NSObject <ConversationListParsedJSONResponseHandlerCreator>

@property (strong, nonatomic) id<MMCConversationToConversationInfoTranslator> mmcConversationToConversationInfoTranslator;
@property (strong, nonatomic) id<ConversationListCommandErrorHandler> conversationListCommandErrorHandler;
@property (strong, nonatomic) id<ParsedJSONResponseFilterer> parsedJSONResponseFilterer;

@end
