//
//  YAConversationManagementURLWithURLParametersBuilderCreator.m
//  altoids
//
//  Created by Jon Herron on 10/24/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationManagementURLWithURLParametersBuilderCreator.h"
#import "YAConversation.h"
#import "YAConversationManagementURLWithURLParametersBuilder.h"

// Private class extension
@interface YAConversationManagementURLWithURLParametersBuilderCreator ()

// @property definitions

// methods

@end

@implementation YAConversationManagementURLWithURLParametersBuilderCreator

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
#pragma mark ConversationManagementURLWithURLParametersBuilderCreator delegate methods

- (id<ConversationManagementURLWithURLParametersBuilder>)createWithConversation:(YAConversation *)theConversation
{
    return [[YAConversationManagementURLWithURLParametersBuilder alloc] initWithMMCURLCreator:[self mmcURLCreator] mmcRelativeURICreator:[self mmcRelativeURICreator] conversation:theConversation managedObjectContextFactory:[self managedObjectContextFactory]];
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
#pragma mark YAConversationManagementURLWithURLParametersBuilderCreator ()

@end
