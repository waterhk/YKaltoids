//
//  ConversationValidator.h
//  altoids
//
//  Created by Jon Herron on 8/29/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YAConversation.h"

@protocol ConversationValidator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (BOOL)conversationIsValid:(YAConversation *)aConversation error:(NSError **)anError;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
