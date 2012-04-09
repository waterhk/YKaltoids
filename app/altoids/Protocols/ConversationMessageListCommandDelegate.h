//
//  ConversationMessageListCommandDelegate.h
//  altoids
//
//  Created by Jon Herron on 10/13/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YAConversationInfo.h"

@protocol ConversationMessageListCommandDelegate <NSObject>

#pragma mark -
#pragma mark @required
@required

- (void)messageListRecievedForConversation:(YAConversationInfo *)theConversation;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
