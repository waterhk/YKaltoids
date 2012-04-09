//
//  ConversationCreateCommandDelegate.h
//  altoids
//
//  Created by Jon Herron on 10/6/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YAConversation.h"
#import "YAConversationInfo.h"

@protocol ConversationCreateCommandDelegate <NSObject>

#pragma mark -
#pragma mark @required
@required

- (void)conversationCreated:(YAConversationInfo *)theConversationInfo fromLocalConversationWithObjectID:(NSManagedObjectID *)theObjectID;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
