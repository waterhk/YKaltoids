//
//  ConversationReplyParsedJSONResponseHandlerCreator.h
//  altoids
//
//  Created by Anand Biligiri on 10/26/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConversationReplyCommandDelegate.h"
#import "ConversationReplyParsedJSONResponseHandler.h"
#import "YAMessage.h"

@protocol ConversationReplyParsedJSONResponseHandlerCreator <NSObject>

#pragma mark -
#pragma mark @required
@required
- (id<ConversationReplyParsedJSONResponseHandler>)createWithMessage:(YAMessage *)message
                                                           delegate:(id<ConversationReplyCommandDelegate>)delegate;
/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
