//
//  ConversationListParsedJSONResponseHandlerCreator.h
//  altoids
//
//  Created by Jon Herron on 9/20/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConversationListCommandDelegate.h"
#import "ConversationListParsedJSONResponseHandler.h"

@protocol ConversationListParsedJSONResponseHandlerCreator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (id<ConversationListParsedJSONResponseHandler>)createWithDelegate:(id<ConversationListCommandDelegate>)aConversationListCommandDelegate;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
