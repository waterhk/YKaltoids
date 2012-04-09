//
//  YAConversationEditParsedJSONResponseHandlerCreator.m
//  altoids
//
//  Created by Jon Herron on 10/31/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationEditParsedJSONResponseHandlerCreator.h"
#import "YAConversationEditParsedJSONResponseHandler.h"

// Private class extension
@interface YAConversationEditParsedJSONResponseHandlerCreator ()

// @property definitions

// methods

@end

@implementation YAConversationEditParsedJSONResponseHandlerCreator

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize mmcConversationToConversationInfoTranslator = mmcConversationToConversationInfoTranslator_;

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
#pragma mark ConversationEditParsedJSONREsponseHandlerCreator delegate methods

- (id<ConversationEditParsedJSONResponseHandler>)createForConversation:(YAConversation *)theConversation withDelegate:(id<ConversationEditCommandDelegate>)theDelegate
{
    return [[YAConversationEditParsedJSONResponseHandler alloc] initWithMMCConversationToConversationInfoTranslator:[self mmcConversationToConversationInfoTranslator] conversationEditCommandDelegate:theDelegate conversation:theConversation];
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
#pragma mark YAConversationEditParsedJSONResponseHandlerCreator ()

@end
