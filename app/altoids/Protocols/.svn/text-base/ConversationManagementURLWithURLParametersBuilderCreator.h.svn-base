//
//  ConversationManagementURLWithURLParametersBuilderCreator.h
//  altoids
//
//  Created by Jon Herron on 10/24/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConversationManagementURLWithURLParametersBuilder.h"
#import "YAConversation.h"

@protocol ConversationManagementURLWithURLParametersBuilderCreator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (id<ConversationManagementURLWithURLParametersBuilder>)createWithConversation:(YAConversation *)theConversation;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
