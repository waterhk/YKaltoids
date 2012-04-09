//
//  YAConversationURLRequestBuilderCreator.m
//  altoids
//
//  Created by Jon Herron on 10/7/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAConversationURLRequestBuilderCreator.h"

// Private class extension
@interface YAConversationURLRequestBuilderCreator ()

// @property definitions

// methods

@end

@implementation YAConversationURLRequestBuilderCreator

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize conversationCreateURLWithURLParametersBuilder = conversationCreateURLWithURLParametersBuilder_;
@synthesize conversationListURLWithURLParametersBuilder = conversationListURLWithURLParametersBuilder_;
@synthesize conversationMessageListURLWithURLParametersBuilderCreator = conversationMessageListURLWithURLParametersBuilderCreator_;
@synthesize conversationManagementURLWithURLParametersBuilderCreator = conversationManagementURLWithURLParametersBuilderCreator_;
@synthesize conversationReplyURLWithURLParametersBuilderCreator = conversationReplyURLWithURLParametersBuilderCreator_;
@synthesize urlRequestBuilderComposer = urlRequestBuilderComposer_;

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
#pragma mark ConversationURLRequestBuilderCreator delegate methods

- (id<URLRequestBuilder>)createConversationCreateURLRequestBuilder
{
    return [[self urlRequestBuilderComposer] composeStandardPostRequestWithJSONPayloadUsingURLWithURLParametersBuilder:[self conversationCreateURLWithURLParametersBuilder]];
}

- (id<URLRequestBuilder>)createConversationListURLRequestBuilder
{
    return [[self urlRequestBuilderComposer] composeStandardGetRequestUsingURLWithURLParametersBuilder:[self conversationListURLWithURLParametersBuilder]];
}

- (id<URLRequestBuilder>)createConversationMessageListURLRequestBuilderForMessagesInConversation:(YAConversation *)theConversation
{
    return [[self urlRequestBuilderComposer] composeStandardGetRequestUsingURLWithURLParametersBuilder:[[self conversationMessageListURLWithURLParametersBuilderCreator] createWithConversation:theConversation]];
}

- (id<URLRequestBuilder>)createConversationReplyURLRequestBuilderForReplyingToConversation:(YAConversation *)theConversation
{
    return [[self urlRequestBuilderComposer] composeStandardPostRequestWithJSONPayloadUsingURLWithURLParametersBuilder:[[self conversationReplyURLWithURLParametersBuilderCreator] createWithConversation:theConversation]];
}

- (id<URLRequestBuilder>)createConversationEditURLRequestBuilderForEditingConversation:(YAConversation *)theConversation
{
    return [[self urlRequestBuilderComposer] composeStandardPutRequestWithJSONPayloadUsingURLWithURLParametersBuilder:[[self conversationManagementURLWithURLParametersBuilderCreator] createWithConversation:theConversation]];
}

- (id<URLRequestBuilder>)urlRequestBuilderToFlagMessagesInConversation:(YAConversation *)conversation
{
    return [[self urlRequestBuilderComposer] composeStandardPutRequestWithJSONPayloadUsingURLWithURLParametersBuilder:[[self conversationMessageListURLWithURLParametersBuilderCreator]
                                                                                                        createWithConversation:conversation]];
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
#pragma mark YAConversationURLRequestBuilderCreator ()

@end
