//
//  YAMMCConversationReplyToConversationReplyInfoTranslator.m
//  altoids
//
//  Created by Anand Biligiri on 10/27/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAMMCConversationReplyToConversationReplyInfoTranslator.h"

// Private class extension
@interface YAMMCConversationReplyToConversationReplyInfoTranslator ()

// @property definitions

// methods

@end

@implementation YAMMCConversationReplyToConversationReplyInfoTranslator

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)init
{
  self = [super init];
  if (self) {
    // Initialization code here.
  }
  
  return self;
}

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark MMCConversationReplyToConversationReplyInfoTranslator methods
- (YAConversationReplyInfo *)conversationReplyInfoFromMMCConversationReply:(YAMMCConversationReply *)conversationReply
{
    return [[YAConversationReplyInfo alloc] initWithMessageId:[conversationReply messageId]
                                                         date:[conversationReply timestamp]];
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
#pragma mark YAMMCConversationReplyToConversationReplyInfoTranslator ()

@end
