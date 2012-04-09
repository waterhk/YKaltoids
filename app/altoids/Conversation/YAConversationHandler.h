//
//  YAConversationsHandler.h
//  altoids
//
//  Created by Jon Herron on 8/19/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConversationHandler.h"
#import "ConversationValidatorFactory.h"


#define CONVERSATION_CONTEXT_ENTITY_NAME @"ConversationContext"
#define CONVERSATION_ENTITY_NAME @"Conversation"

@interface YAConversationHandler : NSObject <ConversationHandler>

@property (strong, nonatomic) id<ConversationValidatorFactory> conversationValidatorFactory;

@end
