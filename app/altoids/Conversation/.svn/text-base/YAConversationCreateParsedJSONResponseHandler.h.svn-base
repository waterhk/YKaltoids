//
//  YAConversationCreateParsedJSONResponseHandler.h
//  altoids
//
//  Created by Jon Herron on 10/4/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConversationCreateCommandDelegate.h"
#import "ConversationCreateParsedJSONResponseHandler.h"
#import "ConversationHandler.h"
#import "MMCConversationToConversationInfoTranslator.h"
#import "MMCConversationErrorDetector.h"
#import "MMCErrorCreator.h"
#import "ConversationErrorHandlerFactory.h"
#import "YAConversation.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAConversationCreateParsedJSONResponseHandler : NSObject <ConversationCreateParsedJSONResponseHandler>

#pragma mark @property declarations

#pragma mark  Class methods

#pragma mark Instance methods

- (id)initWithConversationHandler:(id<ConversationHandler>)theConversationHandler 
mmcConversationToConversationInfoTranslator:(id<MMCConversationToConversationInfoTranslator>)theMMCConversationToConversationInfoTranslator 
     mmcConversationErrorDetector:(id<MMCConversationErrorDetector>)theMMCConversationErrorDetector 
                  mmcErrorCreator:(id<MMCErrorCreator>)theMMCErrorCreator
  conversationErrorHandlerFactory:(id<ConversationErrorHandlerFactory>)theConversationErrorHandlerFactory
                     conversation:(YAConversation *)theConversation 
                         delegate:(id<ConversationCreateCommandDelegate>)theConversationCreateCommandDelegate;

@end
