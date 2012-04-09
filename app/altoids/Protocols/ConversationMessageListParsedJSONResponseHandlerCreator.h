//
//  ConversationMessageListParsedJSONResponseHandlerCreator.h
//  altoids
//
//  Created by Jon Herron on 10/18/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConversationMessageListCommandDelegate.h"
#import "ConversationMessageListParsedJSONResponseHandler.h"

@protocol ConversationMessageListParsedJSONResponseHandlerCreator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (id<ConversationMessageListParsedJSONResponseHandler>)createWithDelegate:(id<ConversationMessageListCommandDelegate>)theDelegate;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
