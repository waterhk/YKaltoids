//
//  YAConversationListURLRequestWithURLParametersBuilder.m
//  altoids
//
//  Created by Jon Herron on 10/7/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationListURLWithURLParametersBuilder.h"

// Private class extension
@interface YAConversationListURLWithURLParametersBuilder ()

// @property definitions

// methods

@end

@implementation YAConversationListURLWithURLParametersBuilder

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize mmcURLCreator = mmcURLCreator_;
@synthesize mmcRelativeURICreator = mmcRelativeURICreator_;

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
#pragma mark ConversationListURLWithURLParametersBuilder delegate methods

- (NSMutableURLRequest *)buildRequestURLWithURLParameters:(NSDictionary *)aURLParameters
{
    return [[NSMutableURLRequest alloc] initWithURL:[[self mmcURLCreator] createMMCURLWithRelativeURI:[[self mmcRelativeURICreator] createRelativeURIToRetrieveConversations] params:aURLParameters]];
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
#pragma mark YAConversationListURLRequestWithURLParametersBuilder ()

@end
