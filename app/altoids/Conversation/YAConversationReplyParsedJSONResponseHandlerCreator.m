//
//  YAConversationReplyParsedJSONResponseHandlerCreator.m
//  altoids
//
//  Created by Anand Biligiri on 10/26/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationReplyParsedJSONResponseHandlerCreator.h"
#import "YAConversationReplyParsedJSONResponseHandler.h"

// Private class extension
@interface YAConversationReplyParsedJSONResponseHandlerCreator ()

// @property definitions
// methods

@end

@implementation YAConversationReplyParsedJSONResponseHandlerCreator

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
// Designated initializer
@synthesize mmcConversationReplyToConversationReplyInfoTranslator = mmcConversationReplyToConversationReplyInfoTranslator_;
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
#pragma mark ConversationReplyParsedJSONResponseHanlderCreator methods
- (id<ConversationReplyParsedJSONResponseHandler>)createWithMessage:(YAMessage *)message
                                                           delegate:(id<ConversationReplyCommandDelegate>)delegate
{
    return [[YAConversationReplyParsedJSONResponseHandler alloc] initWithMessage:(YAMessage *)message
                           mmcConversationReplyToConversationReplyInfoTranslator:[self mmcConversationReplyToConversationReplyInfoTranslator]
                                                                        delegate:delegate];
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
#pragma mark YAConversationReplyParsedJSONResponseHandlerCreator ()

@end
