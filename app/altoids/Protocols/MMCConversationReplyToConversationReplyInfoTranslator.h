//
//  MMCConversationReplyToConversationReplyInfoTranslator.h
//  altoids
//
//  Created by Anand Biligiri on 10/27/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YAMMCConversationReply.h"
#import "YAConversationReplyInfo.h"

@protocol MMCConversationReplyToConversationReplyInfoTranslator <NSObject>

#pragma mark -
#pragma mark @required
@required
- (YAConversationReplyInfo *)conversationReplyInfoFromMMCConversationReply:(YAMMCConversationReply *)conversationReply;
/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
