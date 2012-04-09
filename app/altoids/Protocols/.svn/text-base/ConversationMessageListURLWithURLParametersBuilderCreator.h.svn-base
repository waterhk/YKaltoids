//
//  ConversationMessageListURLWithURLParametersBuilderCreator.h
//  altoids
//
//  Created by Jon Herron on 10/12/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConversationMessageListURLWithURLParametersBuilder.h"
#import "YAConversation.h"

@protocol ConversationMessageListURLWithURLParametersBuilderCreator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (id<ConversationMessageListURLWithURLParametersBuilder>)createWithConversation:(YAConversation *)theConversation;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
