//
//  ConversationReplyCommandDelegate.h
//  altoids
//
//  Created by Jon Herron on 10/24/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YAConversationReplyInfo.h"

@class YAMessage;

@protocol ConversationReplyCommandDelegate <NSObject>

#pragma mark -
#pragma mark @required
@required
- (void)repliedToConversationWithMessage:(YAMessage *)message conversationReplyInfo:(YAConversationReplyInfo *)replyInfo;
/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
