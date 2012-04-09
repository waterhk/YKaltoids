//
//  MMCURLParametersCreator.h
//  altoids
//
//  Created by Jon Herron on 10/4/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConversationCreateURLParametersCreator.h"
#import "ConversationMessageListURLParametersCreator.h"
#import "ConversationListURLParametersCreator.h"
#import "ConversationReplyURLParametersCreator.h"
#import "MessageStatusURLParametersCreator.h"
#import "ConversationEditURLParametersCreator.h"
#import "DeactivationURLParametersCreator.h"

@protocol MMCURLParametersCreator <ConversationCreateURLParametersCreator, ConversationListURLParametersCreator, ConversationMessageListURLParametersCreator, ConversationReplyURLParametersCreator, MessageStatusURLParametersCreator, ConversationEditURLParametersCreator, DeactivationURLParametersCreator>

#pragma mark -
#pragma mark @required
@required

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
