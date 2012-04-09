//
//  YAConversationReplyParsedJSONResponseHandlerCreator.h
//  altoids
//
//  Created by Anand Biligiri on 10/26/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConversationReplyParsedJSONResponseHandlerCreator.h"
#import "ConversationReplyParsedJSONResponseHandler.h"
#import "MMCConversationReplyToConversationReplyInfoTranslator.h"
#import "YAConversation.h"
#import "YAMessage.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAConversationReplyParsedJSONResponseHandlerCreator : NSObject <ConversationReplyParsedJSONResponseHandlerCreator>

#pragma mark @property declarations
@property (nonatomic, strong) id<MMCConversationReplyToConversationReplyInfoTranslator> mmcConversationReplyToConversationReplyInfoTranslator;

#pragma mark  Class methods

#pragma mark Instance methods

@end
