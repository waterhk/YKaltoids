//
//  YAConversationMessageListParsedJSONResponseHandlerCreator.h
//  altoids
//
//  Created by Jon Herron on 10/18/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConversationMessageListParsedJSONResponseHandlerCreator.h"
#import "MMCConversationToConversationInfoTranslator.h"

@protocol ParsedJSONResponseFilterer;

@interface YAConversationMessageListParsedJSONResponseHandlerCreator : NSObject <ConversationMessageListParsedJSONResponseHandlerCreator>

@property (strong, nonatomic) id<MMCConversationToConversationInfoTranslator> mmcConversationToConversationInfoTranslator;
@property (strong, nonatomic) id<ParsedJSONResponseFilterer> parsedJSONResponseFilterer;

@end
