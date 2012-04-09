//
//  YAMessagePredicateCreator.m
//  altoids
//
//  Created by Jon Herron on 10/12/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAMessagePredicateCreator.h"
#import "MessageStatus.h"

#define kPredicateMatchingMessagesByIDFormat @"messageID in %@"
#define kPredicateMatchingMessagesInConversationWithIDFormat @"conversation.conversationID = %@"
#define kPredicateMatchingMessageGapPlaceholders @"status = %@"
#define kPredicateMatchingUnreadMessagesFormat @"read != %@"

// Private class extension
@interface YAMessagePredicateCreator ()

// @property definitions

// methods

@end

@implementation YAMessagePredicateCreator

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
#pragma mark MessagePredicateCreator delegate methods

- (NSPredicate *)predicateMatchingMessagesByID:(NSArray *)theMessageIDs
{
    return [NSPredicate predicateWithFormat:kPredicateMatchingMessagesByIDFormat, theMessageIDs];
}

- (NSPredicate *)predicateMatchingMessageGapPlaceholders
{
    return [NSPredicate predicateWithFormat:kPredicateMatchingMessageGapPlaceholders, [NSNumber numberWithInt:YAMessageStatusGapPlaceholder]];
}

- (NSPredicate *)predicateMatchingMessagesInConversationWithID:(NSString *)theConversationID
{
    return [NSPredicate predicateWithFormat:kPredicateMatchingMessagesInConversationWithIDFormat, theConversationID];
}

- (NSPredicate *)predicateMatchingUnreadMessages
{
    return [NSPredicate predicateWithFormat:kPredicateMatchingUnreadMessagesFormat, [NSNumber numberWithBool:YES]];
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
#pragma mark YAMessagePredicateCreator ()

@end
