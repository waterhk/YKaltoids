//
//  ConversationReplyURLWithURLParametersBuilderCreator.h
//  altoids
//
//  Created by Jon Herron on 10/31/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConversationReplyURLWithURLParametersBuilder.h"
#import "YAConversation.h"

@protocol ConversationReplyURLWithURLParametersBuilderCreator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (id<ConversationReplyURLWithURLParametersBuilder>)createWithConversation:(YAConversation *)theConversation;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
