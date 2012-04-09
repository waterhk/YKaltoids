//
//  ConversationURLRequestBuilderCreator.h
//  altoids
//
//  Created by Jon Herron on 10/7/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLRequestBuilder.h"
#import "YAConversation.h"

@protocol ConversationURLRequestBuilderCreator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (id<URLRequestBuilder>)createConversationCreateURLRequestBuilder;
- (id<URLRequestBuilder>)createConversationListURLRequestBuilder;
- (id<URLRequestBuilder>)createConversationMessageListURLRequestBuilderForMessagesInConversation:(YAConversation *)theConversation;
- (id<URLRequestBuilder>)createConversationReplyURLRequestBuilderForReplyingToConversation:(YAConversation *)theConversation;
- (id<URLRequestBuilder>)createConversationEditURLRequestBuilderForEditingConversation:(YAConversation *)theConversation;
- (id<URLRequestBuilder>)urlRequestBuilderToFlagMessagesInConversation:(YAConversation *)conversation;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
