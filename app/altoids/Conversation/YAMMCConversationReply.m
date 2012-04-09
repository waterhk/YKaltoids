//
//  YAMMCConversationReply.m
//  altoids
//
//  Created by Anand Biligiri on 10/27/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAMMCConversationReply.h"

// Private class extension
@interface YAMMCConversationReply ()

// @property definitions
@property (nonatomic, copy) NSDictionary *parsedJSONConversationReplyResponse;
// methods

@end

@implementation YAMMCConversationReply

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize parsedJSONConversationReplyResponse = parsedJSONConversationReplyResponse_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)initWithParsedJSONConversationReplyResponse:(NSDictionary *)parsedJSONConversationReplyResponse
{
  self = [super init];
  if (self) {
      parsedJSONConversationReplyResponse_ = [parsedJSONConversationReplyResponse copy];
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
#pragma mark <Protocol Name> delegate methods

// Public methods
#pragma mark -
#pragma mark Public methods
- (NSString *)messageId
{
    return [[self parsedJSONConversationReplyResponse] valueForKey:@"mid"];
}

- (NSDate *)timestamp
{
    return [NSDate dateWithTimeIntervalSince1970:[[[self parsedJSONConversationReplyResponse] valueForKey:@"msgTimestamp"] doubleValue]];
}
// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YAMMCConversationReply ()

@end
