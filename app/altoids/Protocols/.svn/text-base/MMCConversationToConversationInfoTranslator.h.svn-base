//
//  MMCConversationToConversationInfoTranslator.h
//  altoids
//
//  Created by Jon Herron on 9/19/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YAConversationInfo.h"
#import "YAMMCConversation.h"

@protocol MMCConversationToConversationInfoTranslator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (YAConversationInfo *)conversationInfoFromMMCConversation:(YAMMCConversation *)anMMCConversation;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
