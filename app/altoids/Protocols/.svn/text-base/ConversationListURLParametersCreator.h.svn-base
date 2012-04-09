//
//  ConversationListURLParametersCreator.h
//  altoids
//
//  Created by Jon Herron on 9/30/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YAConversation.h"

@protocol ConversationListURLParametersCreator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (NSDictionary *)urlParametersForConversationListFromMostRecentConversation;
- (NSDictionary *)urlParametersForConversationListFromConversation:(YAConversation *)theConversation;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
