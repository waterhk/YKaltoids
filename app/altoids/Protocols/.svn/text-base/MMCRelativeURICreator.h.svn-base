//
//  MMCRelativeURICreator.h
//  altoids
//
//  Created by Jon Herron on 10/11/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YAConversation.h"

@protocol MMCRelativeURICreator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (NSString *)createRelativeURIToCreateConversation;
- (NSString *)createRelativeURIToRetrieveConversations;
- (NSString *)createRelativeURIToRetrieveMessagesInConversation:(YAConversation *)theConversation;
- (NSString *)createRelativeURIToManageConversation:(YAConversation *)theConversation;
- (NSString *)createRelativeURIToReplyToConversation:(YAConversation *)theConversation;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
