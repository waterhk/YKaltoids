//
//  ConversationMessageListURLParametersCreator.h
//  altoids
//
//  Created by Jon Herron on 10/11/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YAMessage.h"

@protocol ConversationMessageListURLParametersCreator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (NSDictionary *)urlParametersForConversationMessageListFromMostRecentMessage;
- (NSDictionary *)urlParametersForConversationMessageListFromMessage:(YAMessage *)theMessage;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
