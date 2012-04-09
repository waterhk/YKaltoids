//
//  YAConversationReplyURLWithURLParametersBuilderCreator.m
//  altoids
//
//  Created by Jon Herron on 10/31/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationReplyURLWithURLParametersBuilderCreator.h"
#import "YAConversationReplyURLWithURLParametersBuilder.h"

// Private class extension
@interface YAConversationReplyURLWithURLParametersBuilderCreator ()

// @property definitions

// methods

@end

@implementation YAConversationReplyURLWithURLParametersBuilderCreator

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize mmcURLCreator = mmcURLCreator_;
@synthesize mmcRelativeURICreator = mmcRelativeURICreator_;
@synthesize managedObjectContextFactory = managedObjectContextFactory_;

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
#pragma mark ConversationReplyURLWithURLParametersBuilder delegate methods

- (id<ConversationReplyURLWithURLParametersBuilder>)createWithConversation:(YAConversation *)theConversation
{
    return [[YAConversationReplyURLWithURLParametersBuilder alloc] initWithMMCURLCreator:[self mmcURLCreator] mmcRelativeURICreator:[self mmcRelativeURICreator] conversation:theConversation managedObjectContextFactory:[self managedObjectContextFactory]];
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
#pragma mark YAConversationReplyURLWithURLParametersBuilderCreator ()

@end
