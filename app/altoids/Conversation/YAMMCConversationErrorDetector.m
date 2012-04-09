//
//  YAMMCConversationErrorDetector.m
//  altoids
//
//  Created by Jon Herron on 11/14/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAMMCConversationErrorDetector.h"

// Private class extension
@interface YAMMCConversationErrorDetector ()

// @property definitions

// methods

@end

@implementation YAMMCConversationErrorDetector

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
#pragma mark MMCConversationErrorDetector delegate methods

- (BOOL)mmcConversationHasErrors:(YAMMCConversation *)theMMCConversation
{
    return [[theMMCConversation errors] count] > 0;
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
#pragma mark YAMMCConversationErrorDetector ()

@end
