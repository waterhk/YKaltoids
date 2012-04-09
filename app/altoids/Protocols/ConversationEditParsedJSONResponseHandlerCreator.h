//
//  ConversationEditParsedJSONResponseHandlerCreator.h
//  altoids
//
//  Created by Jon Herron on 10/31/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConversationEditCommandDelegate.h"
#import "ConversationEditParsedJSONResponseHandler.h"
#import "YAConversation.h"

@protocol ConversationEditParsedJSONResponseHandlerCreator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (id<ConversationEditParsedJSONResponseHandler>)createForConversation:(YAConversation *)theConversation withDelegate:(id<ConversationEditCommandDelegate>)theDelegate;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
