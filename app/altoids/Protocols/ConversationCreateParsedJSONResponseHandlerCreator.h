//
//  ConversationCreateParsedJSONResponseHandlerCreator.h
//  altoids
//
//  Created by Jon Herron on 10/4/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConversationCreateCommandDelegate.h"
#import "ConversationCreateParsedJSONResponseHandler.h"
#import "YAConversation.h"

@protocol ConversationCreateParsedJSONResponseHandlerCreator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (id<ConversationCreateParsedJSONResponseHandler>)createWithConversation:(YAConversation *)theConversation 
                                                                 delegate:(id<ConversationCreateCommandDelegate>)theConversationCreateCommandDelegate;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
