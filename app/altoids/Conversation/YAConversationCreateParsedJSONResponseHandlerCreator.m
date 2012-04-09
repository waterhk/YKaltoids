//
//  YAConversationCreateParsedJSONResponseHandlerCreator.m
//  altoids
//
//  Created by Jon Herron on 10/5/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationCreateParsedJSONResponseHandlerCreator.h"
#import "YAConversationCreateParsedJSONResponseHandler.h"

// Private class extension
@interface YAConversationCreateParsedJSONResponseHandlerCreator ()

// @property definitions

// methods

@end

@implementation YAConversationCreateParsedJSONResponseHandlerCreator

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize conversationHandler = conversationHandler_;
@synthesize mmcConversationToConversationInfoTranslator = mmcConversationToConversationInfoTranslator_;
@synthesize mmcConversationErrorDetector = mmcConversationErrorDetector_;
@synthesize mmcErrorCreator = mmcErrorCreator_;
@synthesize conversationErrorHandlerFactory = conversationErrorHandlerFactory_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark ConversationCreateParsedJSONResponseHandlerCreator delegate methods

- (id<ConversationCreateParsedJSONResponseHandler>)createWithConversation:(YAConversation *)theConversation 
                                                                 delegate:(id<ConversationCreateCommandDelegate>)theConversationCreateCommandDelegate
{
    return [[YAConversationCreateParsedJSONResponseHandler alloc] initWithConversationHandler:[self conversationHandler]
                                                  mmcConversationToConversationInfoTranslator:[self mmcConversationToConversationInfoTranslator] 
                                                                 mmcConversationErrorDetector:[self mmcConversationErrorDetector] 
                                                                              mmcErrorCreator:[self mmcErrorCreator] 
                                                              conversationErrorHandlerFactory:[self conversationErrorHandlerFactory]
                                                                                 conversation:theConversation 
                                                                                     delegate:theConversationCreateCommandDelegate];
}

// Public methods
#pragma mark -
#pragma mark Public methods

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YAConversationCreateParsedJSONResponseHandlerCreator ()

@end
