//
//  YAConversationListParsedJSONResponseHandlerCreator.m
//  altoids
//
//  Created by Jon Herron on 9/20/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationListParsedJSONResponseHandlerCreator.h"
#import "MMCConversationToConversationInfoTranslator.h"
#import "ConversationListCommandErrorHandler.h"
#import "YAConversationListParsedJSONResponseHandler.h"
#import "ParsedJSONResponseFilterer.h"

@implementation YAConversationListParsedJSONResponseHandlerCreator

@synthesize mmcConversationToConversationInfoTranslator = mmcConversationToConversationInfoTransltor_;
@synthesize conversationListCommandErrorHandler = conversationListCommandErrorHandler_;
@synthesize parsedJSONResponseFilterer = parsedJSONResponseFilterer_;

- (id<ConversationListParsedJSONResponseHandler>)createWithDelegate:(id<ConversationListCommandDelegate>)aConversationListCommandDelegate
{
    return [[YAConversationListParsedJSONResponseHandler alloc] initWithMMCConversationToConversationInfoTranslator:[self mmcConversationToConversationInfoTranslator] 
                                                                                conversationListCommandErrorHandler:[self conversationListCommandErrorHandler]
                                                                                    conversationListCommandDelegate:aConversationListCommandDelegate
                                                                                         parsedJSONResponseFilterer:[self parsedJSONResponseFilterer]];
}

@end
