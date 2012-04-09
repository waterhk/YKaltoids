//
//  YAConversationReplyRequestDataBuilder.m
//  altoids
//
//  Created by Jon Herron on 10/24/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationReplyRequestDataBuilder.h"

#define kMessageBodyKey @"message"

// Private class extension
@interface YAConversationReplyRequestDataBuilder ()

// @property definitions

// methods

@end

@implementation YAConversationReplyRequestDataBuilder

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
#pragma mark ConversationReplyRequestDataBuilder delegate methods

- (NSDictionary *)requestDataForReplyingToConversationWithMessageBody:(NSString *)theMessageBody
{
    return [NSDictionary dictionaryWithObject:theMessageBody forKey:kMessageBodyKey];
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
#pragma mark YAConversationReplyRequestDataBuilder ()

@end
