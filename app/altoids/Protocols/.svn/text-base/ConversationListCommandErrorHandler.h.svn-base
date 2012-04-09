//
//  ConversationListCommandErrorHandler.h
//  altoids
//
//  Created by Jon Herron on 11/14/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YAMMCConversation.h"

@protocol ConversationListCommandErrorHandler <NSObject>

#pragma mark -
#pragma mark @required
@required

- (BOOL)mmcConversationHasError:(YAMMCConversation *)theMMCConversation error:(NSError **)anError;
- (void)handleError:(NSError *)theError forMMCConversation:(YAMMCConversation *)theMMCConversation;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
